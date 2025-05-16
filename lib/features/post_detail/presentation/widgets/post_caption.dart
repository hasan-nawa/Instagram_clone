import 'package:flutter/material.dart';

class PostCaption extends StatefulWidget {
  const PostCaption({
    super.key,
    required this.username,
    required this.caption,
  });

  final String username;
  final String caption;

  @override
  State<PostCaption> createState() => _PostCaptionState();
}

class _PostCaptionState extends State<PostCaption> {
  bool _isExpanded = false;
  final int _previewLength = 100;

  @override
  Widget build(BuildContext context) {
    final fullText = "${widget.username} ${widget.caption}";
    final showMore = fullText.length > _previewLength;

    String previewText = fullText;
    if (!_isExpanded && showMore) {
      previewText = fullText.substring(0, _previewLength).trimRight();
      // Remove last word to append "... more"
      int lastSpace = previewText.lastIndexOf(' ');
      if (lastSpace != -1) {
        previewText = previewText.substring(0, lastSpace);
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: _isExpanded || !showMore
                      ? fullText
                      : "$previewText... ",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                if (showMore)
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isExpanded = !_isExpanded;
                        });
                      },
                      child: Text(
                        _isExpanded ? ' Show less' : 'more',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.fontSize ??
                              14,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
