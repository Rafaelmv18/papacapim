import 'package:flutter/material.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}
class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController _captionController = TextEditingController();

  // Variáveis para controlar a imagem e o limite de texto
  bool _hasImage = false; 

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: const Text("Nova postagem"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // --- FOTO ---
              GestureDetector(
                onTap: () {
                  // Simula a escolha de uma foto 
                  setState(() {
                    _hasImage = !_hasImage;
                  });
                },
                child: Container(
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                    // Se _hasImage for true, mostra uma imagem da internet de exemplo
                    image: _hasImage
                        ? const DecorationImage(
                            image: NetworkImage(
                                'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=500'), 
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  // Se não tem imagem, mostra o ícone e o texto
                  child: !_hasImage
                      ? const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_a_photo, size: 50, color: Colors.grey),
                            SizedBox(height: 8),
                            Text(
                              'Toque para adicionar foto',
                              style: TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                          ],
                        )
                      : null,
                ),
              ),
              
              const SizedBox(height: 24),

              // --- CAMPO DE LEGENDA ---
              TextField(
                controller: _captionController,
                maxLength: 280, // Máximo de caracteres
                maxLines: 4, // Permite que o campo seja altinho como uma caixa
                decoration: const InputDecoration(
                  hintText: 'Escreva uma legenda...',
                  border: InputBorder.none,
                ),
                // Contagem de caracteres restantes
                buildCounter: (context, {required currentLength, required isFocused, maxLength}) {
                  int remaining = maxLength! - currentLength;
                  return Text(
                    '$remaining caracteres restantes',
                    style: TextStyle(
                      color: remaining <= 20 ? Colors.red : Colors.grey,
                    ),
                  );
                },
              ),
              
              const SizedBox(height: 32), // Espaço entre o texto e o botão
              const SizedBox(height: 32), // Espaço entre o texto e o botão
              
              // --- BOTÃO DE PUBLICAR ---
              ElevatedButton(
                onPressed: () {
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  'Publicar',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
