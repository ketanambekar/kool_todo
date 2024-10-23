import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kool_todo/routes/app_routes.dart';
import 'package:kool_todo/theme/app_colors.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'KoolTodo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: AppColors.primaryColor,
        hintColor: AppColors.accentColor,
        scaffoldBackgroundColor: AppColors.backgroundColor,
        appBarTheme: const AppBarTheme(
          color: AppColors.primaryColor,
          iconTheme: IconThemeData(color: AppColors.white),
        ),
        cardColor: AppColors.cardColor,
      ),
      initialRoute: '/',
      getPages: AppRoutes.pages,
    );
  }
}
