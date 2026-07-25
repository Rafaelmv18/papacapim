import 'package:flutter/material.dart';
import 'package:papacapim/core/theme/appColors.dart';
import '../../../core/widgets/avatarWidget.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController _textController = TextEditingController();
  bool hasPhoto = false;
  final int maxChars = 280;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final remaining = maxChars - _textController.text.length;
    final canPublish = _textController.text.trim().isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Nova Postagem',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: ElevatedButton(
              onPressed: canPublish
                  ? () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Post publicado!')),
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: canPublish
                    ? AppColors.primary
                    : Colors.transparent,
                minimumSize: const Size(80, 36),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text('Publicar'),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Área de seleção de foto (Bloco superior)
          GestureDetector(
            onTap: () => setState(() => hasPhoto = !hasPhoto),
            child: Container(
              height: 180,
              width: double.infinity,
              color: hasPhoto ? AppColors.primaryDark : AppColors.card,
              child: Center(
                child: hasPhoto
                    ? const Text(
                        'Foto Selecionada (Toque para remover)',
                        style: TextStyle(color: AppColors.text),
                      )
                    : const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.photo_outlined,
                            size: 32,
                            color: AppColors.muted,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Toque para adicionar foto',
                            style: TextStyle(color: AppColors.muted),
                          ),
                        ],
                      ),
              ),
            ),
          ),

          // Campo de Texto da Postagem
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AvatarWidget(
                    initials: 'MO',
                    color: Color(0xFF2E7D32),
                    size: 38,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      maxLines: null,
                      maxLength: maxChars,
                      onChanged: (_) => setState(() {}),
                      style: const TextStyle(
                        color: AppColors.text,
                        fontSize: 15,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'O que está acontecendo?',
                        hintStyle: TextStyle(color: AppColors.muted),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        fillColor: Colors.transparent,
                        counterText:
                            '', // Oculta o contador padrão do TextField
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Rodapé com contador de caracteres
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: AppColors.border)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: () => setState(() => hasPhoto = !hasPhoto),
                  icon: const Icon(
                    Icons.photo,
                    color: AppColors.primary,
                    size: 20,
                  ),
                  label: const Text(
                    'Foto',
                    style: TextStyle(color: AppColors.primary),
                  ),
                ),
                Text(
                  '$remaining',
                  style: TextStyle(
                    color: remaining < 20 ? AppColors.danger : AppColors.muted,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
