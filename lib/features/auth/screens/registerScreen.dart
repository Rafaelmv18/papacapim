import 'package:flutter/material.dart';

// Widget com estado (StatefulWidget) para gerenciar as variáveis da tela de cadastro
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

// Classe de estado da tela de Cadastro
class _RegisterScreenState extends State<RegisterScreen> {
  // Variáveis locais para armazenar nome, e-mail e senha do novo usuário
  String name = '';
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    // Acessa o tema ativo da aplicação para aplicar cores e estilos
    final theme = Theme.of(context);

    return Scaffold(
      // SafeArea para evitar sobreposição do conteúdo com entalhes ou barras do dispositivo
      body: SafeArea(
        child: Center(
          // Permite rolar a tela se o teclado cobrir os campos em telas menores
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 16.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo da aplicação
                Image.network(
                  'https://img.icons8.com/3d-fluency/512/duck.png',
                  width: 130,
                  height: 130,
                ),
                const SizedBox(height: 16.0),

                // Título Padronizado da tela
                Text(
                  'Criar Conta',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32.0),

                // Campo de entrada para o Nome Completo
                TextField(
                  onChanged: (text) => setState(() => name = text),
                  decoration: const InputDecoration(
                    labelText: 'Nome completo',
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                ),
                const SizedBox(height: 16.0),

                // Campo de entrada para a Senha
                TextField(
                  onChanged: (text) => setState(() => password = text),
                  obscureText: true, // Oculta o texto digitado
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                ),
                const SizedBox(height: 16.0),

                // Campo de entrada para Confirmar a Senha
                TextField(
                  onChanged: (text) => setState(() => password = text),
                  obscureText: true, // Oculta o texto digitado
                  decoration: const InputDecoration(
                    labelText: 'Confirmar Senha',
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                ),
                const SizedBox(height: 28.0),

                // Seção com os botões de ação na horizontal
                Row(
                  children: [
                    // Botão Voltar (Ação secundária com borda)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          // Substitui a tela atual e direciona para o Login
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size.fromHeight(48),
                          side: BorderSide(color: theme.colorScheme.primary),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Voltar',
                          style: TextStyle(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16.0),

                    // Botão Finalizar (Ação principal preenchida)
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Valida se todos os campos foram preenchidos (sem espaços vazios)
                          if (name.trim().isNotEmpty &&
                              email.trim().isNotEmpty &&
                              password.trim().isNotEmpty) {
                            // Exibe SnackBar verde de sucesso
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Cadastro realizado com sucesso!',
                                ),
                                backgroundColor: Colors.green,
                                duration: Duration(seconds: 2),
                              ),
                            );

                            // Retorna para a tela de Login na pilha de navegação
                            Navigator.pop(context);
                          } else {
                            // Exibe SnackBar vermelha avisando sobre campos vazios
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Preencha todos os campos!'),
                                backgroundColor: Colors.redAccent,
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        },
                        child: const Text('Finalizar'),
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
