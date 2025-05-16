import 'package:flutter/material.dart';
import 'package:instagram_clone/config/theme.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Shimmer.fromColors(
        baseColor: AppTheme.shimmerColor,
        highlightColor: Colors.white10,
        enabled: true,
        child:  SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                children: [
                  BannerPlaceholder(),
                  Expanded(child: TitlePlaceholder(width: double.infinity)),
                ],
              ),
              SizedBox(height: 12.0),
              ContentPlaceholder(
                lineType: ContentLineType.threeLines,
              ),
              SizedBox(height: 20.0),

              TitlePlaceholder(width: MediaQuery.of(context).size.width/1.5 ),
              SizedBox(height: 12.0),
              TitlePlaceholder(width: MediaQuery.of(context).size.width/1.5 ),
            ],
          ),
        ));
  }
}



class BannerPlaceholder extends StatelessWidget {
  const BannerPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.0,
      height: 40.0,
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppTheme.shimmerColor,
      ),
    );
  }
}


class TitlePlaceholder extends StatelessWidget {
  final double width;

  const TitlePlaceholder({
    super.key,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        width: width,
        decoration: BoxDecoration(
            color: AppTheme.shimmerColor,
            borderRadius: BorderRadius.circular(12)),
        height: 12.0,

      ),
    );
  }
}


class ContentPlaceholder extends StatelessWidget {
  final ContentLineType lineType;

  const ContentPlaceholder({
    super.key,
    required this.lineType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 375.0,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
      ),

    );
  }
}

enum ContentLineType {
  twoLines,
  threeLines,
}