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
