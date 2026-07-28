import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String name = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    // Acessa as cores e tipografia do tema ativo
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
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
                  onChanged: (text) => name = text,
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                ),
                const SizedBox(height: 16.0),

                // Campo de Senha
                TextField(
                  onChanged: (text) => password = text,
                  obscureText: true,
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
                        onPressed: () {
                          if (name == 'a' && password == 'a') {
                            Navigator.pushReplacementNamed(
                              context,
                              '/homeScreen',
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Nome ou senha incorretos',
                                ), // 👈 Mensagem atualizada
                                backgroundColor: Colors.redAccent,
                              ),
                            );
                          }
                        },
                        child: const Text('Entrar'),
                      ),
                    ),
                    const SizedBox(width: 16.0),

                    // Botão Cadastrar
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          // Usamos pushNamed para permitir que o usuário volte ao Login
                          Navigator.pushReplacementNamed(context, '/register');
                        },
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
