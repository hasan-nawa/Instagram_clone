import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/app_extension.dart';
import 'package:instagram_clone/core/widgets/core_widgets.dart';

class PostHeader extends StatelessWidget {
  const PostHeader({
    super.key,
    required this.userProfileImageUrl,
    required this.username,
  });

  final String userProfileImageUrl;
  final String username;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(userProfileImageUrl),
            radius: 16,
          ).paddingEnd(8),
          TextCustom(text: username, fontWeight: FontWeight.bold),
          const Spacer(),
          IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
    );
  }
}
