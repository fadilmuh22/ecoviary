import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TabIndexNotifier extends ChangeNotifier {
  int tabIndex = 0;

  void changeTab(int index) {
    tabIndex = index;
    notifyListeners();
  }
}

final mainTabIndexProvider = ChangeNotifierProvider<TabIndexNotifier>((ref) {
  return TabIndexNotifier();
});

final automationsTabIndexProvider =
    ChangeNotifierProvider<TabIndexNotifier>((ref) {
  return TabIndexNotifier();
});
