import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  final BoxFit fit;

  const ImageWidget({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
  });
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      height: height,
      width: width,
      fit: fit,
      filterQuality: FilterQuality.medium,
      placeholder: (context, url) => Image.asset(
        'assets/news2.jpg', // Error image
        fit: fit,
        height: height,
        width: width,
      ),
      errorWidget: (context, url, error) => Image.asset(
        'assets/news2.jpg', // Error image
        fit: fit,
        height: height,
        width: width,
      ),
    );
  }
}
