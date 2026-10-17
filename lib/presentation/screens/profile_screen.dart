import 'package:banking_app/constants/string_const.dart';
import 'package:banking_app/core/app_textstyles.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(StringConst.profile, style: AppTextStyles.screenTitle,),),);
  }
}
