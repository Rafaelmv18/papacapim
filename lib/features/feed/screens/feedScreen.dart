import 'package:flutter/material.dart';
import 'package:papacapim/features/feed/screens/explorarScreen.dart';
import 'package:papacapim/features/feed/screens/seguindoScreen.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          // Fundo Café Escuro da TopBar (como no protótipo)
          backgroundColor: const Color(0xFF4E342E),
          elevation: 0,
          centerTitle:
              false, // Alinha à esquerda caso queira colocar a imagem do lado
          // 🎨 TÍTULO PAPACAPIM ESTILIZADO
          title: Row(
            children: [
              // Ícone ou mini-logo opcional
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.flutter_dash,
                  size: 18,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'Papacapim',
                style: TextStyle(
                  color: Color(0xFFEFEBE9), // Cor clara de texto do tema
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),

          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(130),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  // 🎨 SEARCH BAR COM O DESIGN DO PROTÓTIPO
                  child: SearchBar(
                    controller: _searchController,
                    elevation: const WidgetStatePropertyAll(
                      0,
                    ), // Sem sombra forte solta
                    backgroundColor: const WidgetStatePropertyAll(
                      Color(0x40000000), // Fundo escuro transparente (inputBg)
                    ),
                    side: const WidgetStatePropertyAll(
                      BorderSide(
                        color: Color(0x2EBCAAA4),
                        width: 1,
                      ), // Borda fina sutil
                    ),
                    textStyle: const WidgetStatePropertyAll(
                      TextStyle(
                        color: Color(0xFFEFEBE9),
                        fontSize: 14,
                      ), // Texto digitado em tom claro
                    ),
                    hintText: 'Pesquisar...',
                    hintStyle: const WidgetStatePropertyAll(
                      TextStyle(
                        color: Color(0xFFBCAAA4),
                        fontSize: 14,
                      ), // Texto "Pesquisar..." em cinza/café
                    ),
                    leading: const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Icon(
                        Icons.search,
                        color: Color(0xFFBCAAA4),
                        size: 20,
                      ),
                    ),
                    padding: const WidgetStatePropertyAll<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 12.0),
                    ),
                    onTap: () {
                      print('SearchBar clicada');
                    },
                  ),
                ),

                // 🎨 TABBAR COM CORES HARMONIZADAS
                TabBar(
                  labelColor: const Color(0xFF4CAF50), // Verde ativo
                  unselectedLabelColor: const Color(
                    0xFFBCAAA4,
                  ), // Cinza inativo
                  indicatorColor: const Color(0xFF4CAF50), // Linha verde
                  indicatorWeight: 3.0,
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  tabs: const [
                    Tab(text: "Seguindo"),
                    Tab(text: "Explorar"),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: const TabBarView(children: [SeguindoScreen(), ExplorarScreen()]),
      ),
    );
  }
}
