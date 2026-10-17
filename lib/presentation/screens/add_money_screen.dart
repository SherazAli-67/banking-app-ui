import 'package:banking_app/constants/string_const.dart';
import 'package:banking_app/core/app_textstyles.dart';
import 'package:banking_app/presentation/providers/add_money_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddMoneyScreen extends StatelessWidget {
  const AddMoneyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          '${StringConst.addMoney} · card ${context.watch<AddMoneyProvider>().selectedCardIndex}',
          style: AppTextStyles.screenTitle,
        ),
      ),
    );
  }
}
