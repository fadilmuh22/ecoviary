enum AutomationsStatus { initial, scheduled, started }

class Automations {
  final List<int> food;
  final List<int> water;
  final List<bool> disinfectant;
  final int date;
  final AutomationsStatus status;

  Automations({
    required this.food,
    required this.water,
    required this.disinfectant,
    required this.date,
    required this.status,
  });

  factory Automations.defaultValues() {
    return Automations(
      food: [1, 2, 3],
      water: [1, 2, 3],
      disinfectant: [false, false, false, false, false, false, false],
      date: DateTime.now().millisecondsSinceEpoch,
      status: AutomationsStatus.initial,
    );
  }

  factory Automations.fromJson(Map<String, dynamic> json) {
    return Automations(
      food: json['food'].map<int>((e) => int.parse(e.toString())).toList(),
      water: json['water'].map<int>((e) => int.parse(e.toString())).toList(),
      disinfectant: json['disinfectant'].map<bool>((e) => e as bool).toList(),
      date: json['date'],
      status: AutomationsStatus.values[json['status']],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'food': food,
      'water': water,
      'disinfectant': disinfectant,
      'date': date,
      'status': status,
    };
  }
}
