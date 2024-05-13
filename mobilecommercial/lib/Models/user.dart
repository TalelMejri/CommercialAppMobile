class User {
  int id;
  String name;
  String phone;
  String email;
  String role;

  User(
      {required this.id,
      required this.name,
      required this.phone,
      required this.email,
      required this.role,
      r});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        role: json['role']
      );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'role': role,
   
    };
  }

  @override
  String toString() {
    return name +
        "" +
        email +
        "" +
        role +
        "" +
        phone +
        "" +
        id.toString();
  }
}
