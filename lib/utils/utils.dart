import 'package:ecoviary/data/models/automations_model.dart';

String doubleRemoveFloatZero(double value) {
  if (value % 1 == 0) {
    return value.toInt().toString();
  }
  return value.toStringAsFixed(1);
}

String formatPercentage(double value) {
  return '${doubleRemoveFloatZero(value * 100)}%';
}

String formatTemperature(double value) {
  return '${doubleRemoveFloatZero(value)}°C';
}

String idGenerator() {
  final now = DateTime.now();
  return now.microsecondsSinceEpoch.toString();
}

Iterable<Automations> firebaseObjectToAutomationsList(Object? value) {
  return Map<String, dynamic>.from(
    value as Map<dynamic, dynamic>,
  ).entries.map((e) {
    var value = Automations.fromJson(e.value);
    if (value.id == '') {
      value.id = e.key;
    }
    return value;
  });
}
