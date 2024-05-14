class Notif {
  int id;
  String message;

  Notif({required this.id, required this.message, r});

  factory Notif.fromJson(Map<String, dynamic> json) {
    return Notif(id: json['id'], message: json['message']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
    };
  }

  @override
  String toString() {
    return message + "" + id.toString();
  }
}
