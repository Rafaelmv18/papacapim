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

  /// Realiza o cadastro de um novo usuário na API
  static Future<Map<String, dynamic>> register({
    required String name,
    required String login,
    required String password,
    required String passwordConfirmation,
  }) async {
    final url = Uri.parse('$baseUrl/users');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'user': {
            'name': name,
            'login': login,
            'password': password,
            'password_confirmation': passwordConfirmation,
          },
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return {'success': true, 'data': data};
      } else {
        // Trata erros de validação retornados pela API (ex: login já em uso ou senha curta)
        String errorMessage = 'Erro ao cadastrar.';
        if (data is Map<String, dynamic>) {
          errorMessage = data.entries
              .map((e) => '${e.key}: ${(e.value as List).join(", ")}')
              .join('\n');
        }
        return {'success': false, 'message': errorMessage};
      }
    } catch (e) {
      return {'success': false, 'message': 'Erro de conexão com o servidor.'};
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
