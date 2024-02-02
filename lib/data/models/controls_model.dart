class Controls {
  final bool? light;
  final bool? disinfectant;
  final bool? water;
  final bool? food;

  Controls({
    this.light,
    this.disinfectant,
    this.water,
    this.food,
  });

  factory Controls.defaultValues() {
    return Controls(
      light: false,
      disinfectant: false,
      water: false,
      food: false,
    );
  }

  factory Controls.fromJson(Map<String, dynamic> json) {
    return Controls(
      light: json['light'],
      disinfectant: json['disinfectant'],
      water: json['water'],
      food: json['food'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'light': light,
      'disinfectant': disinfectant,
      'water': water,
      'food': food,
    };
  }
}
