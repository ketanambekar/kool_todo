import 'package:get/get.dart';
import 'package:kool_todo/screens/dashboard/dashboard.dart';


class AppRoutes {
  static const String dashboard = '/';
  static const String addTask = '/add-task';

  static List<GetPage> pages = [
    GetPage(
      name: dashboard,
      page: () =>  Dashboard(),
    )
  ];
}
