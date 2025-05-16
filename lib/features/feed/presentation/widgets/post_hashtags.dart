import 'package:flutter/material.dart';

class PostHashtags extends StatelessWidget {
  const PostHashtags({
    super.key,
    required this.hashtags,
  });

  final List<String> hashtags;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Wrap(
        spacing: 4,
        children:
        hashtags
            .map(
              (tag) => Text(
            '#$tag',
            style: const TextStyle(color: Colors.blue),
          ),
        )
            .toList(),
      ),
    );
  }
}
