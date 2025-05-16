import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CachedLoadingImage extends StatelessWidget {
  final String imageUrl;
  final Color? imageColor;
  final double height;
  final double width;
  final BoxFit fit;
  const CachedLoadingImage({
    super.key,
    required this.imageUrl,
    this.imageColor,
    this.fit = BoxFit.fill,
    this.height = double.infinity,
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    if ((imageUrl).isEmpty) {
      return Container();
    } else {
      return imageUrl.contains(".svg")
          ? SvgPicture.network(imageUrl, color: imageColor)
          : CachedNetworkImage(
            imageUrl: imageUrl,
            height: height,
            width: width,
            fit: fit,
            placeholder:
                (context, url) => Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) {
              print('Image Error ----> $error');
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(color: Colors.amber),
                child: Text(
                  'Unable to download image please try again',
                  style: TextStyle(fontSize: 16.0),
                ),
              );
            },
            // errorWidget: (context, url, error) => const Icon(Icons.error),
          );
    }
  }
}
