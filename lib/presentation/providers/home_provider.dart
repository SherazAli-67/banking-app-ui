import 'package:flutter/foundation.dart';

class HomeProvider extends ChangeNotifier {
  bool isBalanceVisible = true;

  void toggleBalanceVisibility() {
    isBalanceVisible = !isBalanceVisible;
    notifyListeners();
  }
}
