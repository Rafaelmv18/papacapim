import 'package:flutter/material.dart';

class PostCard extends StatefulWidget {
  final String userName;
  final String postDate;
  final String description;
  final String? userImageUrl;
  final String? postImageUrl;
  final bool showFollowButton;

  const PostCard({
    super.key,
    required this.userName,
    required this.postDate,
    required this.description,
    this.userImageUrl,
    this.postImageUrl,
    this.showFollowButton = false,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLiked = false;
  bool isFollowing = false;

  @override
  Widget build(BuildContext context) {
    // Acessa o tema global
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cabeçalho: Foto, Nome, Data e Botão Seguir / Opções
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: theme.colorScheme.primary.withOpacity(0.15),
                  backgroundImage: widget.userImageUrl != null
                      ? NetworkImage(widget.userImageUrl!)
                      : null,
                  child: widget.userImageUrl == null
                      ? Text(
                          widget.userName[0].toUpperCase(),
                          style: TextStyle(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.userName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        widget.postDate,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),

                // Botão "Seguir" na aba Explorar
                if (widget.showFollowButton)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isFollowing = !isFollowing;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            isFollowing
                                ? 'Agora você está seguindo ${widget.userName}!'
                                : 'Você deixou de seguir ${widget.userName}.',
                          ),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: isFollowing
                          ? Colors.grey
                          : theme.colorScheme.primary,
                    ),
                    child: Text(
                      isFollowing ? 'Seguindo' : 'Seguir',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),

                // Opções de post na aba Seguindo
                if (!widget.showFollowButton)
                  IconButton(
                    icon: const Icon(Icons.more_vert, color: Colors.grey),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Simulação: Opções do post'),
                        ),
                      );
                    },
                  ),
              ],
            ),
            const SizedBox(height: 12),

            // Descrição do Post
            Text(
              widget.description,
              style: const TextStyle(fontSize: 14, height: 1.4),
            ),

            // Imagem do Post (se houver)
            if (widget.postImageUrl != null) ...[
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  widget.postImageUrl!,
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
            ],
            const Divider(height: 24),

            // Barra de Ações: Curtir, Responder e Compartilhar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Curtir
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      isLiked = !isLiked;
                    });
                  },
                  icon: Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    color: isLiked ? Colors.red : Colors.grey,
                  ),
                  label: Text(
                    'Curtir',
                    style: TextStyle(color: isLiked ? Colors.red : Colors.grey),
                  ),
                ),

                // Responder
                TextButton.icon(
                  onPressed: () {
                    _showReplyDialog(context);
                  },
                  icon: const Icon(Icons.comment_outlined, color: Colors.grey),
                  label: const Text(
                    'Responder',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),

                // Compartilhar
                TextButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text(
                          'Link copiado para a área de transferência!',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: theme.colorScheme.primary,
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                  icon: const Icon(Icons.share, color: Colors.grey),
                  label: const Text(
                    'Compartilhar',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showReplyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Responder a ${widget.userName}'),
          content: const TextField(
            decoration: InputDecoration(hintText: 'Escreva sua resposta...'),
            maxLines: 3,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Resposta enviada (Simulado)!')),
                );
              },
              child: const Text('Enviar'),
            ),
          ],
        );
      },
    );
  }
}
