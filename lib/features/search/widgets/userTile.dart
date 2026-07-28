import 'package:flutter/material.dart';
import 'package:papacapim/core/theme/appColors.dart';
import 'package:papacapim/core/widgets/avatarWidget.dart';

class UserTile extends StatelessWidget {
  final Map<String, dynamic> user;

  const UserTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AvatarWidget(
          initials: user['initials'] ?? 'U',
          color: user['color'] ?? AppColors.primary,
          size: 42,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user['name'] ?? user['username'],
                style: const TextStyle(
                  color: AppColors.text,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                user['username'],
                style: const TextStyle(color: AppColors.muted, fontSize: 12),
              ),
            ],
          ),
        ),
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: AppColors.primary),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            minimumSize: const Size(60, 30),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: const Text(
            '+ Seguir',
            style: TextStyle(color: AppColors.primary, fontSize: 12),
          ),
        ),
      ],
    );
  }
}
