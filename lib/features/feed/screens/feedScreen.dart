import 'package:flutter/material.dart';
import 'package:papacapim/features/feed/screens/explorarScreen.dart';
import 'package:papacapim/features/feed/screens/seguindoScreen.dart';

// Widget com estado (StatefulWidget) para gerenciar o Feed principal com abas
class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

// Classe de estado da tela de Feed
class _FeedScreenState extends State<FeedScreen> {
  // Controller para o campo de pesquisa (se necessário em buscas internas)
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    // Libera a memória alocada pelo controller quando o widget é descartado
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Controller padrão do Flutter para gerenciar a navegação entre as duas abas
    return DefaultTabController(
      length: 2, // Quantidade total de abas (Seguindo e Explorar)
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, // Remove o botão de voltar padrão
          backgroundColor: const Color(0xFF4E342E), // Fundo tom café
          elevation: 0, // Remove a sombra flutuante sob o AppBar
          centerTitle: false, // Mantém o título alinhado à esquerda
          // 🎨 1. TÍTULO E LOGO (Lado Esquerdo)
          title: Row(
            children: [
              // Imagem da logo do aplicativo via URL da web com fallback para erro
              Image.network(
                'https://img.icons8.com/3d-fluency/512/duck.png',
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
              // Nome do aplicativo estilizado
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
                  // Exibe mensagem rápida no rodapé ao clicar no ícone de notificação
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Você não possui novas notificações!'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                icon: Stack(
                  children: [
                    // Ícone principal de sino
                    const Icon(
                      Icons.notifications_none_outlined,
                      color: Color(0xFFBCAAA4), // Cor fosca do tema café
                      size: 26,
                    ),
                    // Bolinha verde indicadora de novidades/alertas
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
                // Barra visual de seleção entre 'Seguindo' e 'Explorar'
                TabBar(
                  labelColor: const Color(
                    0xFF4CAF50,
                  ), // Cor do texto da aba ativa
                  unselectedLabelColor: const Color(
                    0xFFBCAAA4,
                  ), // Cor do texto inativo
                  indicatorColor: const Color(
                    0xFF4CAF50,
                  ), // Linha indicadora inferior
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
        // Alterna dinamicamente as telas de conteúdo conforme a aba selecionada
        body: const TabBarView(children: [SeguindoScreen(), ExplorarScreen()]),
      ),
    );
  }
}
