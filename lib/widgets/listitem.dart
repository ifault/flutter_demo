import 'package:Ticket/controller/AccountController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../common/notification.dart';
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
        margin: const EdgeInsets.all(2.0),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(

          border: Border.all(
            color: Colors.grey, // 设置边框颜色
            width: 1.0, // 设置边框宽度
          ),
          boxShadow: const [
            BoxShadow(
              color: CupertinoColors.white,
              blurRadius: 5.0, // 设置阴影的模糊半径
              offset: Offset(0, 0.5), // 设置阴影偏移量
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                        "下单时间: ${account.order_time}",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "详情: ${account.details??''}",
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),

                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Visibility(
                      visible: true,
                      child: IconButton(
                        icon: const Icon(CupertinoIcons.delete,),
                        onPressed: () {
                          showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return DeleteDialog(account.uuid);
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
                            return BackToFreeDialog(account.uuid);
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
                            return AddToWaitingDialog(account.uuid);
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
                        onPressed: () {
                          controller.pay(account);
                        },
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
