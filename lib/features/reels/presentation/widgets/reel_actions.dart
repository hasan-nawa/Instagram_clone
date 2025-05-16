import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/utils/app_images.dart';

class ReelActions extends StatelessWidget {
  final String reelId;
  final String userId;
  final bool isLiked;
  final bool isBookmarked;
  final int likesCount;
  final int commentsCount;
  final int sharesCount;
  final Function(String, bool) onLike;
  final Function(String, bool) onBookmark;
  final Function(String) onShare;
  final VoidCallback onComment;

  const ReelActions({
    Key? key,
    required this.reelId,
    required this.userId,
    required this.isLiked,
    required this.isBookmarked,
    required this.likesCount,
    required this.commentsCount,
    required this.sharesCount,
    required this.onLike,
    required this.onBookmark,
    required this.onShare,
    required this.onComment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Like button
          _buildActionButton(
            icon: isLiked ?  AppImages.likeFill : AppImages.like,
            color: isLiked ? Colors.red:Colors.white,
            count: likesCount,
            onTap: () => onLike(reelId, isLiked),
          ),

          const SizedBox(height: 16),

          // Comment button
          _buildActionButton(
            icon: AppImages.comment,
            color: Colors.white,
            count: commentsCount,
            onTap: onComment,
          ),

          const SizedBox(height: 16),

          // Share button
          _buildActionButton(
            icon: AppImages.send,
            color: Colors.white,
            count: sharesCount,
            onTap: () => onShare(reelId),
          ),

          const SizedBox(height: 16),

          // Bookmark button
          IconButton(
            icon: Icon(
              isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () => onBookmark(reelId, isBookmarked),
          ),

          const SizedBox(height: 24),

          // Audio rotating disc
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
              image: const DecorationImage(
                image: NetworkImage('https://picsum.photos/id/1/40/40'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required String icon,
    required Color? color,
    required int count,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        InkWell(onTap: onTap, child: SvgPicture.asset(icon, color: color)),
        Text(
          _formatCount(count),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  String _formatCount(int count) {
    if (count < 1000) {
      return count.toString();
    } else if (count < 1000000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    } else {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    }
  }
}
