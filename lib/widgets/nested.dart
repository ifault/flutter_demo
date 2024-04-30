import 'package:Ticket/controller/AccountController.dart';
import 'package:Ticket/widgets/sliver_bar.dart';
import 'package:Ticket/widgets/sliver_detail.dart';
import 'package:Ticket/widgets/tabbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'listview.dart';

class MyNestedScrollView extends GetView<AccountController> {
  final TabController tabController;

  MyNestedScrollView({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          MySliverAppBar(
            title: MyTabbar(tabController: tabController),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [MySliverDetail()],
            ),
          )
        ];
      },
      body: TabBarView(
        controller: tabController,
        children: [
          MyListView(accounts: controller.free, status: "free"),
          MyListView(accounts: controller.waiting, status: "waiting"),
          MyListView(accounts: controller.pending, status: "pending")
        ],
      ),
    );
  }

  // Widget getList(accounts, status) {
  //   return RefreshIndicator(
  //     onRefresh: () async {
  //       await controller.fetchAccounts();
  //     },
  //     child: Obx(() {
  //       return ListView.builder(
  //         itemCount: accounts.length,
  //         itemBuilder: (context, index) {
  //           // return Padding(
  //           //   padding: const EdgeInsets.all(2.0),
  //           //   child: Container(
  //           //     margin: const EdgeInsets.only(bottom: 8),
  //           //     padding: const EdgeInsets.all(8),
  //           //     decoration: const BoxDecoration(
  //           //       border: Border(
  //           //         left: BorderSide(
  //           //           color: CupertinoColors.systemGrey4,
  //           //           width: 1,
  //           //         ),
  //           //       ),
  //           //       boxShadow: [
  //           //         BoxShadow(
  //           //           color: CupertinoColors.systemGrey6,
  //           //           blurRadius: 5.0, // 设置阴影的模糊半径
  //           //           offset: Offset(0, 0.5), // 设置阴影偏移量
  //           //         ),
  //           //       ],
  //           //       borderRadius: BorderRadius.all(Radius.circular(10)),
  //           //     ),
  //           //     child: Padding(
  //           //       padding: const EdgeInsets.all(8.0),
  //           //       child: Row(children: [
  //           //         Expanded(
  //           //           child: Column(
  //           //             crossAxisAlignment: CrossAxisAlignment.start,
  //           //             children: [
  //           //               Text(
  //           //                 "账号: ${accounts[index].username}",
  //           //                 style: const TextStyle(
  //           //                   fontSize: 14,
  //           //                   fontWeight: FontWeight.bold,
  //           //                 ),
  //           //               ),
  //           //               Text(
  //           //                 "${accounts[index].details}",
  //           //                 style: const TextStyle(
  //           //                   fontSize: 16,
  //           //                 ),
  //           //               ),
  //           //               Row(
  //           //                   mainAxisAlignment: MainAxisAlignment.end,
  //           //                   children: [
  //           //                     Visibility(
  //           //                       visible: status == "free" || status == "waiting",
  //           //                       child: IconButton(
  //           //                         icon: const Icon(CupertinoIcons.delete),
  //           //                         onPressed: () {},
  //           //                       ),
  //           //                     ),
  //           //                     Visibility(
  //           //                       visible: status == "free",
  //           //                       child: IconButton(
  //           //                         icon: const Icon(CupertinoIcons.alarm),
  //           //                         onPressed: () {},
  //           //                       ),
  //           //                     ),
  //           //                     Visibility(
  //           //                       visible: status == "free",
  //           //                       child: IconButton(
  //           //                         icon: const Icon(CupertinoIcons.arrow_up_arrow_down_circle),
  //           //                         onPressed: () {},
  //           //                       ),
  //           //                     ),
  //           //                     Visibility(
  //           //                       visible: status == "pending",
  //           //                       child: IconButton(
  //           //                         icon: const Icon(CupertinoIcons.money_dollar_circle),
  //           //                         onPressed: () {},
  //           //                       ),
  //           //                     ),
  //           //                   ])
  //           //             ],
  //           //           ),
  //           //         ),
  //           //       ]),
  //           //     ),
  //           //   ),
  //           // );
  //         },
  //       );
  //     }),
  //   );
  // }
}
