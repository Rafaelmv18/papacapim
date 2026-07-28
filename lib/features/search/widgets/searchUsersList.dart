import 'package:flutter/material.dart';
import 'package:papacapim/core/theme/appColors.dart';
import 'userTile.dart';
import 'package:papacapim/features/profile/screens/profileUser.dart';

class SearchUsersList extends StatelessWidget {
  final List<Map<String, dynamic>> users;
  final bool isPreview;
  final VoidCallback? onSeeMore;

  const SearchUsersList({
    super.key,
    required this.users,
    this.isPreview = false,
    this.onSeeMore,
  });

  @override
  Widget build(BuildContext context) {
    final listItems = isPreview && users.length > 4
        ? users.sublist(0, 4)
        : users;

    Widget list = ListView.separated(
      shrinkWrap: isPreview,
      physics: isPreview
          ? const NeverScrollableScrollPhysics()
          : const AlwaysScrollableScrollPhysics(),
      padding: isPreview ? EdgeInsets.zero : const EdgeInsets.all(16),
      itemCount: listItems.length,
      separatorBuilder: (context, index) => isPreview
          ? const Divider(color: Colors.white12, height: 16)
          : const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final user = listItems[index];
        
        // 1. Guarda o visual do usuário na variável (com ou sem a caixa em volta)
        Widget userWidget = isPreview
            ? UserTile(user: user)
            : Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border, width: 1),
                ),
                child: UserTile(user: user),
              );

        // 2. Abraça o visual com o GestureDetector invisível
        return GestureDetector(
          behavior: HitTestBehavior.opaque, // Mantém o clique no item todo, sem efeito de cor
          onTap: () {
            // Esconde o teclado caso esteja aberto
            FocusScope.of(context).unfocus();
            
            // Navega para o perfil
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfileUser(),
              ),
            );
          },
          child: userWidget,
        );
      },
    );

    if (!isPreview) return list;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Usuários',
                style: TextStyle(
                  color: AppColors.text,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (onSeeMore != null)
                TextButton(
                  onPressed: onSeeMore,
                  child: const Text(
                    'Ver mais',
                    style: TextStyle(color: AppColors.primary),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          list,
        ],
      ),
    );
  }
}