class Coops {
  final String name;
  final int totalRooster;
  final int totalHen;
  final int totalChicken;
  final String date;

  Coops({
    required this.name,
    required this.totalRooster,
    required this.totalHen,
    required this.totalChicken,
    required this.date,
  });

  factory Coops.defaultValues() {
    return Coops(
      name: 'Kandang 1',
      totalRooster: 0,
      totalHen: 0,
      totalChicken: 0,
      date: DateTime.now().toIso8601String(),
    );
  }

  factory Coops.fromJson(Map<String, dynamic> json) {
    return Coops(
      name: json['name'],
      totalRooster: json['totalRooster'],
      totalHen: json['totalHen'],
      totalChicken: json['totalChicken'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'totalRooster': totalRooster,
      'totalHen': totalHen,
      'totalChicken': totalChicken,
      'date': date,
    };
  }

  @override
  bool operator ==(dynamic other) =>
      other != null &&
      other is Coops &&
      name == other.name &&
      date == other.date;

  @override
  int get hashCode => Object.hash(name, date);
}
