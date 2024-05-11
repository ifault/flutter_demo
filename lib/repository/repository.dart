import "dart:convert";

import "package:dio/dio.dart";
import "package:flutter_easyloading/flutter_easyloading.dart";
import "package:get/get.dart";
import "package:get_storage/get_storage.dart";
import "../model/accounts.dart";
import "../model/response.dart";
import "inteceptor.dart";

class Repository {
  final box = GetStorage();
  final RxString baseUrl = "".obs;
  final RxString baseWsUrl = "".obs;

  Repository() {
    // 10.0.2.2:1234
    // 192.168.3.194
  }

  Future<Dio> getClient(bool addToken) async {
    String serverUrl = box.read('server').toString();
    if(!serverUrl.contains("http")){
      baseUrl.value = "http://${box.read('server')}";
      baseWsUrl.value = "ws://${box.read('server')}/ws";
    }else{
      baseUrl.value = serverUrl;
      String wsAddress = serverUrl.split("//")[1];
      baseWsUrl.value = "ws://$wsAddress/ws";
    }
    Dio dio = Dio();
    if (addToken) {
      dio.interceptors.add(MyAuthInterceptor());
    }
    dio.interceptors.add(MyLoggingInterceptor());
    return dio;
  }

  Future<Accounts> getAccounts() async {
    return getClient(true).then((client) {
      return client.get("$baseUrl/api/accounts").then((response) {
        if (response.statusCode == 200) {
          return Accounts.fromMap(response.data);
        } else {
          return Accounts();
        }
      });
    });
  }

  Future<MyResponse> addAccount(String username, Function success) async {
    var client = await getClient(true);
    var password = box.read('password');
    return client.post("$baseUrl/api/account", data: {
      "username": username,
      "password": password.toString()
    }).then((response) {
      if (response.statusCode == 200) {
        var res = MyResponse.fromMap(response.data);
        success(res.success, res.message);
        return res;
      } else {
        EasyLoading.showError("添加失败");
        return MyResponse(success: false, message: "添加失败");
      }
    }).onError((error, stackTrace) {
      EasyLoading.showError("服务异常");
      return MyResponse(success: false, message: "添加失败");
    });
  }

  Future<MyResponse> deleteAccount(String uuid, Function success) async {
    var client = await getClient(true);
    return client.post("$baseUrl/api/account/delete",
        data: {"uuid": uuid}).then((response) {
      if (response.statusCode == 200) {
        var res = MyResponse.fromMap(response.data);
        success(res.success, res.message);
        return res;
      } else {
        EasyLoading.showError("删除失败");
        return MyResponse(success: false, message: "删除失败");
      }
    }).onError((error, stackTrace) {
      EasyLoading.showError("服务异常");
      return MyResponse(success: false, message: "删除失败");
    });
  }

  Future<MyResponse> deleteAccounts(String status, Function success) async {
    var client = await getClient(true);
    return client.post("$baseUrl/api/account/delete",
        data: {"status": status}).then((response) {
      if (response.statusCode == 200) {
        var res = MyResponse.fromMap(response.data);
        success(res.success, res.message);
        return res;
      } else {
        EasyLoading.showError("删除失败");
        return MyResponse(success: false, message: "删除失败");
      }
    }).onError((error, stackTrace) {
      EasyLoading.showError("服务异常");
      return MyResponse(success: false, message: "删除失败");
    });
  }

  Future<MyResponse> updateAccountStatus(
      String uuid, String status, Function success) async {
    var client = await getClient(true);
    return client.post("$baseUrl/api/account/status",
        data: {"uuid": uuid, "status": status}).then((response) {
      if (response.statusCode == 200) {
        var res = MyResponse.fromMap(response.data);
        success(res.success, res.message);
        return res;
      } else {
        EasyLoading.showError("更改失败");
        return MyResponse(success: false, message: "更改失败");
      }
    }).onError((error, stackTrace) {
      EasyLoading.showError("服务异常");
      return MyResponse(success: false, message: "更改失败");
    });
  }

  Future<MyResponse> stopMonitorAccount(
      String uuid, String taskId, Function success) async {
    var client = await getClient(true);
    return client.post("$baseUrl/api/account/stop",
        data: {"uuid": uuid, "task_id": taskId}).then((response) {
      var res = MyResponse.fromMap(response.data);
      success(res.success, res.message);
      return res;
    }).onError((error, stackTrace) {
      EasyLoading.showError("服务异常");
      return MyResponse(success: false, message: "服务异常");
    });
  }

  Future<MyResponse> startMonitorAccount(String uuid, Function success) async {
    var client = await getClient(true);
    return client.post("$baseUrl/api/account/start", data: {"uuid": uuid}).then(
        (response) {
      var res = MyResponse.fromMap(response.data);
      success(res.success, res.message);
      return res;
    }).onError((error, stackTrace) {
      EasyLoading.showError("服务异常");
      return MyResponse(success: false, message: "服务异常");
    });
  }

  Future<MyResponse> bindMorningCard(String uuid, String card) async {
    var response = await Future.delayed(Duration(seconds: 5));
    return response.data as MyResponse;
  }

  Future<MyResponse> login(String username, String password) async {
    var client = await getClient(false);
    return client.post("$baseUrl/api/login",
        data: {"username": username, "password": password}).then((response) {
      if (response.statusCode == 200) {
        return MyResponse.fromMap(response.data);
      } else {
        return MyResponse(success: false, message: "登录失败");
      }
    });
  }

  Future<void> pay(String uuid) async {
    var client = await getClient(true);
    client.post("$baseUrl/api/account/pay", data: {"uuid": uuid}).then((response) {
      if (response.statusCode == 200) {
        return MyResponse.fromMap(response.data);
      } else {
        return MyResponse(success: false, message: "登录失败");
      }
    }).onError((error, stackTrace) {
      EasyLoading.showError("服务异常");
      return MyResponse(success: false, message: "登录失败");
    });
  }
}
