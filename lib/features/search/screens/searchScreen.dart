import 'package:flutter/material.dart';
import '../widgets/searchUsersList.dart';
import '../widgets/searchPostsList.dart';

// Enumeração para gerenciar os modos de visualização da tela de busca
enum SearchMode { home, allUsers, allPosts }

// Widget com estado (StatefulWidget) para controlar a busca e os modos de navegação interna
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

// Classe de estado da tela de busca
class _SearchScreenState extends State<SearchScreen> {
  // Controller do campo de entrada da barra de pesquisa
  final TextEditingController _searchController = TextEditingController();
  // Estado atual do modo de visualização (inicia na tela principal de busca)
  SearchMode _currentMode = SearchMode.home;

  // Lista simulada (mock) de usuários para os resultados de busca
  final List<Map<String, dynamic>> _mockUsers = [
    {
      'initials': 'LF',
      'name': 'Lucas Ferreira',
      'username': '@lucas_f',
      'color': Colors.blue,
    },
    {
      'initials': 'AC',
      'name': 'Ana Costa',
      'username': '@ana.costa',
      'color': Colors.purple,
    },
    {
      'initials': 'PS',
      'name': 'Pedro Santos',
      'username': '@pedrodev',
      'color': Colors.red,
    },
    {
      'initials': 'JL',
      'name': 'Julia Lima',
      'username': '@juliaeats',
      'color': Colors.orange,
    },
  ];

  // Lista simulada (mock) de postagens para os resultados de busca
  final List<Map<String, dynamic>> _mockPosts = [
    {
      'initials': 'LF',
      'color': Colors.blue,
      'name': 'Lucas Ferreira',
      'username': '@lucas_f',
      'time': '2h',
      'content': 'Acabei de chegar em Florianópolis!',
      'likes': 84,
      'comments': 12,
    },
  ];

  // Listas filtradas dinamicamente com base no texto digitado na pesquisa
  late List<Map<String, dynamic>> _filteredUsers;
  late List<Map<String, dynamic>> _filteredPosts;

  @override
  void initState() {
    super.initState();
    // Inicializa as listas filtradas com a totalidade dos dados mockados
    _filteredUsers = _mockUsers;
    _filteredPosts = _mockPosts;
  }

  @override
  void dispose() {
    // Libera os recursos alocados pelo controller ao descartar o widget
    _searchController.dispose();
    super.dispose();
  }

  // Função responsável por filtrar os dados conforme o texto inserido
  void _onSearchChanged(String query) {
    final input = query.toLowerCase();
    setState(() {
      // Filtra a lista de usuários pelo nome ou username
      _filteredUsers = _mockUsers.where((user) {
        return (user['name'] ?? '').toString().toLowerCase().contains(input) ||
            (user['username'] ?? '').toString().toLowerCase().contains(input);
      }).toList();

      // Filtra a lista de posts pelo conteúdo ou nome do autor
      _filteredPosts = _mockPosts.where((post) {
        return (post['content'] ?? '').toString().toLowerCase().contains(
              input,
            ) ||
            (post['name'] ?? '').toString().toLowerCase().contains(input);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Captura o evento de voltar do dispositivo para alternar entre os modos de busca
    return WillPopScope(
      onWillPop: () async {
        // Se estiver vendo a lista completa de usuários ou posts, retorna para o modo 'home'
        if (_currentMode != SearchMode.home) {
          setState(() => _currentMode = SearchMode.home);
          return false;
        }
        return true; // Permite o comportamento padrão de voltar caso esteja no modo 'home'
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF4E342E), // Cor tom café
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              // Exibe o botão de voltar interno caso esteja no modo detalhado
              if (_currentMode != SearchMode.home) ...[
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Color(0xFFEFEBE9)),
                  onPressed: () =>
                      setState(() => _currentMode = SearchMode.home),
                ),
                const SizedBox(width: 10),
              ],
              // Título dinâmico do AppBar dependendo do modo atual
              Text(
                _currentMode == SearchMode.allUsers
                    ? 'Usuários'
                    : _currentMode == SearchMode.allPosts
                    ? 'Postagens'
                    : 'Buscar',
                style: const TextStyle(
                  color: Color(0xFFEFEBE9),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          // Barra de pesquisa fixada na parte inferior da AppBar
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: SearchBar(
                controller: _searchController,
                elevation: const WidgetStatePropertyAll(0),
                backgroundColor: const WidgetStatePropertyAll(
                  Color(0x40000000),
                ),
                side: const WidgetStatePropertyAll(
                  BorderSide(color: Color(0x2EBCAAA4), width: 1.5),
                ),
                textStyle: const WidgetStatePropertyAll(
                  TextStyle(color: Color(0xFFEFEBE9), fontSize: 14),
                ),
                hintText: 'Buscar...',
                leading: const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Icon(Icons.search, color: Color(0xFFBCAAA4), size: 20),
                ),
                onChanged: _onSearchChanged,
              ),
            ),
          ),
        ),
        body: _buildBody(),
      ),
    );
  }

  // Alterna o corpo da tela com base no modo de busca ativo
  Widget _buildBody() {
    switch (_currentMode) {
      case SearchMode.allUsers:
        // Renderiza a lista completa de usuários
        return SearchUsersList(users: _filteredUsers);
      case SearchMode.allPosts:
        // Renderiza a lista completa de postagens
        return SearchPostsList(posts: _filteredPosts);
      case SearchMode.home:
        // Renderiza o resumo com prévia de usuários e prévia de postagens
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SearchUsersList(
                users: _filteredUsers,
                isPreview: true,
                onSeeMore: () =>
                    setState(() => _currentMode = SearchMode.allUsers),
              ),
              const SizedBox(height: 24),
              SearchPostsList(
                posts: _filteredPosts,
                isPreview: true,
                onSeeMore: () =>
                    setState(() => _currentMode = SearchMode.allPosts),
              ),
            ],
          ),
        );
    }
  }
}
