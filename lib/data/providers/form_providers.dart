import 'package:ecoviary/data/models/automations_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AutomationFormNotifier extends ChangeNotifier {
  Automations? automation;

  void setAutomations(Automations automation) {
    this.automation = automation;
    notifyListeners();
  }
}

final automationFormProvider =
    ChangeNotifierProvider<AutomationFormNotifier>((ref) {
  return AutomationFormNotifier();
});
