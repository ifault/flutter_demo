import 'package:Ticket/repository/Repository.dart';
import 'package:get/get.dart';

import 'common/notification.dart';
import 'controller/AccountController.dart';

class MyBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Repository>(() => Repository());
    Get.lazyPut<MyNotificaiton>(() => MyNotificaiton());
    Get.lazyPut<AccountController>(() => AccountController());
  }
}
