import "dart:convert";

import "package:dio/dio.dart";
import "package:flutter_easyloading/flutter_easyloading.dart";
import "package:get/get.dart";
import "package:get_storage/get_storage.dart";
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';
import "../model/accounts.dart";
import "../model/response.dart";
import "inteceptor.dart";

class Repository {
  final box = GetStorage();
  final RxString baseUrl = "".obs;
  final RxString baseWsUrl = "".obs;
  final String taobaoUrl = "http://rap2api.taobao.org/app/mock/318632";

  Repository(){
    // 10.0.2.2:1234
  }

  Future<Dio> getClient(bool addToken) async {
    baseUrl.value = "http://${box.read('server')}:1234";
    baseWsUrl.value = "ws://${box.read('server')}:1234/ws";
    Dio dio = Dio();
    if (addToken) {
      dio.interceptors.add(MyAuthInterceptor());
    }
    dio.interceptors.add(MyLoggingInterceptor());
    return dio;
  }

  Future<Accounts> getAccounts() async {
    return getClient(true).then((client) {
      return client.get("$taobaoUrl/api/accounts").then((response) {
        if (response.statusCode == 200) {
          return Accounts.fromMap(response.data);
        } else {
          return Accounts(free: [], waiting: [], pending: []);
        }
      });
    });
  }

  Future<MyResponse> addAccount(String username) async {
    var response = await Future.delayed(Duration(seconds: 5));
    if (response.statusCode == 200) {
      return MyResponse.fromMap(response.data);
    } else {
      return MyResponse(success: false, message: "添加失败", token: "");
    }
  }

  Future<MyResponse> deleteAccount(String uuid) async {
    var response = await Future.delayed(Duration(seconds: 5));
    if (response.statusCode == 200) {
      return MyResponse.fromMap(response.data);
    } else {
      return MyResponse(success: false, message: "删除失败", token: "");
    }
  }

  Future<MyResponse> deleteAccounts(String status) async {
    var response = await Future.delayed(Duration(seconds: 5));
    if (response.statusCode == 200) {
      return MyResponse.fromMap(response.data);
    } else {
      return MyResponse(success: false, message: "删除失败", token: "");
    }
  }

  Future<MyResponse> updateAccountStatus(String uuid, String status) async {
    var response = await Future.delayed(Duration(seconds: 5));
    if (response.statusCode == 200) {
      return MyResponse.fromMap(response.data);
    } else {
      return MyResponse(success: false, message: "更新失败", token: "");
    }
  }

  Future<MyResponse> bindMorningCard(String uuid, String card) async {
    var response = await Future.delayed(Duration(seconds: 5));
    if (response.statusCode == 200) {
      return MyResponse.fromMap(response.data);
    } else {
      return MyResponse(success: false, message: "绑定失败", token: "");
    }
  }

  Future<MyResponse> login(String username, String password) async {
    var client = await getClient(false);
    return client.post("$baseUrl/api/login",
        data: {"username": username, "password": password}).then((response) {
      if (response.statusCode == 200) {
        return MyResponse.fromMap(response.data);
      } else {
        return MyResponse(success: false, message: "登录失败", token: "");
      }
    });
  }

  Future<void> pay(String uuid) async{
    await Future.delayed(Duration(seconds: 5));
  }
}
