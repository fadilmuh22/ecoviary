class Sensors {
  final double temperature;
  final double humidity;
  final double amonia;
  final int date;

  Sensors({
    required this.temperature,
    required this.humidity,
    required this.amonia,
    required this.date,
  });

  factory Sensors.defaultValues() {
    return Sensors(
      temperature: 0.1,
      humidity: 0.1,
      amonia: 0.1,
      date: DateTime.now().millisecondsSinceEpoch,
    );
  }

  factory Sensors.fromJson(Map<String, dynamic> json) {
    return Sensors(
      temperature: double.parse(json['temperature'].toString()),
      humidity: double.parse(json['humidity'].toString()),
      amonia: double.parse(json['amonia'].toString()),
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'temperature': temperature,
      'humidity': humidity,
      'amonia': amonia,
      'date': date,
    };
  }
}
