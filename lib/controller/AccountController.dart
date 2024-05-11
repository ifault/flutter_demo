import 'dart:convert';
import 'dart:math';

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
  Accounts accounts = Accounts();
  RxBool isMonitoring = false.obs;
  final box = GetStorage();
  final List<String> tabs = ['闲置', '抢票中', '待支付'];
  final repository = Get.find<Repository>();
  RxList free = [].obs;
  RxList waiting = [].obs;
  RxList pending = [].obs;
  WebSocketChannel? wsChannel;
  RxString server = "".obs;
  RxString password = "".obs;
  RxString email = "".obs;
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

  Future<void> fetchSettings() async{
    server.value = box.read("server");
    password.value = box.read("password");
    email.value = box.read("email");
  }

  Future<void> fetchAccounts() async {
    Accounts a = await repository.getAccounts();
    free.clear();
    waiting.clear();
    pending.clear();
    free.addAll(a.data!.free ??[]);
    waiting.addAll(a.data!.waiting ??[]);
    pending.addAll(a.data!.pending ?? []);
    update();
    EasyLoading.dismiss();
  }

  final String baseWsUrl = "ws://10.0.2.2:8000/ws/";

  Future<void> _startMonitoring() async {
    String serverUrl = box.read('server').toString();
    if(!serverUrl.contains("http")){
      serverUrl = "ws://${box.read('server')}/ws";
    }else{
      String wsAddress = serverUrl.split("//")[1];
      serverUrl = "ws://$wsAddress/ws";
    }
    final wsUrl = Uri.parse('$serverUrl/${box.read("token").toString()}');
    final channel = WebSocketChannel.connect(wsUrl);
    await channel.ready;
    EasyLoading.showInfo("开始监听服务消息");
    wsChannel = channel;
    channel.stream.listen((message) {
      WsResponse res = WsResponse.fromMap(jsonDecode(message));
      if (res.code == -1) {
        channel.sink.close(status.goingAway);
        EasyLoading.showInfo(res.message);
        isMonitoring.value = false;
      }
      if(res.code == 0){
        notification.notity("抢票软件", res.message);
        fetchAccounts();
      }
    }, onDone: () {
    }, onError: (error) {
    });
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

  void success(bool? success, String? message){
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

  Future<void> stopMonitorAccount(String uuid, String taskId) async {
    await repository.stopMonitorAccount(uuid, taskId, success);
  }

  Future<void> startMonitorAccount(String uuid) async {
    await repository.startMonitorAccount(uuid, success);
  }

  Future<void> bindMorningCard(String uuid, String card) async {
    MyResponse response = await repository.bindMorningCard(uuid, card);
    update();
  }

  Future<bool> login(String username, String password) async {
    MyResponse response = await repository.login(username, password);
    if (response.success ?? false) {
      box.write("token", response.data?.token);
      box.write("userId", response.data?.userId);
      return true;
    } else {
      EasyLoading.showError(response.message ?? "");
    }
    return false;
  }

  Future<void> pay(Account account) async {
    Tobias tobias = Tobias();
    List<int> decodedBytes = base64Decode(account.order!);
    String decodedString = String.fromCharCodes(decodedBytes);
    tobias.pay(decodedString).then((value) async {
      if (value['resultStatus'] == 9000 || value['resultStatus'] == '9000') {
        await repository.pay(account.uuid??"");
        fetchAccounts();
      }else{
        EasyLoading.showError("支付失败");
      }
    });
  }

  Future<bool> saveSetting(String server, String password, String email) async {
    box.write("server", server);
    box.write("password", password);
    box.write("email", email);
    return true;
  }

  Future<void> signOut() async {
    box.remove("token");
  }
}
