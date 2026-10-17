enum CardNetwork { mastercard, visa }

class BankCardModel {
  final String typeLabel;
  final String lastFour;
  final CardNetwork network;
  final bool isDark;

  const BankCardModel({
    required this.typeLabel,
    required this.lastFour,
    required this.network,
    required this.isDark,
  });
}
