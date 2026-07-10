import 'package:flutter/material.dart';
import 'package:papacapim/features/auth/screens/loginScreen.dart';
import 'package:papacapim/features/auth/screens/registerScreen.dart';

class PapacapimApp extends StatelessWidget {
  const PapacapimApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Papacapim',
      debugShowCheckedModeBanner: false,

      routes: {
        '/': (context) => const LoginScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
      },
    );
  }
}
