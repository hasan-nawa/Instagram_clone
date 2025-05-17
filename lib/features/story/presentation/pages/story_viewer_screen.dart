import 'package:flutter/material.dart';
import 'package:instagram_clone/core/widgets/cache_net_Image.dart';
import 'package:instagram_clone/features/story/data/models/story_model.dart';
import 'package:instagram_clone/features/story/presentation/widgets/story_view.dart';

class StoryViewerScreen extends StatefulWidget {
  final StoryModel story;
  final int initialIndex;
 final  List<StoryModel> stories;

  const StoryViewerScreen({
    super.key,
    required this.story,
    required this.initialIndex, required this.stories,
  });

  @override
  State<StoryViewerScreen> createState() => _StoryViewerScreenState();
}

class _StoryViewerScreenState extends State<StoryViewerScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addStatusListener(_handleAnimationStatus);

    // _animationController.forward();
  }

  void _handleAnimationStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      if (_currentIndex < widget.stories.length - 1) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
    _animationController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTapDown: (_) => _animationController.stop(),
        onTapUp: (_) => _animationController.forward(),
        onTapCancel: () => _animationController.forward(),
        child: CubePageView(
          controller: _pageController,
          itemCount: widget.stories.length,
          onPageChanged: _onPageChanged,
          itemBuilder: (context, index, pageNotifier) {
            final story = widget.stories[index];
            return CubeWidget(
              index: index,
              pageNotifier: pageNotifier,
              child: _buildStoryContent(story),
            );
          }, children: null,
        ),
      ),
    );
  }

  Widget _buildStoryContent(StoryModel story) {
    return Stack(
      children: [
        // Progress Indicator
        Positioned(
          top: MediaQuery.of(context).padding.top + 10,
          left: 10,
          right: 10,
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return LinearProgressIndicator(
                value: _animationController.value,
                backgroundColor: Colors.grey.withOpacity(0.5),
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              );
            },
          ),
        ),

        // User Info
        Positioned(
          top: MediaQuery.of(context).padding.top + 30,
          left: 10,
          right: 10,
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(story.userImage),
                radius: 20,
              ),
              const SizedBox(width: 10),
              Text(
                story.username,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                _getTimeAgo(story.createdAt),
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 12,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.more_vert, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
        ),

        // Story Image
        Center(
          child: CachedLoadingImage(
            imageUrl: story.storyImage,
            fit: BoxFit.contain,
          ),
        ),

        // Message Input
        Positioned(
          bottom: MediaQuery.of(context).padding.bottom + 10,
          left: 10,
          right: 10,
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Send message',
                    hintStyle: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.2),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(width: 10),
              _circleButton(Icons.favorite_border),
              const SizedBox(width: 10),
              _circleButton(Icons.send),
            ],
          ),
        ),
      ],
    );
  }

  Widget _circleButton(IconData icon) {
    return CircleAvatar(
      backgroundColor: Colors.white.withOpacity(0.2),
      child: Icon(icon, color: Colors.white),
    );
  }

  String _getTimeAgo(DateTime dateTime) {
    final diff = DateTime.now().difference(dateTime);
    if (diff.inDays > 0) return '${diff.inDays}d';
    if (diff.inHours > 0) return '${diff.inHours}h';
    if (diff.inMinutes > 0) return '${diff.inMinutes}m';
    return 'Just now';
  }
}
