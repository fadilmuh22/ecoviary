enum AutomationsStatus { initial, scheduled, started }

class Automations {
  String id;
  final List<String> food;
  final List<String> water;
  final List<bool> disinfectant;
  final int date;
  final AutomationsStatus status;

  Automations({
    required this.id,
    required this.food,
    required this.water,
    required this.disinfectant,
    required this.date,
    required this.status,
  });

  factory Automations.defaultValues() {
    return Automations(
      id: '',
      food: ['04:00', '12:00', '16:00'],
      water: ['04:00', '08:00', '12:00', '16:00'],
      disinfectant: [false, false, false, false, false, false, false],
      date: DateTime.now().millisecondsSinceEpoch,
      status: AutomationsStatus.initial,
    );
  }

  factory Automations.fromJson(Map<String, dynamic> json) {
    return Automations(
      id: json['id'],
      food: json['food'].map<String>((e) => e as String).toList(),
      water: json['water'].map<String>((e) => e as String).toList(),
      disinfectant: json['disinfectant'].map<bool>((e) => e as bool).toList(),
      date: json['date'],
      status: AutomationsStatus.values[json['status']],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'food': food,
      'water': water,
      'disinfectant': disinfectant,
      'date': date,
      'status': status.index,
    };
  }
}
