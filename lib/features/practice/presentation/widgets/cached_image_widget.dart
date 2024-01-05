import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:meditation/features/practice/presentation/widgets/app_loading.dart';
import 'package:meditation/theme/app_colors.dart';

class CachedImageWidget extends StatelessWidget {
  const CachedImageWidget({
    super.key,
    required this.image,
    this.radius = 8,
  });

  final String image;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      fit: BoxFit.cover,
      memCacheHeight: 400,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(radius),
          ),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => const AppLoadingWidget(),
      errorWidget: (context, url, error) => const ColoredBox(
        color: AppColors.color50717C,
        child: Icon(
          Icons.image_not_supported_outlined,
          color: AppColors.white,
        ),
      ),
    );
  }
}
