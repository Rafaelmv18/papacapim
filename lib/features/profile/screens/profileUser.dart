import 'package:flutter/material.dart';
import 'package:papacapim/core/theme/appColors.dart';
import 'package:papacapim/core/widgets/postCard.dart';
import '../../../core/widgets/avatarWidget.dart';

// Widget com estado (StatefulWidget) para exibição do perfil de outros usuários da plataforma
class ProfileUser extends StatefulWidget {
  const ProfileUser({super.key});

  @override
  State<ProfileUser> createState() => _ProfileUserState();
}

// Classe de estado da tela de Perfil do Usuário
class _ProfileUserState extends State<ProfileUser> {
  // Controle do estado local do botão de seguir/deixar de seguir
  bool isFollowing = false;

  // Lista mockada de postagens do usuário visualizado
  final List<Map<String, dynamic>> mockPosts = [
    {
      'id': '1',
      'initials': 'LF',
      'color': Colors.blue,
      'name': 'Lucas Ferreira',
      'username': '@lucas_f',
      'time': '2h',
      'content':
          'Acabei de chegar em Florianópolis! As praias aqui são simplesmente incríveis. Alguém tem dica de restaurante?',
      'likes': 84,
      'comments': 12,
      'isLiked': false,
    },
    {
      'id': '2',
      'initials': 'LF',
      'color': Colors.blue,
      'name': 'Lucas Ferreira',
      'username': '@lucas_f',
      'time': '4h',
      'content':
          'Dia produtivo de muito código e café! A arquitetura do app está ficando excelente.',
      'likes': 231,
      'comments': 47,
      'isLiked': true,
    },
  ];

  // Helper widget para estruturação das colunas de estatísticas (seguidores/seguindo)
  Widget _buildStatColumn(String number, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          number,
          style: const TextStyle(
            color: AppColors.text,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(color: AppColors.muted, fontSize: 12),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Sem automaticamenteImplyLeading para preservar o botão de voltar padrão da navegação
        title: const Text(
          '@lucas_f', // Mock de username genérico exibido no centro
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.text,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Colors.white12, height: 1.0),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── CABEÇALHO DO PERFIL: Usuário e Bio ───
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Avatar visual do usuário com iniciais
                        const AvatarWidget(
                          initials: 'LF',
                          color: Colors.blue,
                          size: 80,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Lucas Ferreira',
                                style: TextStyle(
                                  color: AppColors.text,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                '@lucas_f',
                                style: TextStyle(
                                  color: AppColors.muted,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 12),
                              // Métricas numéricas de seguidores e seguindo
                              Row(
                                children: [
                                  _buildStatColumn('3.5k', 'seguidores'),
                                  const SizedBox(width: 24),
                                  _buildStatColumn('152', 'seguindo'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Texto descritivo da bio do usuário
                    const Text(
                      'Desenvolvedor mobile focado em Flutter. Compartilhando a jornada técnica e algumas viagens.',
                      style: TextStyle(
                        color: AppColors.text,
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // ─── BOTÃO SEGUIR / SEGUINDO ───
                    SizedBox(
                      width: double.infinity,
                      child: isFollowing
                          ? OutlinedButton(
                              onPressed: () {
                                setState(() => isFollowing = false);
                              },
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                side: BorderSide(
                                  color: AppColors.muted.withOpacity(0.5),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'Seguindo',
                                style: TextStyle(
                                  color: AppColors.text,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          : ElevatedButton(
                              onPressed: () {
                                setState(() => isFollowing = true);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'Seguir',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),

            // ─── TÍTULO DA SEÇÃO DE POSTAGENS ───
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: Colors.white12)),
              ),
              padding: const EdgeInsets.only(left: 16, top: 16, bottom: 8),
              child: const Text(
                'POSTAGENS',
                style: TextStyle(
                  color: AppColors.muted,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
            ),

            // ─── LISTA DE POSTAGENS ───
            ListView.builder(
              shrinkWrap: true,
              physics:
                  const NeverScrollableScrollPhysics(), // Evita conflito de rolagens com a tela externa
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
              itemCount: mockPosts.length,
              itemBuilder: (context, index) {
                final post = mockPosts[index];

                return PostCard(
                  userName: post['name'],
                  userHandle: post['username'] ?? '',
                  postDate: post['time'],
                  description: post['content'],
                  initials: post['initials'] ?? 'U',
                  avatarColor: post['color'] ?? AppColors.primary,
                  likesCount: post['likes'] ?? 0,
                  commentsCount: post['comments'] ?? 0,
                  isOwnPost:
                      false, // Desabilita o ícone de remoção (lixeira) por não ser o próprio perfil
                  showFollowButton:
                      false, // Oculta botão individual de seguir nos cards do próprio perfil
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
