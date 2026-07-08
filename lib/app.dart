import 'package:flutter/material.dart';
import 'package:papacapim/features/auth/screens/loginScreen.dart';

class PapacapimApp extends StatelessWidget {
  const PapacapimApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Papacapim',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          primary: Colors.green, // Cor principal dos botões e destaques
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          // Cor do texto de ajuda/rótulo quando o campo está selecionado (focado)
          floatingLabelStyle: TextStyle(color: Colors.green),

          // Customização das bordas
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.green,
              width: 2.0,
            ), // Borda verde ao clicar
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ), // Borda cinza em repouso
          ),
        ),
      ),
      home: const LoginScreen(), // Tela inicial do aplicativo
    );
  }
}
