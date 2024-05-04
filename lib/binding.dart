import 'package:Ticket/repository/repository.dart';
import 'package:get/get.dart';

import 'common/notification.dart';
import 'controller/AccountController.dart';

class MyBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<Repository>(Repository());
    Get.put<MyNotificaiton>(MyNotificaiton());
    Get.put<AccountController>(AccountController());
  }
}
