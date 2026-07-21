import 'package:flutter/material.dart';
import 'package:papacapim/features/feed/screens/feedScreen.dart';
import 'package:papacapim/features/search/screens/searchScreen.dart';
import 'package:papacapim/features/post_creation/screens/createPostScreen.dart';
import 'package:papacapim/features/profile/screens/profileScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 1. Variável que guarda o índice da aba atualmente selecionada (0 = Feed)
  int _currentIndex = 0;

  // 2. Lista com as 4 telas que serão exibidas de acordo com o clique no menu
  final List<Widget> _screens = [
    const FeedScreen(),
    const SearchScreen(),
    const CreatePostScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Exibe a tela correspondente ao índice selecionado
      body: _screens[_currentIndex],

      // 3. A Barra de Navegação no Rodapé
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Atualiza a aba selecionada
          });
        },
        type: BottomNavigationBarType
            .fixed, // Mantém os 4 itens visíveis e alinhados
        selectedItemColor: Colors.green, // Cor do ícone ativo (Papacapim)
        unselectedItemColor: Colors.grey, // Cor dos ícones inativos
        items: const [
          BottomNavigationBarTypeItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Feed',
          ),
          BottomNavigationBarTypeItem(
            icon: Icon(Icons.search_outlined),
            activeIcon: Icon(Icons.search),
            label: 'Buscar',
          ),
          BottomNavigationBarTypeItem(
            icon: Icon(Icons.add_box_outlined),
            activeIcon: Icon(Icons.add_box),
            label: 'Publicar',
          ),
          BottomNavigationBarTypeItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}

// Classe auxiliar apenas para corrigir a sintaxe dos itens do menu
class BottomNavigationBarTypeItem extends BottomNavigationBarItem {
  const BottomNavigationBarTypeItem({
    required super.icon,
    super.activeIcon,
    required super.label,
  });
}
