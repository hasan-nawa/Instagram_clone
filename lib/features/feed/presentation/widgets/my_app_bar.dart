import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/core/widgets/core_widgets.dart';
import 'package:instagram_clone/features/activity/presentation/pages/activity_screen.dart';
import 'package:instagram_clone/utils/app_images.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({
    super.key, required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      // pinned: true,
      snap: true,
      floating: true,
      onStretchTrigger: () async {
        // Triggers when stretching
      },
      expandedHeight: 50.0,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.all(12),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextCustom(
              text: title,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
            Row(
              children: [
              _buildIcon(icon: AppImages.like,onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (c)=> ActivityScreen()));
              }),
              _buildIcon(icon: AppImages.messenger,width: 20,height: 20,top:2 , right:2,count:3),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon({double? width ,double? height ,double? top ,double? right ,required String icon,int? count, onPressed}) {
    return Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: onPressed ?? (){},
                icon: SvgPicture.asset(icon,color: Colors.white,),
              ),
                Positioned(
                  top:top?? 12,
                  right:right ?? 12,
                  child: Container(
                    width: width ?? 8,
                    height: height?? 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: Center(child: TextCustom(text: "${count ?? ''}")),
                  ),
                ),
            ],
          );
  }
}
