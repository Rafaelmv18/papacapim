import 'package:flutter/material.dart';
import 'package:papacapim/core/theme/appColors.dart';
import 'package:papacapim/core/widgets/postCard.dart';
import 'package:papacapim/features/profile/screens/profileUser.dart';

// Widget sem estado (StatelessWidget) responsável por exibir a lista de posts encontrados na busca
class SearchPostsList extends StatelessWidget {
  // Lista com os mapas de dados de cada postagem a ser exibida
  final List<Map<String, dynamic>> posts;
  // Flag para definir se a lista será exibida de forma reduzida (modo prévia/resumo)
  final bool isPreview;
  // Callback opcional para acionar o modo de visualização completa ao clicar em "Ver mais"
  final VoidCallback? onSeeMore;

  const SearchPostsList({
    super.key,
    required this.posts,
    this.isPreview = false,
    this.onSeeMore,
  });

  @override
  Widget build(BuildContext context) {
    // Se estiver no modo prévia e houver mais de 2 posts, limita a exibição aos 2 primeiros
    final listItems = isPreview && posts.length > 2
        ? posts.sublist(0, 2)
        : posts;

    // Construção do componente de lista encadeada (ListView.builder)
    Widget list = ListView.builder(
      shrinkWrap: isPreview, // Ajusta o tamanho dinamicamente se for prévia
      physics: isPreview
          ? const NeverScrollableScrollPhysics() // Desativa a rolagem interna no modo prévia
          : const AlwaysScrollableScrollPhysics(), // Habilita a rolagem padrão no modo tela cheia
      padding: isPreview
          ? EdgeInsets.zero
          : const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: listItems.length,
      itemBuilder: (context, index) {
        final post = listItems[index];

        // Captura o clique em cada card para direcionar para o perfil do autor
        return GestureDetector(
          behavior: HitTestBehavior
              .opaque, // Garante clique em toda a extensão do card
          onTap: () {
            // Unfocus no teclado para fechar o teclado da barra de busca
            FocusScope.of(context).unfocus();

            // Navegação para a tela de perfil do usuário
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfileUser()),
            );
          },
          // Renderiza o componente PostCard passando todas as informações do mapa
          child: PostCard(
            userName: post['name'],
            userHandle: post['username'] ?? '',
            postDate: post['time'],
            description: post['content'],
            initials: post['initials'] ?? 'P',
            avatarColor: post['color'] ?? AppColors.primary,
            likesCount: post['likes'] ?? 0,
            commentsCount: post['comments'] ?? 0,
            showFollowButton:
                true, // Exibe o botão de seguir no resultado da busca
          ),
        );
      },
    );

    // Se não for prévia, retorna apenas a ListView montada
    if (!isPreview) return list;

    // Caso seja modo prévia, envolve a lista em uma Column com o cabeçalho e botão "Ver mais"
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Posts',
              style: TextStyle(
                color: AppColors.text,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Exibe o botão de ação "Ver mais" caso a callback tenha sido fornecida
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
        list, // Renderiza a prévia da lista logo abaixo do cabeçalho
      ],
    );
  }
}
