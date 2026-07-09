import 'package:flutter/material.dart';
import 'package:papacapim/features/auth/screens/registerScreen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          //centraliza os elementos na tela
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Papacapim',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 32),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Login',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment
                  .center, // Centraliza os botões na horizontal
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Simulação exigida no roteiro: avisa que logou e vai para o feed
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Simulando Login... Redirecionando para o Feed',
                        ),
                      ),
                    );
                  },
                  child: const Text('Entrar'),
                ),
                const SizedBox(
                  width: 40,
                ), // Espaço de 12 pixels entre os dois botões

                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterScreen(),
                      ),
                    );
                  },
                  // Se quiser mudar a cor de APENAS um botão específico para diferenciar do tema:
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.green.shade100, // Um verde bem clarinho
                    foregroundColor:
                        Colors.green.shade900, // Texto verde escuro
                  ),
                  child: const Text('Cadastrar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
