import 'package:flutter/material.dart';
import 'package:papacapim/core/theme/appTheme.dart';
import 'package:papacapim/features/auth/screens/loginScreen.dart';
import 'package:papacapim/features/auth/screens/registerScreen.dart';
import 'package:papacapim/features/feed/screens/feedScreen.dart';
import 'package:papacapim/features/home/screens/homeScreen.dart';
import 'package:papacapim/features/profile/screens/profileEdit.dart';

// Widget principal sem estado (StatelessWidget) da aplicação Papacapim
class PapacapimApp extends StatelessWidget {
  const PapacapimApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Configuração base da estrutura do MaterialApp
    return MaterialApp(
      title:
          'Papacapim', // Título do app no gerenciador de tarefas do dispositivo
      debugShowCheckedModeBanner:
          false, // Oculta a faixa 'DEBUG' no canto superior da tela
      theme: AppTheme
          .darkTheme, // Aplica o tema escuro personalizado centralizado em AppTheme
      // Tabela de rotas nomeadas da aplicação para navegação entre telas
      routes: {
        '/': (context) =>
            const LoginScreen(), // Rota raiz inicial direcionada para a tela de Login
        '/login': (context) => const LoginScreen(), // Rota explícita para Login
        '/register': (context) =>
            const RegisterScreen(), // Rota para tela de Cadastro
        '/feed': (context) => const FeedScreen(), // Rota para o Feed principal
        '/homeScreen': (context) =>
            const HomeScreen(), // Rota para a BottomNavigationBar (HomeScreen)
        '/profileEdit': (context) =>
            const ProfileEditScreen(), // Rota para a tela de Edição de Perfil
      },
    );
  }
}
