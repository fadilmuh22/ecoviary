import 'package:ecoviary/data/models/automations_model.dart';
import 'package:ecoviary/data/models/coops_model.dart';
import 'package:ecoviary/data/services/realtime_database.dart';
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

class CoopFormNotifier extends ChangeNotifier {
  Coops? coop;

  var formKey = GlobalKey<FormState>();

  final ageController = TextEditingController();
  final henController = TextEditingController();
  final roosterController = TextEditingController();
  final totalController = TextEditingController();

  void setCoop(Coops coop) {
    this.coop = coop;
    notifyListeners();
  }

  Future<void> submit() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      Coops data = Coops(
        name: 'Kandang 1',
        age: int.parse(ageController.text),
        totalHen: int.parse(henController.text),
        totalRooster: int.parse(roosterController.text),
        totalChicken: int.parse(totalController.text),
        date: DateTime.now().millisecondsSinceEpoch,
      );
      return Collections.coops.ref.set(data.toJson());
    }
    return Future.error('Gagal menyimpan data');
  }
}

final coopFormProvider = ChangeNotifierProvider<CoopFormNotifier>((ref) {
  return CoopFormNotifier();
});
