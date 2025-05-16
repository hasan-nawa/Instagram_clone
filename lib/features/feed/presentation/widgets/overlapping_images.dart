import 'package:flutter/material.dart';

class OverlappingCircles extends StatelessWidget {
  const OverlappingCircles({super.key, required this.userProfileImageUrl});

  final String userProfileImageUrl;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Transform.translate(
          offset: const Offset(0, 0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(userProfileImageUrl),
            radius: 10,
          ),
        ),
        Transform.translate(
          offset: const Offset(-7, 0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(userProfileImageUrl),
            radius: 10,
          ),
        ),
      ],
    );
  }
}
