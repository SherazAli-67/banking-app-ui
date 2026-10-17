import 'package:banking_app/constants/string_const.dart';
import 'package:banking_app/core/app_textstyles.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(StringConst.settings, style: AppTextStyles.screenTitle,),),);
  }
}
