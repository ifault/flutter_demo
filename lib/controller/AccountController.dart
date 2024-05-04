import 'dart:convert';

import 'package:Ticket/model/response.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get_storage/get_storage.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import '../common/notification.dart';
import '../model/accounts.dart';
import '../repository/repository.dart';
import 'package:tobias/tobias.dart' ;
class AccountController extends GetxController {
  Accounts accounts = Accounts(free: [], waiting: [], pending: []);
  RxBool isMonitoring = false.obs;
  final box = GetStorage();
  final List<String> tabs = ['闲置', '待抢票', '待支付'];
  final repository = Get.find<Repository>();
  RxList free = [].obs;
  RxList waiting = [].obs;
  RxList pending = [].obs;
  WebSocketChannel? wsChannel;
  RxString server = "".obs;
  RxString password = "".obs;
  final MyNotificaiton notification = Get.find();
  @override
  onInit() async {
    fetchAccounts();
    loadStorage();
    super.onInit();
  }

  Future<void> loadStorage() async{
    server.value = box.read("server");
    password.value = box.read("password");
  }

  List<String> getTabs() {
    return ['闲置', '待支付'];
  }

  Future<void> fetchAccounts() async {
    Accounts a = await repository.getAccounts();
    free.clear();
    waiting.clear();
    pending.clear();
    free.addAll(a.free);
    waiting.addAll(a.waiting);
    pending.addAll(a.pending);
    update();
  }

  final String baseWsUrl = "ws://10.0.2.2:1234/ws/";

  Future<void> _startMonitoring() async {
    final wsUrl = Uri.parse('$baseWsUrl?token=${box.read("token").toString()}');
    final channel = WebSocketChannel.connect(wsUrl);
    await channel.ready;
    wsChannel = channel;
    channel.stream.listen((message) {
      WsResponse res = WsResponse.fromMap(jsonDecode(message));
      if (res.code == -1) {
        channel.sink.close(status.goingAway);
        EasyLoading.showInfo(res.message);
        isMonitoring.value = false;
      }
      if(res.code == 1){
        notification.notity("抢票软件", res.message);
      }
    }, onDone: () {}, onError: (error) {});
  }

  Future<void> startMonitor() async {
    isMonitoring.value = true;
    await _startMonitoring();
  }

  Future<void> stopMonitor() async {
    if (wsChannel != null) {
      wsChannel!.sink.close(status.goingAway);
    }
    isMonitoring.value = false;

    // await repository.startMonitoring();
  }

  void success(){
    EasyLoading.dismiss();
    fetchAccounts();
  }

  Future<void> addAccount(String username) async {
    await repository.addAccount(username, success);
  }

  Future<void> deleteAccount(String uuid) async {
    await repository.deleteAccount(uuid, success);
  }

  Future<void> deleteAccounts(String status) async {
    await repository.deleteAccounts(status, success);
  }

  Future<void> updateAccountStatus(String uuid, String status) async {
    await repository.updateAccountStatus(uuid, status, success);
  }

  Future<void> bindMorningCard(String uuid, String card) async {
    MyResponse response = await repository.bindMorningCard(uuid, card);
    update();
  }

  Future<bool> login(String username, String password) async {
    MyResponse response = await repository.login(username, password);
    if (response.success) {
      box.write("token", response.token);
      return true;
    } else {
      EasyLoading.showError(response.message);
    }
    return false;
  }

  Future<void> pay(Account account) async {
    Tobias tobias = Tobias();
    String order = "2019102968731767&biz_content=%7B%22out_trade_no%22%3A%2220240504050100068406%22%2C%22product_code%22%3A%22QUICK_MSECURITY_PAY%22%2C%22total_amount%22%3A%22475.00%22%2C%22subject%22%3A%22%E4%B8%8A%E6%B5%B7%E8%BF%AA%E5%A3%AB%E5%B0%BC%E5%BA%A6%E5%81%87%E5%8C%BA%E4%BA%A7%E5%93%81%22%2C%22passback_params%22%3A%2216183625%22%2C%22timeout_express%22%3A%2229m%22%2C%22extend_params%22%3A%7B%22sys_service_provider_id%22%3A%222088121850549630%22%7D%7D&charset=utf-8&method=alipay.trade.app.pay&notify_url=https%3A%2F%2Fprod.origin-pmw.shanghaidisneyresort.com%2Fglobal-pool-override-A%2Fpayment-middleware-service%2Ftransaction%2Falipay%2Fconfirm%2F16183625&sign=Bx4xV%2FqEtCSBeQdjd%2ByaVX5xdzCLUVYrEcQ%2Bd4i0pdeHscva2YUBwDn6E5NJl3Pk5gaQ81znjwBSdJRnPZyXd8P7FEuCqpXTVJe0bDlAoNJrvAIYsr6N3SKcXtpV3Jvrjst16WmF7%2FP7sVwb8XHsFIuEZxBw30vBnagnoE6MKXLSqmr8ZFaAcQRrr%2FABWD3aBb%2BQ6B3p66tmlWzLlGU6lBMuBMXEpymKM7D8Uuql%2BUH0LiED%2B3%2BHWO5EvvrdcPXwyDCGS6cTigXKjcLLmaVXn7gKU%2Bki2kGzifyYVWwzSv464BLvo8PWBAT9EpJt%2FGX1I6m66SHndp%2BKkU74fTH6wQ%3D%3D&sign_type=RSA2&timestamp=2024-05-04+11%3A26%3A40&version=1.0";
    tobias.pay(order).then((value) async {
      if (value['resultStatus'] == 9000 || value['resultStatus'] == '9000') {
        await repository.pay(account.uuid);
      }else{
        EasyLoading.showError("支付失败");
      }
    });
  }

  Future<bool> saveSetting(String server, String password) async {
    box.write("server", server);
    box.write("password", password);
    return true;
  }

  Future<void> signOut() async {
    box.remove("token");
  }
}
