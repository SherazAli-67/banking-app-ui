import 'package:banking_app/constants/string_const.dart';
import 'package:banking_app/core/app_colors.dart';
import 'package:banking_app/routing/router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: StringConst.appTitle,
      theme: ThemeData(
        brightness: .light,
        fontFamily: StringConst.appFontFamily,
        scaffoldBackgroundColor: AppColors.scaffoldBg,
      ),
      routerConfig: router,
      builder: (ctx, child) => child!,
    );
  }
}

