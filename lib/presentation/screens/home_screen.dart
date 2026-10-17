import 'package:banking_app/constants/number_constant.dart';
import 'package:banking_app/constants/string_const.dart';
import 'package:banking_app/core/app_colors.dart';
import 'package:banking_app/core/app_data.dart';
import 'package:banking_app/core/app_textstyles.dart';
import 'package:banking_app/core/asset_res.dart';
import 'package:banking_app/core/models/transaction_model.dart';
import 'package:banking_app/presentation/providers/home_provider.dart';
import 'package:banking_app/presentation/widgets/bank_card_widget.dart';
import 'package:banking_app/routing/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: .fromLTRB(NumberConstant.horizontalPadding, 14, NumberConstant.horizontalPadding, 0),
          child: SingleChildScrollView(
            padding: .only(bottom: 16),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                _buildHeader(),
                Padding(padding: .only(top: 20), child: _buildBalanceCard(context),),
                Padding(padding: .only(top: 22), child: _buildCardsHeader(),),
                Padding(padding: .only(top: 17), child: _buildCardsList(),),
                Padding(padding: .only(top: 21), child: _buildTransactionsSection(),),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        Column(
          crossAxisAlignment: .start,
          children: [
            Text(StringConst.goodMorningTerry, style: AppTextStyles.greeting,),
            Text(StringConst.welcomeToNeobank, style: AppTextStyles.subtitle,),
          ],
        ),
        Stack(
          clipBehavior: .none,
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.surfaceGray,
                borderRadius: .circular(NumberConstant.actionButtonRadius),
                border: .all(color: AppColors.borderSoft, width: 0.6),
              ),
              padding: .all(12.5),
              child: SvgPicture.asset(AssetRes.icNotification,),
            ),
            Positioned(
              right: 10,
              top: 10,
              child: Container(
                padding: .all(3.5),
                decoration: BoxDecoration(color: AppColors.primaryLime, borderRadius: .circular(3.5),),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBalanceCard(BuildContext context) {
    final isBalanceVisible = context.watch<HomeProvider>().isBalanceVisible;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: AppColors.white, borderRadius: .circular(NumberConstant.sectionRadius),),
      padding: .all(20),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Text(StringConst.yourBalance, style: AppTextStyles.balanceLabel,),
          Padding(
            padding: .only(top: 3),
            child: Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text(isBalanceVisible ? AppData.balanceAmount : StringConst.hiddenBalance, style: AppTextStyles.balanceAmount,),
                GestureDetector(
                  onTap: () => context.read<HomeProvider>().toggleBalanceVisibility(),
                  child: SvgPicture.asset(AssetRes.icHiddenEye,),
                ),
              ],
            ),
          ),
          Padding(
            padding: .only(top: 15),
            child: GestureDetector(
              onTap: () => context.push(NamedRoutes.addMoney.routeName),
              child: Container(
                width: double.infinity,
                alignment: .center,
                decoration: BoxDecoration(color: AppColors.ctaBlack, borderRadius: .circular(NumberConstant.ctaRadius),),
                padding: .symmetric(vertical: 12),
                child: Text(StringConst.addMoney, style: AppTextStyles.ctaButton,),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardsHeader() {
    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        Text(StringConst.yourCards, style: AppTextStyles.sectionTitle,),
        GestureDetector(
          onTap: () {},
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(text: StringConst.newCardPlus, style: AppTextStyles.newCardPlus,),
                TextSpan(text: StringConst.newCard, style: AppTextStyles.newCardLabel,),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCardsList() {
    return SizedBox(
      height: NumberConstant.bankCardHeight,
      child: ListView.separated(
        scrollDirection: .horizontal,
        itemCount: AppData.bankCards.length,
        separatorBuilder: (_, _) => const SizedBox(width: NumberConstant.bankCardGap),
        itemBuilder: (ctx, i) => BankCardWidget(card: AppData.bankCards[i], showDetails: i == 0,),
      ),
    );
  }

  Widget _buildTransactionsSection() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: AppColors.white, borderRadius: .circular(NumberConstant.sectionRadius),),
      padding: .fromLTRB(20, 16, 20, 16),
      child: Column(
        spacing: 16,
        children: [
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text(StringConst.transactions, style: AppTextStyles.sectionTitle,),
              GestureDetector(onTap: () {}, child: Text(StringConst.seeAll, style: AppTextStyles.seeAll,),),
            ],
          ),
          ...AppData.transactions.map(_buildTransactionRow),
        ],
      ),
    );
  }

  Widget _buildTransactionRow(TransactionModel transaction) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: transaction.iconColor,
            borderRadius: .circular(12),
            border: .all(color: AppColors.transactionIconBorder, width: 5.5),
          ),
          padding: .symmetric(horizontal: 8, vertical: 4),
          child: Text(transaction.iconSymbol, style: const TextStyle(color: AppColors.white, fontSize: 16, height: 24 / 16,),),
        ),
        Expanded(
          child: Padding(
            padding: .only(left: 9),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(transaction.merchant, style: AppTextStyles.transactionTitle,),
                Padding(padding: .only(top: 3), child: Text(transaction.dateLabel, style: AppTextStyles.transactionDate,),),
              ],
            ),
          ),
        ),
        Column(
          crossAxisAlignment: .end,
          children: [
            Text(transaction.amount, style: AppTextStyles.transactionAmount,),
            Padding(
              padding: .only(top: 4),
              child: Container(
                decoration: BoxDecoration(color: AppColors.primaryLime, borderRadius: .circular(NumberConstant.rewardBadgeRadius),),
                padding: .symmetric(horizontal: 8, vertical: 2),
                child: Text(transaction.rewardBadge, style: AppTextStyles.rewardBadge,),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
