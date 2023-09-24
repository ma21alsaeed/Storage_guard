class User {
  final String email;
  final String password;
  final String name;
  final String? phone;
  final String? company;
  final String? location;

  User({
    required this.email,
    required this.password,
    required this.name,
    this.phone,
    this.company,
    this.location,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      password: "",
      name: json['name'],
      phone: json['phone'],
      company: json['company'],
      location: json['location'],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
        "phone": phone,
        "company":company,
        "location":location

      };
}
