import 'package:flutter/material.dart';
import 'package:papacapim/core/widgets/postCard.dart';
import 'package:papacapim/features/profile/screens/profileUser.dart';

// Widget sem estado (StatelessWidget) responsável por exibir a aba 'Seguindo' do feed
class SeguindoScreen extends StatelessWidget {
  const SeguindoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista simulada (mock) contendo as postagens dos usuários que você segue
    final List<Map<String, dynamic>> mockPosts = [
      {
        'userName': 'Ana Júlia',
        'userHandle': '@anajulia_ux',
        'postDate': 'Há 3 horas',
        'description':
            'Acabei de lançar o design do meu novo projeto no Figma! O que acham destas cores?',
        'userImageUrl':
            'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150',
        'postImageUrl':
            'https://images.unsplash.com/photo-1581291518633-83b4ebd1d83e?w=500',
        'likes': 20,
        'comments': 5,
      },
      {
        'userName': 'Carlos Eduardo',
        'userHandle': '@carlo_dev',
        'postDate': 'Há 1 hora',
        'description':
            'Alguém mais está a ter problemas em configurar as rotas do Laravel com o Supabase? Aceito sugestões!',
        'userImageUrl':
            'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150',
        'postImageUrl': null,
        'likes': 100,
        'comments': 24,
      },
      {
        'userName': 'Maria Silva',
        'userHandle': '@mari_silva',
        'postDate': 'Há 5 minutos',
        'description':
            'A olhar para o céu hoje na Bahia, que dia maravilhoso para codificar em Flutter! ☀️💻',
        'userImageUrl':
            'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150',
        'postImageUrl':
            'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=500',
        'likes': 55,
        'comments': 10,
      },
    ];

    // Construtor otimizado para renderizar a lista de postagens
    return ListView.builder(
      itemCount:
          mockPosts.length, // Define a quantidade total de itens na lista
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      itemBuilder: (context, index) {
        final post = mockPosts[index];

        // Detecta o clique no card do post para redirecionar para a tela de perfil
        return GestureDetector(
          onTap: () {
            // Fecha o teclado se estiver aberto
            FocusScope.of(context).unfocus();

            // Ação de ir para o perfil ao clicar no post
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfileUser()),
            );
          },
          // Componente individual da postagem repassando os dados do mock
          child: PostCard(
            userName: post['userName']!,
            userHandle: post['userHandle'] ?? '',
            postDate: post['postDate']!,
            description: post['description']!,
            userImageUrl: post['userImageUrl'],
            postImageUrl: post['postImageUrl'],
            likesCount: post['likes'] ?? 0,
            commentsCount: post['comments'] ?? 0,
            showFollowButton:
                false, // Botão de seguir desativado na aba 'Seguindo'
          ),
        );
      },
    );
  }
}
