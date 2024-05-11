import 'package:Ticket/controller/AccountController.dart';
import 'package:Ticket/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class SettingPage extends GetView<AccountController> {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    controller.fetchSettings();
    TextEditingController serverController = TextEditingController();
    serverController.text = controller.server.value;
    TextEditingController passController = TextEditingController();
    passController.text = controller.password.value;
    TextEditingController mailController = TextEditingController();
    mailController.text = controller.email.value;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('设置'),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(10),
            ),
            child:  TextField(controller: serverController, obscureText: false, decoration: InputDecoration(
              hintText: "服务器地址",
              hintStyle: TextStyle(
                color: Theme.of(context).colorScheme.primary
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary
                )
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary
                )
              )
            )),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(10),
            ),
            child:  TextField(controller: passController, obscureText: false, decoration: InputDecoration(
              hintText: "统一账号密码",
              hintStyle: TextStyle(
                color: Theme.of(context).colorScheme.primary
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary
                )
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary
                )
              )
            )),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(10),
            ),
            child:  TextField(controller: mailController, obscureText: false, decoration: InputDecoration(
                hintText: "通知邮件",
                hintStyle: TextStyle(
                    color: Theme.of(context).colorScheme.primary
                ),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary
                    )
                ),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary
                    )
                )
            )),
          ),
          MyButton(onTap: (){
            EasyLoading.show(status: "保存中");
            controller.saveSetting(serverController.text,passController.text, mailController.text).then((value){
              EasyLoading.dismiss();
              EasyLoading.showSuccess("保存成功");
            });
          }, text: "保存")
        ],
      ),
    );
  }
}
