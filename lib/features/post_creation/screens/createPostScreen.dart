import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:papacapim/core/theme/appColors.dart';
import '../../../core/widgets/avatarWidget.dart';

// Widget com estado (StatefulWidget) para gerenciar a criação e publicação de posts
class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

// Classe de estado da tela de criação de postagem
class _CreatePostScreenState extends State<CreatePostScreen> {
  // Controller para o campo de entrada do texto do post
  final TextEditingController _textController = TextEditingController();

  // Armazena o arquivo de imagem selecionado ou tirado na câmera
  File? _selectedImage;
  // Instância do ImagePicker para acessar a galeria ou a câmera nativa
  final ImagePicker _picker = ImagePicker();
  // Limite máximo de caracteres permitidos na publicação
  final int maxChars = 280;

  @override
  void dispose() {
    // Libera os recursos alocados pelo controller quando a tela é descartada
    _textController.dispose();
    super.dispose();
  }

  // Função assíncrona para obter a imagem da Câmera ou da Galeria
  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(
      source: source,
      maxWidth: 1080,
      maxHeight: 1080,
      imageQuality: 85,
    );

    // Se uma imagem for capturada ou escolhida, atualiza a variável de estado
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  // Modal inferior (BottomSheet) com as opções de Câmera, Galeria ou Remoção
  void _showPhotoOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.card,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Indicador visual no topo do BottomSheet
                Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.muted,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 16),
                // Opção de tirar foto com a Câmera
                ListTile(
                  leading: const Icon(
                    Icons.camera_alt,
                    color: AppColors.primary,
                  ),
                  title: const Text(
                    'Tirar foto com a Câmera',
                    style: TextStyle(
                      color: AppColors.text,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.camera); // Abre a Câmera
                  },
                ),
                // Opção de escolher da Galeria
                ListTile(
                  leading: const Icon(
                    Icons.photo_library,
                    color: AppColors.primary,
                  ),
                  title: const Text(
                    'Escolher da Galeria',
                    style: TextStyle(
                      color: AppColors.text,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.gallery); // Abre a Galeria
                  },
                ),
                // Opção condicional para remover a foto selecionada
                if (_selectedImage != null)
                  ListTile(
                    leading: const Icon(Icons.delete, color: Colors.redAccent),
                    title: const Text(
                      'Remover foto',
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      setState(() {
                        _selectedImage = null; // Limpa a imagem anexada
                      });
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Cálculo dos caracteres restantes permitidos
    final remaining = maxChars - _textController.text.length;
    // Validação que permite a publicação se houver texto ou foto anexada
    final canPublish =
        _textController.text.trim().isNotEmpty || _selectedImage != null;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove o botão de voltar padrão
        title: const Text(
          'Nova Postagem',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        actions: [
          // Botão superior para Publicar
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: ElevatedButton(
              onPressed: canPublish
                  ? () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Post publicado com sucesso!'),
                          backgroundColor: AppColors.primary,
                        ),
                      );
                      Navigator.pop(context);
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
          // Área Superior: Exibição da foto selecionada ou placeholder
          GestureDetector(
            onTap: _showPhotoOptions,
            child: Container(
              height: 200,
              width: double.infinity,
              color: AppColors.card,
              child: _selectedImage != null
                  ? Stack(
                      children: [
                        // Preenche a área do container com a imagem escolhida
                        Positioned.fill(
                          child: Image.file(_selectedImage!, fit: BoxFit.cover),
                        ),
                        // Botão 'X' flutuante para remover a foto rapidamente
                        Positioned(
                          top: 10,
                          right: 10,
                          child: CircleAvatar(
                            backgroundColor: Colors.black54,
                            child: IconButton(
                              icon: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 20,
                              ),
                              onPressed: () {
                                setState(() {
                                  _selectedImage = null;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    )
                  : const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_a_photo_outlined,
                          size: 36,
                          color: AppColors.muted,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Toque para adicionar uma foto',
                          style: TextStyle(
                            color: AppColors.muted,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
            ),
          ),

          // Área Central: Campo de entrada de texto e Avatar do autor
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
                        counterText: '',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Rodapé: Botão para gerenciar fotos e contador de caracteres
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: AppColors.border)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Botões de mídia
                TextButton.icon(
                  onPressed:
                      _showPhotoOptions, //  Abre o menu de Câmera/Galeria
                  icon: const Icon(
                    Icons.photo_camera,
                    color: AppColors.primary,
                    size: 20,
                  ),
                  label: Text(
                    _selectedImage != null ? 'Trocar Foto' : 'Adicionar Foto',
                    style: const TextStyle(color: AppColors.primary),
                  ),
                ),
                // Contador visual dinâmico de caracteres
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
