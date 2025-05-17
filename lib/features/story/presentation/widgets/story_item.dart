import 'package:flutter/material.dart';
import 'package:instagram_clone/core/widgets/cache_net_Image.dart';
import 'package:instagram_clone/features/story/data/models/story_model.dart';

class StoryItem extends StatelessWidget {
  final StoryModel story;
  final VoidCallback onTap;

  const StoryItem({
    Key? key,
    required this.story,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            // Story avatar with gradient border
            Container(
              width: 80,
              height: 80,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: story.isViewed
                    ? null
                    : const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFFFACC15),
                          Color(0xFFEF4444),
                          Color(0xFFEC4899),
                        ],
                      ),
                border: story.isViewed
                    ? Border.all(color: Colors.grey.shade300, width: 1.5)
                    : null,
              ),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: CachedLoadingImage(
                    imageUrl: story.userImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            // Username
            SizedBox(
              width: 80,
              child: Text(
                story.username,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
