import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = 'https://api.papacapim.just.pro.br';

  /// Autentica o usuário e retorna o token de sessão
  static Future<Map<String, dynamic>> login(
    String login,
    String password,
  ) async {
    final url = Uri.parse('$baseUrl/sessions');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({'login': login, 'password': password}),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return {
        'success': true,
        'token': data['token'],
        'userLogin': data['user_login'],
      };
    } else {
      return {
        'success': false,
        'message': 'Falha na autenticação. Verifique suas credenciais.',
      };
    }
  }

  /// Exemplo de requisição autenticada utilizando o x-session-token
  static Future<http.Response> getUsers(String token) async {
    final url = Uri.parse('$baseUrl/users');

    return await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'x-session-token': token, // Cabeçalho exigido pela API
      },
    );
  }
}
