import 'package:Ticket/widgets/drawer.dart';
import 'package:Ticket/widgets/tabbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common/notification.dart';
import '../controller/AccountController.dart';
import '../widgets/dialog.dart';
import '../widgets/nested.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  MyNotificaiton myNotificaiton = Get.find();
  AccountController accountController = Get.find();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: accountController.tabs.length,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const AddAccountDialog();
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: MyNestedScrollView(tabController: _tabController),
    );
  }
}
