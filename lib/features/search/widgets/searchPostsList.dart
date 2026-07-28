import 'package:flutter/material.dart';
import 'package:papacapim/core/theme/appColors.dart';
import 'package:papacapim/core/widgets/postCard.dart';

class SearchPostsList extends StatelessWidget {
  final List<Map<String, dynamic>> posts;
  final bool isPreview;
  final VoidCallback? onSeeMore;

  const SearchPostsList({
    super.key,
    required this.posts,
    this.isPreview = false,
    this.onSeeMore,
  });

  @override
  Widget build(BuildContext context) {
    final listItems = isPreview && posts.length > 2
        ? posts.sublist(0, 2)
        : posts;

    Widget list = ListView.builder(
      shrinkWrap: isPreview,
      physics: isPreview
          ? const NeverScrollableScrollPhysics()
          : const AlwaysScrollableScrollPhysics(),
      padding: isPreview
          ? EdgeInsets.zero
          : const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: listItems.length,
      itemBuilder: (context, index) {
        final post = listItems[index];
        return PostCard(
          userName: post['name'],
          userHandle: post['username'] ?? '',
          postDate: post['time'],
          description: post['content'],
          initials: post['initials'] ?? 'P',
          avatarColor: post['color'] ?? AppColors.primary,
          likesCount: post['likes'] ?? 0,
          commentsCount: post['comments'] ?? 0,
          showFollowButton: true,
        );
      },
    );

    if (!isPreview) return list;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Posts',
              style: TextStyle(
                color: AppColors.text,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (onSeeMore != null)
              TextButton(
                onPressed: onSeeMore,
                child: const Text(
                  'Ver mais',
                  style: TextStyle(color: AppColors.primary),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        list,
      ],
    );
  }
}
