import 'package:banking_app/constants/string_const.dart';
import 'package:banking_app/core/app_textstyles.dart';
import 'package:banking_app/presentation/providers/home_provider.dart';
import 'package:banking_app/routing/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isBalanceVisible = context.watch<HomeProvider>().isBalanceVisible;
    return Scaffold(
      body: Center(
        child: Column(
          spacing: 12,
          mainAxisSize: .min,
          children: [
            Text(StringConst.home, style: AppTextStyles.screenTitle,),
            Text(isBalanceVisible ? StringConst.balanceAmount : '••••••', style: AppTextStyles.balanceLabel,),
            TextButton(
              onPressed: () => context.read<HomeProvider>().toggleBalanceVisibility(),
              child: Text(StringConst.yourBalance, style: AppTextStyles.actionLink,),
            ),
            TextButton(
              onPressed: () => context.push(NamedRoutes.addMoney.routeName),
              child: Text(StringConst.addMoney, style: AppTextStyles.actionLink,),
            ),
          ],
        ),
      ),
    );
  }
}
