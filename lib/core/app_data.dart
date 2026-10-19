import 'package:banking_app/constants/string_const.dart';
import 'package:banking_app/core/app_colors.dart';
import 'package:banking_app/core/asset_res.dart';
import 'package:banking_app/core/models/bank_card_model.dart';
import 'package:banking_app/core/models/funding_method_model.dart';
import 'package:banking_app/core/models/transaction_model.dart';
import 'package:banking_app/core/models/user_profile_model.dart';

class AppData {
  static const balanceAmount = StringConst.balanceAmount;

  static const userProfile = UserProfileModel(
    name: StringConst.sherazAli,
    email: StringConst.sherazEmail,
    phone: StringConst.sherazPhone,
    address: StringConst.sherazAddress,
    accountType: StringConst.personalAccount,
    avatar: AssetRes.profileAvatar,
  );

  static const bankCards = [
    BankCardModel(
      typeLabel: StringConst.debitCard,
      lastFour: StringConst.cardLast4Debit,
      network: .mastercard,
      isDark: false,
    ),
    BankCardModel(
      typeLabel: StringConst.creditCard,
      lastFour: StringConst.cardLast4Credit,
      network: .visa,
      isDark: true,
    ),
  ];

  static const transactions = [
    TransactionModel(
      merchant: StringConst.starbucksCoffee,
      dateLabel: StringConst.transactionDate,
      amount: StringConst.transactionAmount,
      rewardBadge: StringConst.rewardAmount,
      iconSymbol: '★',
      iconColor: AppColors.transactionGreen,
    ),
  ];

  static const fundingMethods = [
    FundingMethodModel(title: StringConst.moveDirectDeposit, icon: AssetRes.icDollar,),
    FundingMethodModel(title: StringConst.transferFromOtherBanks, icon: AssetRes.icTransfer,),
    FundingMethodModel(title: StringConst.applePay, icon: AssetRes.icApplePay,),
    FundingMethodModel(title: StringConst.debitCreditCard, icon: AssetRes.icDebitCard,),
  ];
}
