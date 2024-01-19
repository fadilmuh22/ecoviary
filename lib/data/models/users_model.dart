class Users {
  final String name;
  final String email;

  Users({
    required this.name,
    required this.email,
  });

  factory Users.defaultValues() {
    return Users(
      name: 'EcoViary Admin',
      email: 'ecoadmin@mail.com',
    );
  }

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      name: json['name'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
      };
}
