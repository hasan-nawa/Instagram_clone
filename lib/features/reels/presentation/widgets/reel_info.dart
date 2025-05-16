import 'package:flutter/material.dart';

class ReelInfo extends StatelessWidget {
  final String username;
  final String userProfileImageUrl;
  final String caption;
  final String audioName;
  final String audioOwner;
  final bool isFollowing;
  final Function(String, bool) onFollow;

  const ReelInfo({
    Key? key,
    required this.username,
    required this.userProfileImageUrl,
    required this.caption,
    required this.audioName,
    required this.audioOwner,
    required this.isFollowing,
    required this.onFollow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // User info row
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage(userProfileImageUrl),
              ),
              const SizedBox(width: 8),
              Text(
                username,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              if (!isFollowing)
                OutlinedButton(
                  onPressed: () => onFollow(username, isFollowing),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                    minimumSize: const Size(10, 24),
                  ),
                  child: const Text(
                    'Follow',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 16),

          // Caption
          Text(
            caption,
            style: const TextStyle(color: Colors.white),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 16),

          // Audio info
          Row(
            children: [
              const Icon(
                Icons.music_note,
                color: Colors.white,
                size: 16,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '$audioName · $audioOwner',
                  style: const TextStyle(color: Colors.white),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}