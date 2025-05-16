import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
class PostTime extends StatelessWidget {
  const PostTime({
    super.key,
    required this.createdAt,
  });

  final DateTime createdAt;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 2.0, 16.0, 8.0),
      child: Text(
        timeago.format(createdAt),
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: Colors.grey, fontSize: 12),
      ),
    );
  }
}
