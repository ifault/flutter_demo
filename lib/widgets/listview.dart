import 'package:Ticket/controller/AccountController.dart';
import 'package:Ticket/widgets/listitem.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyListView extends GetView<AccountController> {
  final RxList accounts;
  final String status;

  const MyListView({super.key, required this.accounts, required this.status});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(onRefresh: () async {
      await controller.fetchAccounts();
    }, child: Obx(() {
      return ListView.builder(
        itemCount: accounts.length,
        itemBuilder: (context, index) {
          return MyListItem(account: accounts[index], status: status);
          // if (accounts.isNotEmpty) {
          //   return MyListItem(account: accounts[index], status: status);
          // } else {
          //   return const Center(
          //     child: Text(
          //       '没有数据可显示',
          //       style: TextStyle(fontSize: 20, color: Colors.red),
          //     ),
          //   );
          // }
        },
      );
    }));
  }
}
