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
          title: const Text('Papacapim'),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(110),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SearchBar(
                    controller: _searchController,
                    padding: const WidgetStatePropertyAll<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 16.0),
                    ),
                    hintText: 'Pesquisar...',
                    onTap: () {
                      // Handle search bar tap
                      print('SearchBar clicada');
                    },
                  ),
                ),
                const TabBar(
                  tabs: [
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
