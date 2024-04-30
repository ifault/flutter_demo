import 'package:Ticket/controller/AccountController.dart';
import 'package:Ticket/model/accounts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyTabbar extends GetView<AccountController> {
  final TabController tabController;

  MyTabbar({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    List<Tab> getTabs() {
      return controller.tabs.map((tabText) {
        return Tab(
          text: tabText,
        );
      }).toList();
    }

    return TabBar(
          controller: tabController,
          tabs: getTabs(),
        );
  }
}
