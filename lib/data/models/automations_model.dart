enum AutomationsStatus { initial, scheduled, started }

class Automations {
  String id;
  final List<String> food;
  final List<String> water;
  final List<bool> disinfectant;
  final int date;
  final AutomationsStatus status;
  final bool activated;

  Automations({
    required this.id,
    required this.food,
    required this.water,
    required this.disinfectant,
    required this.date,
    required this.status,
    required this.activated,
  });

  factory Automations.defaultValues() {
    return Automations(
      id: '',
      food: ['04:00', '16:00'],
      water: ['04:00', '16:00'],
      disinfectant: [true, false, false, false, true, false, false],
      date: DateTime.now().millisecondsSinceEpoch,
      status: AutomationsStatus.initial,
      activated: false,
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
      activated: json['activated'],
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
      'activated': activated,
    };
  }
}
