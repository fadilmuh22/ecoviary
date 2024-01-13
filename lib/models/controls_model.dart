class Controls {
  final bool? light;
  final bool? disinfectant;
  final bool? water;

  Controls({
    this.light,
    this.disinfectant,
    this.water,
  });

  factory Controls.defaultValues() {
    return Controls(
      light: false,
      disinfectant: false,
      water: false,
    );
  }

  factory Controls.fromJson(Map<String, dynamic> json) {
    return Controls(
      light: json['light'],
      disinfectant: json['disinfectant'],
      water: json['water'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'light': light,
      'disinfectant': disinfectant,
      'water': water,
    };
  }
}
