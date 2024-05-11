import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../controller/AccountController.dart';

import 'package:flutter/material.dart';

import 'dialog.dart';

class MySliverDetail extends GetView<AccountController> {
  const MySliverDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "闲置:",
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  SizedBox(width: 10),
                  Obx(
                    () => Text(
                      controller.free.length.toString(),
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "抢票中:",
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  SizedBox(width: 10),
                  Obx(
                    () => Text(
                      controller.waiting.length.toString(),
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "待支付:",
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  SizedBox(width: 10),
                  Obx(
                    () => Text(
                      controller.pending.length.toString(),
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return DeleteBatchDialog(content: "删除所有账号", status: "free, waiting, pending");
                    });
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("删除所有账号"),
                    const SizedBox(width: 4.0),
                    Icon(
                      Icons.delete,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8.0),
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return DeleteBatchDialog(content: "删除闲置账号", status: "free");
                    });
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("删除闲置账号"),
                    const SizedBox(width: 4.0),
                    Icon(
                      Icons.delete,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
