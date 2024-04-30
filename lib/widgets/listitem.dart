import 'package:Ticket/controller/AccountController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/accounts.dart';
import 'dialog.dart';

class MyListItem extends GetView<AccountController> {
  Account account;
  String status;

  MyListItem({super.key, required this.account, required this.status});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          border: Border(
            left: BorderSide(
              color: CupertinoColors.systemGrey4,
              width: 1,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: CupertinoColors.systemGrey6,
              blurRadius: 5.0, // 设置阴影的模糊半径
              offset: Offset(0, 0.5), // 设置阴影偏移量
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "账号: ${account.username}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    account.details,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Visibility(
                      visible: status == "free" || status == "waiting",
                      child: IconButton(
                        icon: const Icon(CupertinoIcons.delete,),
                        onPressed: () {
                          showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const DeleteDialog();
                          });
                        },
                      ),
                    ),
                    Visibility(
                      visible: status == "waiting",
                      child: IconButton(
                        icon: const Icon(CupertinoIcons.back,),
                        onPressed: () {
                          showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const BackToFreeDialog();
                          });
                        },
                      ),
                    ),
                    Visibility(
                      visible: status == "free",
                      child: IconButton(
                        icon: const Icon(CupertinoIcons.alarm),
                        onPressed: () {
                          showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const AddToWaitingDialog();
                          });
                        },
                      ),
                    ),
                    Visibility(
                      visible: status == "free",
                      child: IconButton(
                        icon: const Icon(
                            CupertinoIcons.arrow_up_arrow_down_circle),
                        onPressed: () {
                          showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const BindGALDialog();
                      },
                    );
                        },
                      ),
                    ),
                    Visibility(
                      visible: status == "pending",
                      child: IconButton(
                        icon: const Icon(CupertinoIcons.money_dollar_circle),
                        onPressed: () {},
                      ),
                    ),
                  ])
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
