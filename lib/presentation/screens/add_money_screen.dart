import 'package:banking_app/constants/number_constant.dart';
import 'package:banking_app/constants/string_const.dart';
import 'package:banking_app/core/app_colors.dart';
import 'package:banking_app/core/app_data.dart';
import 'package:banking_app/core/app_textstyles.dart';
import 'package:banking_app/core/asset_res.dart';
import 'package:banking_app/core/models/funding_method_model.dart';
import 'package:banking_app/presentation/providers/add_money_provider.dart';
import 'package:banking_app/presentation/widgets/bank_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AddMoneyScreen extends StatelessWidget {
  const AddMoneyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: SafeArea(
        child: Padding(
          padding: .fromLTRB(NumberConstant.addMoneyHorizontalPadding, 3, NumberConstant.addMoneyHorizontalPadding, 0),
          child: SingleChildScrollView(
            padding: .only(bottom: 30),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                _buildHeader(context),
                Padding(padding: .only(top: 27), child: Text(StringConst.selectCard, style: AppTextStyles.sectionTitle,),),
                Padding(padding: .only(top: 17), child: _buildCardsList(context),),
                Padding(padding: .only(top: 30), child: Text(StringConst.addMoneyToNeobank, style: AppTextStyles.sectionTitle,),),
                Padding(padding: .only(top: 18), child: _buildFundingMethods(),),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      alignment: .center,
      children: [
        Align(
          alignment: .centerLeft,
          child: GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: .circular(NumberConstant.actionButtonRadius),
                border: .all(color: AppColors.borderLight, width: 0.6),
              ),
              padding: .all(12.5),
              child: SvgPicture.asset(AssetRes.icBack,),
            ),
          ),
        ),
        Text(StringConst.addMoney, style: AppTextStyles.screenTitle,),
      ],
    );
  }

  Widget _buildCardsList(BuildContext context) {
    final selectedIndex = context.watch<AddMoneyProvider>().selectedCardIndex;
    return SizedBox(
      height: NumberConstant.selectCardSize + NumberConstant.selectCardPadding * 2 + NumberConstant.selectCardBorderWidth * 2,
      child: ListView.separated(
        scrollDirection: .horizontal,
        itemCount: AppData.bankCards.length,
        separatorBuilder: (_, _) => const SizedBox(width: NumberConstant.selectCardGap),
        itemBuilder: (ctx, i) => BankCardWidget(
          card: AppData.bankCards[i],
          compact: true,
          isSelected: selectedIndex == i,
          onTap: () => context.read<AddMoneyProvider>().selectCard(i),
        ),
      ),
    );
  }

  Widget _buildFundingMethods() {
    return Column(
      spacing: 12,
      children: AppData.fundingMethods.map(_buildFundingMethodRow).toList(),
    );
  }

  Widget _buildFundingMethodRow(FundingMethodModel method) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: AppColors.rowGray, borderRadius: .circular(NumberConstant.fundingRowRadius),),
        padding: .symmetric(horizontal: 20, vertical: 21),
        child: Row(
          children: [
            Expanded(
              child: Row(
                spacing: 14,
                children: [
                  SvgPicture.asset(method.icon,),
                  Flexible(child: Text(method.title, style: AppTextStyles.fundingMethod,),),
                ],
              ),
            ),
            SvgPicture.asset(AssetRes.icChevronRight,),
          ],
        ),
      ),
    );
  }
}
