import 'package:flutter/material.dart';
import 'package:papacapim/core/theme/appColors.dart';
import '../../../core/widgets/avatarWidget.dart';
import 'profileEdit.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final List<Map<String, dynamic>> mockPosts = [
    {
      'id': '1',
      'initials': 'MO',
      'color': Colors.green,
      'name': 'Mariana Oliveira',
      'username': '@mariana',
      'time': '2h',
      'content': 'Acabei de chegar em Florianópolis! As praias aqui são simplesmente incríveis. Alguém tem dica de restaurante?',
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
      'content': 'Finalmente terminei o redesign do nosso produto! Foram semanas de trabalho mas o resultado ficou incrível. Obrigada ao time todo!',
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
      'content': 'Dica do dia: quando você não consegue resolver um bug, vá tomar um café e volte depois.',
      'likes': 15,
      'comments': 3,
      'isLiked': false,
    },
  ];

  void _deletePost(String id) {
    setState(() {
      mockPosts.removeWhere((post) => post['id'] == id);
    });
  }

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
          style: const TextStyle(
            color: AppColors.muted,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          '@mariana',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.text),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        // Linha divisória logo abaixo do @mariana
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.white12,
            height: 1.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            // Usuário e Bio
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: const EdgeInsets.all(16.0), // Espaçamento interno
                decoration: BoxDecoration(
                  color: AppColors.card, // << AQUI APLICA A MESMA COR DOS POSTS
                  borderRadius: BorderRadius.circular(16), // Bordas arredondadas
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
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
                                style: TextStyle(color: AppColors.text, fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                '@mariana',
                                style: TextStyle(color: AppColors.muted, fontSize: 14),
                              ),
                              const SizedBox(height: 12),
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
                    
                    const Text(
                      'Desenvolvedora apaixonada por café e código.\nExplorando o mundo um commit de cada vez.',
                      style: TextStyle(color: AppColors.text, fontSize: 14, height: 1.4),
                    ),
                    const SizedBox(height: 20),
                    
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
                        icon: const Icon(Icons.edit, size: 16, color: AppColors.text),
                        label: const Text('Editar Perfil', style: TextStyle(color: AppColors.text, fontWeight: FontWeight.bold)),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          side: BorderSide(color: AppColors.muted.withOpacity(0.5)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // --- TÍTULO POSTAGENS ---
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: Colors.white12)),
              ),
              padding: const EdgeInsets.only(left: 16, top: 16, bottom: 8),
              child: const Text(
                'POSTAGENS',
                style: TextStyle(color: AppColors.muted, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.0),
              ),
            ),

            // --- LISTA DE POSTAGENS ---
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(), 
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
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
                      const Divider(color: Colors.white12),
                      
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
                                Text('${post['likes']}', style: TextStyle(color: post['isLiked'] ? Colors.red : AppColors.muted)),
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
                          const SizedBox(width: 24),
                          
                          const Icon(Icons.share_outlined, color: AppColors.muted, size: 20),
                          
                          const Spacer(),
                          
                          GestureDetector(
                            onTap: () => _deletePost(post['id']),
                            child: const Icon(Icons.delete, color: Colors.redAccent, size: 20),
                          ),
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
    );
  }
}