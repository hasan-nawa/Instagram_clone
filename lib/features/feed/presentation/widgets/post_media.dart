import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/config/theme.dart';
import 'package:instagram_clone/core/widgets/core_widgets.dart';
import 'package:instagram_clone/features/feed/domain/entities/post_entity.dart';
import 'package:instagram_clone/features/feed/presentation/bloc/feed_bloc.dart';
import 'package:instagram_clone/features/feed/presentation/bloc/feed_event.dart';
import 'package:instagram_clone/utils/app_images.dart';

class PostMedia extends StatefulWidget {
  const PostMedia({super.key, required this.post});

  final PostEntity post;

  @override
  State<PostMedia> createState() => _PostMediaState();
}

class _PostMediaState extends State<PostMedia>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  int _current = 0;
  bool showLike = false;
  final CarouselSliderController _controller = CarouselSliderController();

  animateLike()async{
    setState(()  {
      showLike = true;
    });
    await Future.delayed(Duration(milliseconds: 1000));
    setState(()  {
      showLike = false;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          carouselController: _controller,
          itemCount: widget.post.imageUrl.length,
          itemBuilder:
              (BuildContext context, int itemIndex, int pageViewIndex) =>
                  GestureDetector(
                    onDoubleTap: () async{
                      animateLike();
                      if(!widget.post.isLiked){
                        context.read<FeedBloc>().add(
                          ToggleLikeEvent(
                            postId: widget.post.id,
                            isLiked: widget.post.isLiked,
                          ),
                        );
                      }
                    },
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        CachedLoadingImage(
                          width: MediaQuery.of(context).size.width,
                          imageUrl: widget.post.imageUrl.elementAt(itemIndex),
                        ),
                        Visibility(
                          visible: showLike,

                          child:
                          SvgPicture.asset(
                            AppImages.likeFill,
                            width: 100,
                          ).animate(effects:[ScaleEffect(
                            curve: Curves.elasticOut,
                            duration: Duration(milliseconds: 800),
                          ),] ),
                        ),
                      ],
                    ),
                  ),
          options: CarouselOptions(
            height: 375,
            aspectRatio: 16 / 9,
            viewportFraction: 1,
            initialPage: 0,
            enableInfiniteScroll: false,
            reverse: false,
            autoPlay: false,
            enlargeCenterPage: false,
            enlargeFactor: 0.3,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
            scrollDirection: Axis.horizontal,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
              widget.post.imageUrl.asMap().entries.map((entry) {
                bool isCurrent = _current == entry.key;
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: isCurrent ? 8 : 6.0,
                    height: isCurrent ? 8 : 6.0,
                    margin: EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 2.0,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          (_current == entry.key
                              ? AppTheme.indicatorColor
                              : Colors.grey),
                    ),
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }
}
