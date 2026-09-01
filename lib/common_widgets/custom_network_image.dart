import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../gen/colors.gen.dart';

class CustomNetworkImage extends StatelessWidget {
  final String urls;
  final double? width;
  final double? height;
  final double? borderRadius;
  final bool isCircle;
  final Color? bordercolors;
  final double? circlewith;
  final BorderRadius? borderRadiuswidget;

  const CustomNetworkImage({
    super.key,
    required this.urls,
    this.width,
    this.height,
    this.borderRadius,
    this.isCircle = false,
    this.bordercolors,
    this.circlewith,
    this.borderRadiuswidget,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: urls,
      width: width ?? 50.r,
      height: height ?? 50.r,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: isCircle
              ? null
              : borderRadiuswidget ??
                  BorderRadius.circular(borderRadius ?? 0.0),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
            alignment: isCircle ? Alignment.topCenter : Alignment.center,
          ),
          border: isCircle
              ? Border.all(
                  color: bordercolors ?? AppColors.cC7D700,
                  width: circlewith ?? 2.0)
              : null,
        ),
      ),
      placeholder: (context, url) => ColorFiltered(
        colorFilter: ColorFilter.mode(
          AppColors.cFFFFFF.withValues(alpha: 0.1),
          BlendMode.srcIn,
        ),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            decoration: BoxDecoration(
              shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
              borderRadius:
                  isCircle ? null : BorderRadius.circular(borderRadius ?? 2.0),
              color: AppColors.cC7D700,
            ),
          ),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        decoration: BoxDecoration(
          shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
          borderRadius:
              isCircle ? null : BorderRadius.circular(borderRadius ?? 2.0),
          color: AppColors.cC7D700,
        ),
        child: Center(
          child: Icon(
            Icons.person,
            size: (width != null && height != null)
                ? (width! < height! ? width! : height!) * 0.6
                : 40.r,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
