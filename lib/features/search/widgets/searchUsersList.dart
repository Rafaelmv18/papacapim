import 'package:flutter/material.dart';
import 'package:papacapim/core/theme/appColors.dart';
import 'userTile.dart';
import 'package:papacapim/features/profile/screens/profileUser.dart';

// Widget sem estado (StatelessWidget) responsável por renderizar a lista de usuários encontrados na busca
class SearchUsersList extends StatelessWidget {
  // Lista com os dados dos usuários retornados na pesquisa
  final List<Map<String, dynamic>> users;
  // Flag para definir se a lista deve ser exibida de forma reduzida (modo prévia/resumo)
  final bool isPreview;
  // Callback opcional acionada ao clicar em "Ver mais" para expandir a lista
  final VoidCallback? onSeeMore;

  const SearchUsersList({
    super.key,
    required this.users,
    this.isPreview = false,
    this.onSeeMore,
  });

  @override
  Widget build(BuildContext context) {
    // Limita a exibição aos 4 primeiros usuários caso esteja no modo prévia
    final listItems = isPreview && users.length > 4
        ? users.sublist(0, 4)
        : users;

    // Construção da lista separada com dividers ou espaçadores
    Widget list = ListView.separated(
      shrinkWrap:
          isPreview, // Ajusta a altura de acordo com os itens se for prévia
      physics: isPreview
          ? const NeverScrollableScrollPhysics() // Desativa rolagem própria na prévia
          : const AlwaysScrollableScrollPhysics(), // Mantém rolagem na tela completa
      padding: isPreview ? EdgeInsets.zero : const EdgeInsets.all(16),
      itemCount: listItems.length,
      // Separador customizado dependendo do modo prévia ou lista cheia
      separatorBuilder: (context, index) => isPreview
          ? const Divider(color: Colors.white12, height: 16)
          : const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final user = listItems[index];

        // Define o estilo de container individual do UserTile para cada modo
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

        // Detecta o clique no usuário para navegar ao perfil
        return GestureDetector(
          behavior: HitTestBehavior
              .opaque, // Garante clique em toda a área do card/tile
          onTap: () {
            // Esconde o teclado caso esteja aberto
            FocusScope.of(context).unfocus();

            // Navega para o perfil do usuário
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfileUser()),
            );
          },
          child: userWidget,
        );
      },
    );

    // Se não for prévia, retorna apenas a lista separada
    if (!isPreview) return list;

    // Caso seja o modo prévia, envolve a lista em um Container com cabeçalho e botão "Ver mais"
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
              // Botão opcional "Ver mais"
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
          list, // Renderiza a lista reduzida abaixo do título
        ],
      ),
    );
  }
}
