import 'package:flutter/material.dart';
import '../widgets/searchUsersList.dart';
import '../widgets/searchPostsList.dart';

enum SearchMode { home, allUsers, allPosts }

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  SearchMode _currentMode = SearchMode.home;

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

  late List<Map<String, dynamic>> _filteredUsers;
  late List<Map<String, dynamic>> _filteredPosts;

  @override
  void initState() {
    super.initState();
    _filteredUsers = _mockUsers;
    _filteredPosts = _mockPosts;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    final input = query.toLowerCase();
    setState(() {
      _filteredUsers = _mockUsers.where((user) {
        return (user['name'] ?? '').toString().toLowerCase().contains(input) ||
            (user['username'] ?? '').toString().toLowerCase().contains(input);
      }).toList();

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
    return WillPopScope(
      onWillPop: () async {
        if (_currentMode != SearchMode.home) {
          setState(() => _currentMode = SearchMode.home);
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF4E342E),
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              if (_currentMode != SearchMode.home) ...[
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Color(0xFFEFEBE9)),
                  onPressed: () =>
                      setState(() => _currentMode = SearchMode.home),
                ),
                const SizedBox(width: 10),
              ],
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

  Widget _buildBody() {
    switch (_currentMode) {
      case SearchMode.allUsers:
        return SearchUsersList(users: _filteredUsers);
      case SearchMode.allPosts:
        return SearchPostsList(posts: _filteredPosts);
      case SearchMode.home:
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
