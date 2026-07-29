import 'package:flutter/material.dart';
import 'package:papacapim/core/theme/appColors.dart';

// Classe responsável por centralizar as configurações de tema da aplicação
class AppTheme {
  // Getter estático que fornece as definições do tema escuro (Dark Theme)
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true, // Ativa o suporte ao visual Material 3 do Flutter
      scaffoldBackgroundColor: AppColors.bg, // Cor de fundo padrão para telas
      // Esquema global de cores baseadas nas constantes da aplicação
      colorScheme: ColorScheme.dark(
        primary: AppColors.primary,
        surface: AppColors.surface,
        error: AppColors.danger,
      ),

      // Estilização global para o AppBar em todas as telas
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.surface, // Cor de fundo do topo
        foregroundColor: AppColors.text, // Cor do título e ícones
        elevation: 0, // Sem sombra padrão sob o AppBar
        centerTitle: true, // Centralização padrão do título
      ),

      // Estilização global para campos de entrada de texto (TextField / TextFormField)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.inputBg, // Cor de fundo dos campos
        labelStyle: const TextStyle(
          color: AppColors.primaryLight, // Cor dos rótulos/labels dos campos
          fontSize: 12,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
        // Borda padrão dos campos
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border, width: 1.5),
        ),
        // Borda quando o campo está habilitado mas inativo
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border, width: 1.5),
        ),
        // Borda quando o campo está em foco (selecionado para digitação)
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),

      // Estilização global para os botões elevados (ElevatedButton)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary, // Cor de fundo do botão
          foregroundColor: Colors.white, // Cor do texto do botão
          minimumSize: const Size.fromHeight(48), // Altura padrão de 48px
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14), // Cantos arredondados
          ),
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
