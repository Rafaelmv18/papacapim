import 'package:flutter/material.dart';
import '../widgets/postCard.dart'; // Importa o widget do cartão que criamos

class ExplorarScreen extends StatelessWidget {
  const ExplorarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Criamos uma lista fictícia de publicações (Mocks) para apresentar na interface
    final List<Map<String, String?>> mockPosts = [
      {
        'userName': 'Maria Silva',
        'postDate': 'Há 5 minutos',
        'description':
            'A olhar para o céu hoje na Bahia, que dia maravilhoso para codificar em Flutter! ☀️💻',
        'userImageUrl':
            'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150',
        'postImageUrl':
            'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=500',
      },
      {
        'userName': 'Carlos Eduardo',
        'postDate': 'Há 1 hora',
        'description':
            'Alguém mais está a ter problemas em configurar as rotas do Laravel com o Supabase? Aceito sugestões!',
        'userImageUrl':
            'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150',
        'postImageUrl': null, // Post sem imagem anexada
      },
      {
        'userName': 'Ana Júlia',
        'postDate': 'Há 3 horas',
        'description':
            'Acabei de lançar o design do meu novo projeto no Figma! O que acham destas cores?',
        'userImageUrl':
            'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150',
        'postImageUrl':
            'https://images.unsplash.com/photo-1581291518633-83b4ebd1d83e?w=500',
      },
      {
        'userName': 'Ana Júlia',
        'postDate': 'Há 3 horas',
        'description':
            'Acabei de lançar o design do meu novo projeto no Figma! O que acham destas cores?',
      },
    ];

    return ListView.builder(
      itemCount: mockPosts.length,
      padding: const EdgeInsets.only(top: 8, bottom: 16),
      itemBuilder: (context, index) {
        final post = mockPosts[index];
        return PostCard(
          userName: post['userName']!,
          postDate: post['postDate']!,
          description: post['description']!,
          userImageUrl: post['userImageUrl'],
          postImageUrl: post['postImageUrl'],
          showFollowButton: true,
        );
      },
    );
  }
}
