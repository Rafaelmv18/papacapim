import 'package:flutter/material.dart';
import 'package:papacapim/core/theme/appColors.dart';
import 'package:papacapim/core/widgets/avatarWidget.dart';

class PostCard extends StatefulWidget {
  final String userName;
  final String userHandle; // Ex: @mariana
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

class _PostCardState extends State<PostCard> {
  late bool isLiked;
  late int currentLikes;
  bool isFollowing = false;

  @override
  void initState() {
    super.initState();
    isLiked = false;
    currentLikes = widget.likesCount;
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
          // ─── CABEÇALHO: Avatar, Nome, Username, Data e Botões ───
          Row(
            children: [
              // Avatar
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

              // Nome e Username
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

              // Data da postagem
              Text(
                widget.postDate,
                style: const TextStyle(color: AppColors.muted, fontSize: 12),
              ),

              // Botão "Seguir" (se configurado)
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

          // ─── CONTEÚDO: Texto e Imagem ───
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

          // ─── RODAPÉ: Curtir, Comentar, Compartilhar e Deletar ───
          Row(
            children: [
              // Curtir
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

              // Comentários / Respostas
              Row(
                children: [
                  const Icon(
                    Icons.chat_bubble_outline,
                    color: AppColors.muted,
                    size: 20,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '${widget.commentsCount}',
                    style: const TextStyle(
                      color: AppColors.muted,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 24),

              // Compartilhar
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

              // Deletar (Se for o próprio post)
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
