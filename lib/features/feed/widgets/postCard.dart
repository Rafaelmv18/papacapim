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
  bool isFollowing = false; // Controla o estado visual do botão seguir

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cabeçalho: Foto, Nome, Data e Botão Seguir
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.green.shade100,
                  backgroundImage: widget.userImageUrl != null
                      ? NetworkImage(widget.userImageUrl!)
                      : null,
                  child: widget.userImageUrl == null
                      ? Text(
                          widget.userName[0].toUpperCase(),
                          style: const TextStyle(color: Colors.green),
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
                          fontSize: 16,
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
                      foregroundColor: isFollowing ? Colors.grey : Colors.green,
                    ),
                    child: Text(
                      isFollowing ? 'Seguindo' : 'Seguir',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),

                // Se não for para mostrar o botão Seguir, mostra as opções do post
                if (!widget.showFollowButton)
                  IconButton(
                    icon: const Icon(Icons.more_vert),
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

            // Barra de Ações: Curtir e Responder
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
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
                TextButton.icon(
                  onPressed: () {
                    // Exibe a mensagem de que o link foi copiado ou compartilhado
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Link copiado para a área de transferência!',
                        ),
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                  // 👇 Mudança aqui: usamos Icons.share para o símbolo correto de compartilhar
                  icon: const Icon(Icons.share, color: Colors.grey),
                  label: const Text('Compartilhar'),
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
            decoration: InputDecoration(
              hintText: 'Escreva sua resposta...',
              border: OutlineInputBorder(),
            ),
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
