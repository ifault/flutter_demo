import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class RouteAuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final box = GetStorage();
    var token = box.read("token");
    if (token == null) {
      return const RouteSettings(name: "/login");
    }
    // if(box.read("token") == null){
    //   Get.snackbar("提示", "请先登录APP");
    //   return const RouteSettings(name: "/login");
    // }
    // if(token.isEmpty) {
    //   Get.snackbar("提示", "请先登录APP");
    //   return RouteSettings(name: "/login");
    // }
    return null;
  }
// @override
// RouteSettings? redirect(String route) {
//   // Future.delayed(Duration(seconds: 1), () => Get.snackbar("提示", "请先登录APP"));
//   return RouteSettings(name: AppRoutes.Login);
// }
}
