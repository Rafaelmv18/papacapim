import 'package:flutter/material.dart';
import 'package:papacapim/core/theme/appColors.dart';
import 'package:papacapim/core/widgets/postCard.dart';
import '../../../core/widgets/avatarWidget.dart';
import 'profileEdit.dart';

// Widget com estado (StatefulWidget) para gerenciar o perfil do usuário e suas postagens
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

// Classe de estado da tela de Perfil
class _ProfileScreenState extends State<ProfileScreen> {
  // Lista local simulada (mock) das postagens publicadas pelo próprio usuário
  final List<Map<String, dynamic>> mockPosts = [
    {
      'id': '1',
      'initials': 'MO',
      'color': Colors.green,
      'name': 'Mariana Oliveira',
      'username': '@mariana',
      'time': '2h',
      'content':
          'Acabei de chegar em Florianópolis! As praias aqui são simplesmente incríveis. Alguém tem dica de restaurante?',
      'likes': 84,
      'comments': 12,
      'isLiked': false,
    },
    {
      'id': '2',
      'initials': 'MO',
      'color': Colors.green,
      'name': 'Mariana Oliveira',
      'username': '@mariana',
      'time': '4h',
      'content':
          'Finalmente terminei o redesign do nosso produto! Foram semanas de trabalho mas o resultado ficou incrível. Obrigada ao time todo!',
      'likes': 231,
      'comments': 47,
      'isLiked': true,
    },
    {
      'id': '3',
      'initials': 'MO',
      'color': Colors.green,
      'name': 'Mariana Oliveira',
      'username': '@mariana',
      'time': '6h',
      'content':
          'Dica do dia: quando você não consegue resolver um bug, vá tomar um café e volte depois.',
      'likes': 15,
      'comments': 3,
      'isLiked': false,
    },
  ];

  // Função para deletar um post específico da lista pelo seu ID
  void _deletePost(String id) {
    setState(() {
      mockPosts.removeWhere((post) => post['id'] == id);
    });
  }

  // Helper widget para construir as colunas de métricas de seguidores e seguindo
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
        automaticallyImplyLeading: false, // Oculta botão automático de voltar
        title: const Text(
          '@mariana',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.text,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        // Linha divisória discreta logo abaixo do AppBar
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Colors.white12, height: 1.0),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── CABEÇALHO DO PERFIL: Avatar, Nome, Métricas e Bio ───
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: const EdgeInsets.all(16.0), // Espaçamento interno
                decoration: BoxDecoration(
                  color: AppColors
                      .card, // << Aplica a mesma cor de fundo dos cards de post
                  borderRadius: BorderRadius.circular(
                    16,
                  ), // Bordas arredondadas do container de perfil
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Avatar com as iniciais do usuário
                        const AvatarWidget(
                          initials: 'MO',
                          color: Color(0xFF2E7D32),
                          size: 80,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Mariana Oliveira',
                                style: TextStyle(
                                  color: AppColors.text,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                '@mariana',
                                style: TextStyle(
                                  color: AppColors.muted,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 12),
                              // Exibição dos contadores de seguidores e seguindo
                              Row(
                                children: [
                                  _buildStatColumn('1.247', 'seguidores'),
                                  const SizedBox(width: 24),
                                  _buildStatColumn('384', 'seguindo'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Bio / Descrição pessoal do perfil
                    const Text(
                      'Desenvolvedora apaixonada por café e código.\nExplorando o mundo um commit de cada vez.',
                      style: TextStyle(
                        color: AppColors.text,
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Botão para navegar até a tela de Edição de Perfil
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProfileEditScreen(),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.edit,
                          size: 16,
                          color: AppColors.text,
                        ),
                        label: const Text(
                          'Editar Perfil',
                          style: TextStyle(
                            color: AppColors.text,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          side: BorderSide(
                            color: AppColors.muted.withOpacity(0.5),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
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

            // ─── LISTA DE POSTAGENS DO PRÓPRIO USUÁRIO ───
            ListView.builder(
              shrinkWrap: true,
              physics:
                  const NeverScrollableScrollPhysics(), // Evita conflito de rolagem com o SingleChildScrollView
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
              itemCount: mockPosts.length,
              itemBuilder: (context, index) {
                final post = mockPosts[index];

                return PostCard(
                  userName: post['name'],
                  userHandle: post['username'] ?? '',
                  postDate: post['time'],
                  description: post['content'],
                  initials: post['initials'] ?? 'P',
                  avatarColor: post['color'] ?? AppColors.primary,
                  likesCount: post['likes'] ?? 0,
                  commentsCount: post['comments'] ?? 0,
                  isOwnPost: true, // Habilita o ícone da lixeira para exclusão
                  onDelete: () => _deletePost(post['id']),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
