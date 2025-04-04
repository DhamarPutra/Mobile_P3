import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = "http://localhost/apiFlutter";

  static Future<Map<String, dynamic>> register(
    String name,
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse("$_baseUrl/register.php"),
      body: {"name": name, "email": email, "password": password},
    );

    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse("$_baseUrl/login.php"),
      body: {"email": email, "password": password},
    );

    return jsonDecode(response.body);
  }

  static Future<List<dynamic>> get_user() async {
    final response = await http.get(Uri.parse("$_baseUrl/get_users.php"));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Gagal mengambil data pengguna");
    }
  }
}
