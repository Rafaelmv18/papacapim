import 'package:flutter/material.dart';
import 'package:papacapim/core/theme/appColors.dart';
import 'package:papacapim/core/widgets/avatarWidget.dart';

// Widget com estado (StatefulWidget) para renderizar a linha individual de informações de um usuário na busca
class UserTile extends StatefulWidget {
  // Mapa dinâmico contendo os dados do usuário (nome, username, cor, iniciais, estado de seguir)
  final Map<String, dynamic> user;

  const UserTile({super.key, required this.user});

  @override
  State<UserTile> createState() => _UserTileState();
}

// Classe de estado do UserTile
class _UserTileState extends State<UserTile> {
  // Variável de estado para controlar se o usuário está sendo seguido ou não
  bool isFollowing = false;

  @override
  void initState() {
    super.initState();
    // Inicializa com o estado do mock caso exista (ex: 'isFollowing': true)
    isFollowing = widget.user['isFollowing'] ?? false;
  }

  // Alterna o estado de seguir/deixar de seguir e exibe notificação visual na tela (SnackBar)
  void _toggleFollow() {
    setState(() {
      isFollowing = !isFollowing;
      widget.user['isFollowing'] =
          isFollowing; // Mantém o mapa sincronizado com o novo estado
    });

    // Limpa SnackBars anteriores antes de exibir a nova notificação
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isFollowing
              ? 'Você começou a seguir ${widget.user['name'] ?? widget.user['username']}'
              : 'Você deixou de seguir ${widget.user['name'] ?? widget.user['username']}',
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Avatar do Usuário renderizado via AvatarWidget reutilizável
        AvatarWidget(
          initials: widget.user['initials'] ?? 'U',
          color: widget.user['color'] ?? AppColors.primary,
          size: 42,
        ),
        const SizedBox(width: 12),

        // Nome completo e Username alinhados verticalmente
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.user['name'] ?? widget.user['username'] ?? 'Usuário',
                style: const TextStyle(
                  color: AppColors.text,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                maxLines: 1,
                overflow:
                    TextOverflow.ellipsis, // Corta textos longos com "..."
              ),
              Text(
                widget.user['username'] ?? '',
                style: const TextStyle(color: AppColors.muted, fontSize: 12),
              ),
            ],
          ),
        ),

        // 🔘 BOTÃO SEGUIR / SEGUINDO (Estilização e texto dinâmicos conforme o estado)
        OutlinedButton(
          onPressed: _toggleFollow,
          style: OutlinedButton.styleFrom(
            side: BorderSide(
              color: isFollowing ? AppColors.muted : AppColors.primary,
            ),
            backgroundColor: isFollowing
                ? Colors.transparent
                : AppColors.primary.withOpacity(0.1),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            minimumSize: const Size(80, 32),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Text(
            isFollowing ? 'Seguindo' : '+ Seguir',
            style: TextStyle(
              color: isFollowing ? AppColors.muted : AppColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
