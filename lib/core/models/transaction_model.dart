import 'package:flutter/material.dart';

class TransactionModel {
  final String merchant;
  final String dateLabel;
  final String amount;
  final String rewardBadge;
  final String iconSymbol;
  final Color iconColor;

  const TransactionModel({
    required this.merchant,
    required this.dateLabel,
    required this.amount,
    required this.rewardBadge,
    required this.iconSymbol,
    required this.iconColor,
  });
}
