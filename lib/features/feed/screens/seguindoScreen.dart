import 'package:flutter/material.dart';
import 'package:papacapim/core/widgets/postCard.dart';
import 'package:papacapim/features/profile/screens/profileUser.dart';

class SeguindoScreen extends StatelessWidget {
  const SeguindoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String?>> mockPosts = [
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
        'userName': 'Carlos Eduardo',
        'postDate': 'Há 1 hora',
        'description':
            'Alguém mais está a ter problemas em configurar as rotas do Laravel com o Supabase? Aceito sugestões!',
        'userImageUrl':
            'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150',
        'postImageUrl': null,
      },
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
    ];

    return ListView.builder(
      itemCount: mockPosts.length,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      itemBuilder: (context, index) {
        final post = mockPosts[index];
        return GestureDetector(
          onTap: () {
            // Ação de ir para o perfil ao clicar no post
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfileUser()),
            );
          },
          child: PostCard(
            userName: post['userName']!,
            postDate: post['postDate']!,
            description: post['description']!,
            userImageUrl: post['userImageUrl'],
            postImageUrl: post['postImageUrl'],
            showFollowButton: false,
          ),
        );
      },
    );
  }
}
