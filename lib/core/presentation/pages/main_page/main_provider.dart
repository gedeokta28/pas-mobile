import 'package:flutter/cupertino.dart';

class MainProvider with ChangeNotifier {
  int _tapIndex = 0;

  // setter
  set setTappedIndex(int i) {
    _tapIndex = i;
    notifyListeners();
  }

  // getter
  int get tappedIndex => _tapIndex;

  // method
  switchToSearchPage() => setTappedIndex = 1;

  // constructor
  MainProvider();
}
