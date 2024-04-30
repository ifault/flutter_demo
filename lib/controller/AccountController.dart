import 'dart:convert';

import 'package:Ticket/model/response.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get_storage/get_storage.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import '../model/accounts.dart';
import '../repository/Repository.dart';

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
      // if (res.code == -1) {
      //   channel.sink.close(status.goingAway);
      //   EasyLoading.showInfo(res.message);
      //   isMonitoring.value = false;
      // }
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

  Future<void> addAccount(String username) async {
    await repository.addAccount(username);
    update();
  }

  Future<void> deleteAccount(String uuid) async {
    MyResponse response = await repository.deleteAccount(uuid);
    update();
  }

  Future<void> deleteAccounts(String status) async {
    MyResponse response = await repository.deleteAccounts(status);
    update();
  }

  Future<void> updateAccountStatus(String uuid, String status) async {
    MyResponse response = await repository.updateAccountStatus(uuid, status);
    update();
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

  Future<void> pay(String uuid) async {
    await repository.pay(uuid);
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
