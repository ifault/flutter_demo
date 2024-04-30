import 'package:Ticket/controller/AccountController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MySliverAppBar extends GetView<AccountController> {
  final Widget child;
  final Widget title;

  const MySliverAppBar({super.key, required this.child, required this.title});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        expandedHeight: 200,
        collapsedHeight: 90,
        floating: false,
        pinned: true,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text(
          "迪士尼账号",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        actions: [
          Obx(() => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    IconButton(
                        icon: Icon(controller.isMonitoring.value
                            ? Icons.stop_circle
                            : Icons.play_circle),
                        onPressed: () {
                          if (controller.isMonitoring.value) {
                            controller.stopMonitor();
                          } else {
                            controller.startMonitor();
                          }
                        }),
                    Visibility(
                        visible: controller.isMonitoring.value,
                        child: const CupertinoActivityIndicator())
                  ],
                ),
              ))
        ],
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        flexibleSpace: FlexibleSpaceBar(
          background: Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: child,
          ),
          centerTitle: true,
          title: title,
          titlePadding: const EdgeInsets.only(left: 0, top: 0, right: 0),
          expandedTitleScale: 1,
        ));
  }
}
