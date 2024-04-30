import 'package:Ticket/controller/AccountController.dart';
import 'package:Ticket/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../widgets/my_button.dart';
import '../widgets/my_textfield.dart';

class LoginPage extends GetView<AccountController> {
  final void Function()? onTap;

  LoginPage({super.key, this.onTap});

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void setting() async {
    Get.toNamed("/setting");
  }

  void login() async {
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      EasyLoading.showInfo("用户名和密码不能为空");
      return;
    }
    EasyLoading.show(status: "登录中...");
    await controller
        .login(usernameController.text, passwordController.text)
        .then((success) {
      if (success) {
        EasyLoading.dismiss();
        Get.to(HomePage());
      } else {
        EasyLoading.showError("登录失败，请检查用户名和密码");
      }
    }).onError((error, stackTrace) {
      EasyLoading.dismiss();
      EasyLoading.showError("服务器异常，检查服务器地址是否正确");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // logo
              Icon(Icons.lock_open_rounded,
                  size: 100, color: Theme.of(context).colorScheme.primary),
              SizedBox.fromSize(size: const Size(0, 20)),
              Text("姜楠专属抢票软件",
                  style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.secondary)),
              SizedBox.fromSize(size: const Size(0, 20)),
              MyTextField(
                  controller: usernameController,
                  hintText: "用户名",
                  obscureText: false),
              MyTextField(
                  controller: passwordController,
                  hintText: "密 码",
                  obscureText: true),
              SizedBox.fromSize(size: const Size(0, 20)),
              MyButton(onTap: login, text: "登录"),
              MyButton(onTap: setting, text: "配置")
            ],
          ),
        ));
  }
}
