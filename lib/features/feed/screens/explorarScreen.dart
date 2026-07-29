import 'package:flutter/material.dart';
import 'package:papacapim/core/widgets/postCard.dart';
import 'package:papacapim/features/profile/screens/profileUser.dart';

// Widget sem estado (StatelessWidget) responsável por exibir a aba 'Explorar' do feed
class ExplorarScreen extends StatelessWidget {
  const ExplorarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista simulada (mock) contendo as postagens recomendadas com métricas e detalhes do usuário
    final List<Map<String, dynamic>> mockPosts = [
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
        'likes': 892,
        'comments': 145,
      },
      {
        'userName': 'Carlos Eduardo',
        'userHandle': '@carlos.dev',
        'postDate': 'Há 1 hora',
        'description':
            'Alguém mais está a ter problemas em configurar as rotas do Laravel com o Supabase? Aceito sugestões!',
        'userImageUrl':
            'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150',
        'postImageUrl': null,
        'likes': 32,
        'comments': 8,
      },
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
        'likes': 156,
        'comments': 24,
      },
    ];

    // Construtor otimizado para renderizar a lista de postagens
    return ListView.builder(
      itemCount: mockPosts.length, // Quantidade de itens na lista de exibição
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      itemBuilder: (context, index) {
        final post = mockPosts[index];

        // Detecta o toque na publicação para navegar até o perfil do autor
        return GestureDetector(
          behavior: HitTestBehavior
              .opaque, // Garante que cliques em áreas transparentes também sejam capturados
          onTap: () {
            // Fecha o teclado se estiver aberto
            FocusScope.of(context).unfocus();

            // Ação de ir para o perfil ao clicar no post
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfileUser()),
            );
          },
          // Card individual da publicação repassando todos os dados do mock
          child: PostCard(
            userName: post['userName']!,
            userHandle: post['userHandle'] ?? '',
            postDate: post['postDate']!,
            description: post['description']!,
            userImageUrl: post['userImageUrl'],
            postImageUrl: post['postImageUrl'],
            likesCount: post['likes'] ?? 0,
            commentsCount: post['comments'] ?? 0,
            showFollowButton: true, // Exibe o botão '+ Seguir' na aba Explorar
          ),
        );
      },
    );
  }
}
