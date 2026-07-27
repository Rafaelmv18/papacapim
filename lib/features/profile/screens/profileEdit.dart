import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:papacapim/core/theme/appColors.dart';
import '../../../core/widgets/avatarWidget.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final TextEditingController _nameController = TextEditingController(text: 'Mariana Oliveira');
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // 📷 Guarda a imagem capturada ou selecionada
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _nameController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // 📸 Função para capturar imagem da Câmera ou Galeria
  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(
      source: source,
      preferredCameraDevice: CameraDevice.front, // Abre por padrão na câmera frontal
      maxWidth: 600,
      maxHeight: 600,
      imageQuality: 85,
    );

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  // 📋 Modal Bottom Sheet com as opções de Alterar Foto (Câmera / Galeria)
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
                Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.muted,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 16),
                ListTile(
                  leading: const Icon(Icons.camera_alt, color: AppColors.primary),
                  title: const Text(
                    'Tirar foto com a Câmera',
                    style: TextStyle(color: AppColors.text, fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.camera); // 👈 Abre a Câmera
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library, color: AppColors.primary),
                  title: const Text(
                    'Escolher da Galeria',
                    style: TextStyle(color: AppColors.text, fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.gallery); // 👈 Abre a Galeria
                  },
                ),
                if (_selectedImage != null)
                  ListTile(
                    leading: const Icon(Icons.delete, color: Colors.redAccent),
                    title: const Text(
                      'Remover foto',
                      style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      setState(() {
                        _selectedImage = null; // Reseta para o Avatar com iniciais
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

  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    bool isPassword = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.primary,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: isPassword,
          style: const TextStyle(color: AppColors.text),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: AppColors.muted),
            filled: true,
            fillColor: AppColors.card,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Editar Perfil',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.text),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.white12,
            height: 1.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            
            // 🖼️ Foto de Perfil (Mostra a foto da câmera se houver, senão mostra o AvatarWidget)
            GestureDetector(
              onTap: _showPhotoOptions,
              child: Stack(
                children: [
                  _selectedImage != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.file(
                            _selectedImage!,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const AvatarWidget(
                          initials: 'MO',
                          color: Color(0xFF2E7D32),
                          size: 100,
                        ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Botão "Alterar foto"
            OutlinedButton.icon(
              onPressed: _showPhotoOptions, // 👈 Chama o BottomSheet
              icon: const Icon(Icons.camera_alt, size: 16, color: AppColors.primary),
              label: const Text('Alterar foto', style: TextStyle(color: AppColors.primary)),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.primary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              ),
            ),
            const SizedBox(height: 40),

            // Campos de Texto
            _buildTextField(
              label: 'NOME',
              hint: 'Mariana Oliveira',
              controller: _nameController,
            ),
            _buildTextField(
              label: 'NOVA SENHA',
              hint: 'Nova senha',
              controller: _newPasswordController,
              isPassword: true,
            ),
            _buildTextField(
              label: 'CONFIRMAR SENHA',
              hint: 'Confirmar senha',
              controller: _confirmPasswordController,
              isPassword: true,
            ),
            
            const SizedBox(height: 8),

            // Botões de Ação
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Perfil atualizado com sucesso!'),
                      backgroundColor: AppColors.primary,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  'Salvar alterações',
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: Colors.redAccent),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  'Excluir conta',
                  style: TextStyle(color: Colors.redAccent, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}