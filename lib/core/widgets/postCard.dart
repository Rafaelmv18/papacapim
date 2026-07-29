import 'package:flutter/material.dart';
import 'package:papacapim/core/theme/appColors.dart';
import 'package:papacapim/core/widgets/avatarWidget.dart';

// Widget com estado (StatefulWidget) responsável por renderizar o card individual de cada publicação
class PostCard extends StatefulWidget {
  final String userName;
  final String userHandle;
  final String postDate;
  final String description;
  final String? userImageUrl;
  final String? postImageUrl;
  final String initials;
  final Color avatarColor;
  final int likesCount;
  final int commentsCount;
  final bool showFollowButton;
  final bool isOwnPost;
  final VoidCallback? onDelete;

  const PostCard({
    super.key,
    required this.userName,
    this.userHandle = '',
    required this.postDate,
    required this.description,
    this.userImageUrl,
    this.postImageUrl,
    this.initials = 'P',
    this.avatarColor = AppColors.primary,
    this.likesCount = 0,
    this.commentsCount = 0,
    this.showFollowButton = false,
    this.isOwnPost = false,
    this.onDelete,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

// Classe de estado do PostCard
class _PostCardState extends State<PostCard> {
  // Variáveis de estado locais para gerenciar reatividade de interações
  bool isLiked = false;
  int currentLikes = 0;
  int currentComments = 0;
  bool isFollowing = false;

  // Lista local para armazenar os comentários simulados desta postagem
  final List<String> _commentsList = [
    'Comentário muito legal!',
    'Concordo totalmente com você.',
  ];

  @override
  void initState() {
    super.initState();
    // Inicializa os contadores de curtidas e comentários com base nas propriedades recebidas
    currentLikes = widget.likesCount;
    currentComments = widget.commentsCount + _commentsList.length;
  }

  // 💬 Função que abre o modal inferior (BottomSheet) para exibição e criação de comentários
  void _openCommentsBottomSheet(BuildContext context) {
    final TextEditingController commentController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled:
          true, // Permite que o modal ajuste sua altura quando o teclado abre
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),

          // Preserva e atualiza o estado interno do BottomSheet sem reconstruir a tela inteira
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
              return Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.6,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Indicador visual de arraste no topo do modal
                    Center(
                      child: Container(
                        width: 36,
                        height: 4,
                        decoration: BoxDecoration(
                          color: AppColors.muted,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Comentários',
                      style: TextStyle(
                        color: AppColors.text,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Lista de Comentários existentes na publicação
                    Expanded(
                      child: _commentsList.isEmpty
                          ? const Center(
                              child: Text(
                                'Nenhum comentário ainda. Seja o primeiro!',
                                style: TextStyle(color: AppColors.muted),
                              ),
                            )
                          : ListView.separated(
                              shrinkWrap: true,
                              itemCount: _commentsList.length,
                              separatorBuilder: (context, index) =>
                                  const Divider(color: Colors.white12),
                              itemBuilder: (context, index) {
                                return ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: const AvatarWidget(
                                    initials: 'EU',
                                    color: AppColors.primary,
                                    size: 32,
                                  ),
                                  title: const Text(
                                    'Você',
                                    style: TextStyle(
                                      color: AppColors.text,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                  subtitle: Text(
                                    _commentsList[index],
                                    style: const TextStyle(
                                      color: AppColors.text,
                                      fontSize: 14,
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                    const SizedBox(height: 8),

                    // Campo de entrada de texto e botão para enviar um novo comentário
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: commentController,
                            style: const TextStyle(color: AppColors.text),
                            decoration: InputDecoration(
                              hintText: 'Escreva um comentário...',
                              hintStyle: const TextStyle(
                                color: AppColors.muted,
                              ),
                              filled: true,
                              fillColor: AppColors.card,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          onPressed: () {
                            if (commentController.text.trim().isNotEmpty) {
                              // Atualiza a lista interna do modal
                              setModalState(() {
                                _commentsList.add(
                                  commentController.text.trim(),
                                );
                              });
                              // Atualiza o contador visual na postagem pai
                              setState(() {
                                currentComments++;
                              });
                              commentController.clear();
                            }
                          },
                          icon: const Icon(
                            Icons.send,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ─── CABEÇALHO: Avatar, Nome, Username, Data e Botão Seguir ───
          Row(
            children: [
              // Renderiza CircleAvatar se houver URL de imagem, caso contrário utiliza AvatarWidget
              widget.userImageUrl != null
                  ? CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(widget.userImageUrl!),
                    )
                  : AvatarWidget(
                      initials: widget.initials,
                      color: widget.avatarColor,
                      size: 40,
                    ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.userName,
                      style: const TextStyle(
                        color: AppColors.text,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    if (widget.userHandle.isNotEmpty)
                      Text(
                        widget.userHandle,
                        style: const TextStyle(
                          color: AppColors.muted,
                          fontSize: 12,
                        ),
                      ),
                  ],
                ),
              ),
              Text(
                widget.postDate,
                style: const TextStyle(color: AppColors.muted, fontSize: 12),
              ),
              // Exibe botão condicional para seguir/deixar de seguir
              if (widget.showFollowButton) ...[
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isFollowing = !isFollowing;
                    });
                  },
                  child: Text(
                    isFollowing ? 'Seguindo' : '+ Seguir',
                    style: TextStyle(
                      color: isFollowing ? AppColors.muted : AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 10),

          // ─── CONTEÚDO: Descrição do Post e Imagem Anexada ───
          Text(
            widget.description,
            style: const TextStyle(
              color: AppColors.text,
              fontSize: 14,
              height: 1.4,
            ),
          ),

          if (widget.postImageUrl != null) ...[
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                widget.postImageUrl!,
                width: double.infinity,
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
          ],

          const SizedBox(height: 12),
          const Divider(color: Colors.white12, height: 1),
          const SizedBox(height: 8),

          // ─── RODAPÉ: Botões de Ação (Curtir, Comentar, Compartilhar e Deletar) ───
          Row(
            children: [
              // Ação de Curtir/Descurtir post
              GestureDetector(
                onTap: () {
                  setState(() {
                    isLiked = !isLiked;
                    isLiked ? currentLikes++ : currentLikes--;
                  });
                },
                child: Row(
                  children: [
                    Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      color: isLiked ? Colors.red : AppColors.muted,
                      size: 20,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '$currentLikes',
                      style: TextStyle(
                        color: isLiked ? Colors.red : AppColors.muted,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 24),

              // Ação de Comentários / Respostas (Abre o BottomSheet)
              GestureDetector(
                onTap: () => _openCommentsBottomSheet(context),
                child: Row(
                  children: [
                    const Icon(
                      Icons.chat_bubble_outline,
                      color: AppColors.muted,
                      size: 20,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '$currentComments',
                      style: const TextStyle(
                        color: AppColors.muted,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 24),

              // Ação de Compartilhar
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Link copiado para a área de transferência!',
                      ),
                      backgroundColor: AppColors.primary,
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                child: const Icon(
                  Icons.share_outlined,
                  color: AppColors.muted,
                  size: 20,
                ),
              ),

              const Spacer(),

              // Ação condicional de Deletar publicação (Apenas para posts próprios)
              if (widget.isOwnPost && widget.onDelete != null)
                GestureDetector(
                  onTap: widget.onDelete,
                  child: const Icon(
                    Icons.delete_outline,
                    color: Colors.redAccent,
                    size: 20,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
