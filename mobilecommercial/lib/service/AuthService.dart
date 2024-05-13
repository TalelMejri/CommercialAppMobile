import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobilecommercial/Models/user.dart';


class AuthService {
  bool isAuth = false;
  String url = "http://10.0.2.2:8000/api";
  final Storage = FlutterSecureStorage();

  late User user;

  AuthService() {
    getUserFromStorage();
  }

  Future<void> getUserFromStorage() async {
    var user_data = await Storage.read(key: "user");
    if (user_data != null) {
      user = User.fromJson(jsonDecode(user_data));
      isAuth = true;
    } else {
      isAuth = false;
    }
  }

  Future<void> logout() async {
    await Storage.delete(key: "user");
  }

  Future<bool> RegisterUser(
      String nom, String email, String password, String phone) async {
    final request = {
      "name": nom,
      "email": email,
      "password": password,
      "phone": phone
    };
    try {
      final response = await http.post(Uri.parse("$url/RegisterUser"),
          body: jsonEncode(request),
          headers: {"Content-Type": "application/json;charset=utf-8"});
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> LoginUser(String email, String password) async {
    final request = {"email": email, "password": password};
    try {
      final response = await http.post(Uri.parse("$url/login"),
          body: jsonEncode(request),
          headers: {"Content-Type": "application/json;charset=utf-8"});
      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'];
        final User user = User.fromJson(data);
        Storage.write(key: "user", value: jsonEncode(user.toJson()));
        getUserFromStorage();
        isAuth = true;
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> AddCommande(String type, int id, int qte) async {
    final request = {"type": type, "IdClient": id, "qte": qte};
    try {
      final response = await http.post(Uri.parse("$url/Addcommande"),
          body: jsonEncode(request),
          headers: {"Content-Type": "application/json;charset=utf-8"});
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
