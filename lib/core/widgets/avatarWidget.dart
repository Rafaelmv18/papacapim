// TODO Implement this library.
import 'package:flutter/material.dart';

// Widget sem estado (StatelessWidget) reutilizável para renderizar avatares circulares com as iniciais do usuário
class AvatarWidget extends StatelessWidget {
  // Iniciais do nome do usuário que serão exibidas no centro do avatar (Ex: "RF", "AC")
  final String initials;
  // Cor de fundo do círculo do avatar
  final Color color;
  // Diâmetro do avatar em pixels (com valor padrão de 40)
  final double size;

  const AvatarWidget({
    super.key,
    required this.initials,
    required this.color,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size, // Largura definida pelo diâmetro do avatar
      height:
          size, // Altura igual à largura para manter a proporção perfeitamente quadrada/circular
      // Define o fundo com a cor personalizada e o formato estritamente circular
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      alignment: Alignment
          .center, // Centraliza o texto das iniciais exatamente no meio do círculo
      child: Text(
        initials,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize:
              size *
              0.36, // Tamanho da fonte dinâmico e proporcional de 36% do diâmetro total
        ),
      ),
    );
  }
}
