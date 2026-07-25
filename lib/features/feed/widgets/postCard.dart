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

  // 🎨 CORES DO TEMA DO PROTÓTIPO
  static const Color _cardBg = Color(0xFF5D4037);
  static const Color _textPrimary = Color(0xFFEFEBE9);
  static const Color _textMuted = Color(0xFFBCAAA4);
  static const Color _borderColor = Color(0x2EBCAAA4);
  static const Color _primaryGreen = Color(0xFF4CAF50);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: _cardBg, // Fundo do Card em tom Café
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _borderColor, width: 1),
        boxShadow: const [
          BoxShadow(
            color: Color(0x2E000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cabeçalho: Foto, Nome, Data e Botão Seguir / Opções
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: _primaryGreen.withOpacity(0.2),
                backgroundImage: widget.userImageUrl != null
                    ? NetworkImage(widget.userImageUrl!)
                    : null,
                child: widget.userImageUrl == null
                    ? Text(
                        widget.userName[0].toUpperCase(),
                        style: const TextStyle(
                          color: _primaryGreen,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.userName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: _textPrimary,
                      ),
                    ),
                    Text(
                      widget.postDate,
                      style: const TextStyle(color: _textMuted, fontSize: 11),
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
                    foregroundColor: isFollowing ? _textMuted : _primaryGreen,
                  ),
                  child: Text(
                    isFollowing ? 'Seguindo' : 'Seguir',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),

              // Opções de post na aba Seguindo
              if (!widget.showFollowButton)
                IconButton(
                  icon: const Icon(Icons.more_vert, color: _textMuted),
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
          const SizedBox(height: 10),

          // Descrição do Post
          Text(
            widget.description,
            style: const TextStyle(
              fontSize: 13,
              height: 1.5,
              color: _textPrimary,
            ),
          ),

          // Imagem do Post (se houver)
          if (widget.postImageUrl != null) ...[
            const SizedBox(height: 10),
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

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Divider(color: _borderColor, height: 1),
          ),

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
                  color: isLiked ? const Color(0xFFEF5350) : _textMuted,
                  size: 18,
                ),
                label: Text(
                  'Curtir',
                  style: TextStyle(
                    color: isLiked ? const Color(0xFFEF5350) : _textMuted,
                    fontSize: 12,
                  ),
                ),
              ),

              // Responder
              TextButton.icon(
                onPressed: () {
                  _showReplyDialog(context);
                },
                icon: const Icon(
                  Icons.comment_outlined,
                  color: _textMuted,
                  size: 18,
                ),
                label: const Text(
                  'Responder',
                  style: TextStyle(color: _textMuted, fontSize: 12),
                ),
              ),

              // Compartilhar
              TextButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Link copiado para a área de transferência!',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: _primaryGreen,
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                icon: const Icon(Icons.share, color: _textMuted, size: 18),
                label: const Text(
                  'Compartilhar',
                  style: TextStyle(color: _textMuted, fontSize: 12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showReplyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: _cardBg,
          title: Text(
            'Responder a ${widget.userName}',
            style: const TextStyle(color: _textPrimary),
          ),
          content: const TextField(
            style: TextStyle(color: _textPrimary),
            decoration: InputDecoration(
              hintText: 'Escreva sua resposta...',
              hintStyle: TextStyle(color: _textMuted),
            ),
            maxLines: 3,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancelar',
                style: TextStyle(color: _textMuted),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Resposta enviada (Simulado)!')),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: _primaryGreen),
              child: const Text('Enviar'),
            ),
          ],
        );
      },
    );
  }
}
