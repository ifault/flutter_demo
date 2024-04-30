import 'package:Ticket/controller/AccountController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../pages/login.dart';
import '../pages/setting.dart';
import 'drawer_tile.dart';

class MyDrawer extends GetView<AccountController> {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Icon(
            Icons.lock_open_rounded,
            size: 80,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Divider(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        MyDarwerTile(
          text: "主页",
          icon: Icons.home,
          onTap: () {
            Navigator.pop(context);
          },
        ),
        MyDarwerTile(
          text: "设置",
          icon: Icons.settings,
          onTap: () {
            Navigator.pop(context);
            Get.to(SettingPage());
          },
        ),
        MyDarwerTile(
          text: "登录",
          icon: Icons.settings,
          onTap: () {
            Navigator.pop(context);
            Get.to(LoginPage());
          },
        ),
        const Spacer(),
        MyDarwerTile(
          text: "退出",
          icon: Icons.logout,
          onTap: () {
            controller.signOut();
            Navigator.pop(context);
            Get.to(LoginPage());
          },
        ),
      ]),
    );
  }
}
