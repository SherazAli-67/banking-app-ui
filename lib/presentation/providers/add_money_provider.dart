import 'package:flutter/foundation.dart';

class AddMoneyProvider extends ChangeNotifier {
  int selectedCardIndex = 0;

  void selectCard(int index) {
    if (selectedCardIndex == index) return;
    selectedCardIndex = index;
    notifyListeners();
  }
}
