import 'package:flutter/material.dart';
import 'package:papacapim/core/theme/appColors.dart';
import '../../../core/widgets/avatarWidget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  // 1. Mocks Atualizados sem repetição
  final List<Map<String, dynamic>> mockUsers = [
    {'initials': 'LF', 'username': '@lucas_f', 'color': Colors.blue},
    {'initials': 'AC', 'username': '@ana.c...', 'color': Colors.purple},
    {'initials': 'PS', 'username': '@pedro...', 'color': Colors.red},
    {'initials': 'JL', 'username': '@juliaeats', 'color': Colors.orange},
    {'initials': 'RN', 'username': '@rafaeln', 'color': Colors.teal},
    {'initials': 'CT', 'username': '@camilat', 'color': Colors.indigo},
    {'initials': 'DA', 'username': '@diegoalv', 'color': Colors.deepPurple},
    {'initials': 'BM', 'username': '@beam...', 'color': Colors.pink},
  ];

  final List<Map<String, dynamic>> mockPosts = [
    {
      'initials': 'LF',
      'color': Colors.blue,
      'name': 'Lucas Ferreira',
      'username': '@lucas_f',
      'time': '2h',
      'content': 'Acabei de chegar em Florianópolis! As praias aqui são simplesmente incríveis. Alguém tem dica de restaurante?',
      'likes': 84,
      'comments': 12,
      'isLiked': false,
    },
    {
      'initials': 'AC',
      'color': Colors.purple,
      'name': 'Ana Costa',
      'username': '@ana.costa',
      'time': '4h',
      'content': 'Finalmente terminei o redesign do nosso produto! Foram semanas de trabalho mas o resultado ficou incrível. Obrigada ao time todo!',
      'likes': 231,
      'comments': 47,
      'isLiked': true,
    },
    {
      'initials': 'PS',
      'color': Colors.red,
      'name': 'Pedro Santos',
      'username': '@pedrodev',
      'time': '6h',
      'content': 'Dica do dia: quando você não consegue resolver um bug, vá tomar um café e volte depois.',
      'likes': 15,
      'comments': 3,
      'isLiked': false,
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              // Barra de Busca
              TextField(
                controller: _searchController,
                style: const TextStyle(color: AppColors.text),
                decoration: InputDecoration(
                  hintText: 'Buscar usuários ou postagens...',
                  hintStyle: const TextStyle(color: AppColors.muted),
                  prefixIcon: const Icon(Icons.search, color: AppColors.muted),
                  filled: true,
                  fillColor: AppColors.card,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              // Usuários
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Usuários', style: TextStyle(color: AppColors.text, fontSize: 18, fontWeight: FontWeight.bold)),
                        TextButton(onPressed: () {}, child: const Text('Ver mais', style: TextStyle(color: AppColors.primary))),
                      ],
                    ),
                    const SizedBox(height: 12),
                    
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4, // Número de colunas
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 1.1,
                      ),
                      itemCount: mockUsers.length,
                      itemBuilder: (context, index) {
                        final user = mockUsers[index];
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AvatarWidget(
                              initials: user['initials'],
                              color: user['color'],
                              size: 50,
                            ),
                            const SizedBox(height: 6),
                            Text(user['username'], style: const TextStyle(color: AppColors.muted, fontSize: 11)),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              
              // POSTS
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Posts', style: TextStyle(color: AppColors.text, fontSize: 18, fontWeight: FontWeight.bold)),
                  TextButton(onPressed: () {}, child: const Text('Ver mais', style: TextStyle(color: AppColors.primary))),
                ],
              ),
              const SizedBox(height: 8),
              
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(), 
                itemCount: mockPosts.length,
                itemBuilder: (context, index) {
                  final post = mockPosts[index];
                  
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            AvatarWidget(initials: post['initials'], color: post['color'], size: 40),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(post['name'], style: const TextStyle(color: AppColors.text, fontWeight: FontWeight.bold)),
                                  Text(post['username'], style: const TextStyle(color: AppColors.muted, fontSize: 12)),
                                ],
                              ),
                            ),
                            Text(post['time'], style: const TextStyle(color: AppColors.muted, fontSize: 12)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        
                        Text(post['content'], style: const TextStyle(color: AppColors.text)),
                        const SizedBox(height: 12),
                        const Divider(color: Colors.white24),
                        
                        // Botões de Interação (Curtir, Comentar, Compartilhar)
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  post['isLiked'] = !post['isLiked'];
                                  post['isLiked'] ? post['likes']++ : post['likes']--;
                                });
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    post['isLiked'] ? Icons.favorite : Icons.favorite_border, 
                                    color: post['isLiked'] ? Colors.red : AppColors.muted, 
                                    size: 20
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    '${post['likes']}', 
                                    style: TextStyle(color: post['isLiked'] ? Colors.red : AppColors.muted)
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 24),
                            
                            Row(
                              children: [
                                const Icon(Icons.chat_bubble_outline, color: AppColors.muted, size: 20),
                                const SizedBox(width: 6),
                                Text('${post['comments']}', style: const TextStyle(color: AppColors.muted)),
                              ],
                            ),
                            const SizedBox(width: 24), // Espaço entre comentar e compartilhar
                            
                            const Icon(Icons.share_outlined, color: AppColors.muted, size: 20),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}