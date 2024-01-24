import 'package:ecoviary/data/models/automations_model.dart';
import 'package:flutter/material.dart';

enum DaysEnum {
  days,
  month,
  year,
}

String doubleRemoveFloatZero(double value) {
  if (value % 1 == 0) {
    return value.toInt().toString();
  }
  return value.toStringAsFixed(1);
}

String formatPercentage(double value) {
  return '${doubleRemoveFloatZero(value)}%';
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

String formatDaysToChickenAge(int days) {
  if (days < 30) {
    return '$days hari';
  } else if (days < 365) {
    return '${(days / 30).floor()} bulan';
  } else {
    return '${(days / 365).floor()} tahun';
  }
}

int chickenAgeToDays(int age, DaysEnum from, DaysEnum to) {
  switch (from) {
    case DaysEnum.days:
      switch (to) {
        case DaysEnum.days:
          return age;
        case DaysEnum.month:
          return (age / 30).ceil();
        case DaysEnum.year:
          return (age / 365).ceil();
      }
    case DaysEnum.month:
      switch (to) {
        case DaysEnum.days:
          return age * 30;
        case DaysEnum.month:
          return age;
        case DaysEnum.year:
          return (age / 12).ceil();
      }
    case DaysEnum.year:
      switch (to) {
        case DaysEnum.days:
          return age * 365;
        case DaysEnum.month:
          return age * 12;
        case DaysEnum.year:
          return age;
      }
  }
}

double todToDouble(TimeOfDay myTime) => myTime.hour + myTime.minute / 60.0;

List<TimeOfDay> sortTimeOfDays(List<TimeOfDay> list) {
  list.sort((a, b) => todToDouble(a).compareTo(todToDouble(b)));
  return list;
}

String daysEnumMapper(DaysEnum type) {
  switch (type) {
    case DaysEnum.days:
      return 'Hari';
    case DaysEnum.month:
      return 'Bulan';
    case DaysEnum.year:
      return 'Tahun';
    default:
      return '';
  }
}

String? emptyValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Tidak boleh kosong';
  }
  return null;
}
