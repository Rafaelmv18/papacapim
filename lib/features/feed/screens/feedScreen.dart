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
          backgroundColor: const Color(0xFF4E342E), // Fundo tom café
          elevation: 0,
          centerTitle: false, // Mantém o título alinhado à esquerda
          // 🎨 1. TÍTULO E LOGO (Lado Esquerdo)
          title: Row(
            children: [
              Image.asset(
                'assets/logo.png',
                height: 28,
                width: 28,
                errorBuilder: (context, error, stackTrace) => Container(
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
              ),
              const SizedBox(width: 10),
              const Text(
                'Papacapim',
                style: TextStyle(
                  color: Color(0xFFEFEBE9),
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),

          // 🔔 2. BOTÃO DE NOTIFICAÇÃO (Lado Direito do Header)
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Você não possui novas notificações!'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                icon: Stack(
                  children: [
                    const Icon(
                      Icons.notifications_none_outlined,
                      color: Color(0xFFBCAAA4), // Cor fosca do tema café
                      size: 26,
                    ),
                    // Bolinha indicadora de notificação
                    Positioned(
                      top: 2,
                      right: 2,
                      child: Container(
                        width: 9,
                        height: 9,
                        decoration: const BoxDecoration(
                          color: Color(0xFF4CAF50), // Verde em destaque
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],

          // 🎨 3. SUAS ABAS (Bottom do AppBar)
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(
              48,
            ), // Ajustado para a altura da TabBar
            child: Column(
              children: [
                TabBar(
                  labelColor: const Color(0xFF4CAF50),
                  unselectedLabelColor: const Color(0xFFBCAAA4),
                  indicatorColor: const Color(0xFF4CAF50),
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
