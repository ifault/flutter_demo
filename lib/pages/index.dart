import 'package:Ticket/pages/login.dart';
import 'package:Ticket/pages/setting.dart';
import 'package:get/get.dart';

import '../middleware/RouteAuthMiddleware.dart';
import 'home.dart';

abstract class AppRoutes {
  static const Home = '/home';
  static const Login = '/login';
  static const Setting = '/setting';
}

class AppPages {
  static const INITIAL = AppRoutes.Home;

  static final routes = [
    GetPage(name: AppRoutes.Home, page: () => HomePage(), middlewares: [
      RouteAuthMiddleware(),
    ]),
    GetPage(name: AppRoutes.Login, page: () => LoginPage()),
    GetPage(name: AppRoutes.Setting, page: () => SettingPage()),
  ];
}
