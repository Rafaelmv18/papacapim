import 'package:flutter/material.dart';
import 'package:papacapim/features/auth/services/authService.dart';

// Widget com estado (StatefulWidget) para gerenciar as variáveis da tela de login
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

// Classe de estado da tela de Login
class _LoginScreenState extends State<LoginScreen> {
  // Variáveis locais para armazenar o nome e a senha digitados pelo usuário
  String login = '';
  String password = '';
  bool _isLoading = false;

  Future<void> _login() async {
    if (login.trim().isEmpty || password.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, preencha todos os campos.'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final result = await AuthService.login(login.trim(), password.trim());

    setState(() => _isLoading = false);

    if (!mounted) return;

    if (result['success']) {
      // Login bem-sucedido! Aqui você pode salvar o token em storage se necessário
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login realizado com sucesso!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 1),
        ),
      );

      Navigator.pushReplacementNamed(context, '/homeScreen');
    } else {
      // Exibe a mensagem de erro retornada pela API
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['message'] ?? 'Nome ou senha incorretos'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Acessa as cores e tipografia do tema ativo
    final theme = Theme.of(context);

    return Scaffold(
      // SafeArea evita que o conteúdo fique sob a barra de status do celular
      body: SafeArea(
        child: Center(
          // Permite rolar a tela em dispositivos com resolução menor ou quando o teclado abre
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 16.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icone / Logo
                Image.network(
                  'https://img.icons8.com/3d-fluency/512/duck.png',
                  width: 130,
                  height: 130,
                ),
                const SizedBox(height: 16.0),

                // Título com o estilo do tema
                Text(
                  'Papacapim',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32.0),

                // Campo de Nome
                TextField(
                  // Atualiza a variável 'login' sempre que o texto muda
                  onChanged: (text) => login = text,
                  decoration: const InputDecoration(
                    labelText: 'Login',
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                ),
                const SizedBox(height: 16.0),

                // Campo de Senha
                TextField(
                  // Atualiza a variável 'password' sempre que o texto muda
                  onChanged: (text) => password = text,
                  obscureText:
                      true, // Oculta os caracteres da senha com bolinhas
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                ),
                const SizedBox(height: 28.0),

                // Botões de Ação
                Row(
                  children: [
                    // Botão Entrar / Login
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _login,
                        child: _isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.0,
                                ),
                              )
                            : const Text('Entrar'),
                      ),
                    ),
                    const SizedBox(width: 16.0),

                    // Botão Cadastrar
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _isLoading
                            ? null
                            : () => Navigator.pushReplacementNamed(
                                context,
                                '/register',
                              ),
                        // Usamos pushNamed para permitir que o usuário volte ao Login
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size.fromHeight(48),
                          side: BorderSide(color: theme.colorScheme.primary),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Cadastrar',
                          style: TextStyle(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
