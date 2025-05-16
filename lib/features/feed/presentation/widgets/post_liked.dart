import 'package:flutter/material.dart';
import 'package:instagram_clone/features/feed/presentation/widgets/overlapping_images.dart';
import 'package:instagram_clone/core/widgets/core_widgets.dart';

class PostsLiked extends StatelessWidget {
  const PostsLiked({
    super.key,
    required this.name,
    required this.userProfileImageUrl,
  });

  final String name;
  final String userProfileImageUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          OverlappingCircles(userProfileImageUrl:userProfileImageUrl,),
          TextCustom(
            text:'Liked by $name and others' ,
          ),
        ],
      ),
    );
  }
}
