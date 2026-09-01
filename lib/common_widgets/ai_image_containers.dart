import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../gen/colors.gen.dart';

class AiImageContainers extends StatelessWidget {
  final Widget child;
  final String imagurl;
  const AiImageContainers(
      {super.key, required this.child, required this.imagurl});

  @override
  Widget build(BuildContext context) {
    final bool isNetwork =
        imagurl.startsWith('http://') || imagurl.startsWith('https://');

    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: SizedBox(
        height: 560.h,
        width: double.infinity,
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                color: AppColors.c1D7D71,
              ),
            ),
            Positioned.fill(
              child: SizedBox(
                child: isNetwork
                    ? CachedNetworkImage(
                        imageUrl: imagurl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: AppColors.c1D7D71,
                          highlightColor: Colors.teal[300]!,
                          child: Container(
                            color: AppColors.c1D7D71,
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: AppColors.c1D7D71,
                          child: const Center(
                            child: Icon(Icons.image_not_supported,
                                color: Colors.white),
                          ),
                        ),
                      )
                    : Image.asset(
                        imagurl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: AppColors.c1D7D71,
                        ),
                      ),
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.0),
                      AppColors.c1D7D71.withValues(alpha: 0.5),
                      AppColors.c1D7D71.withValues(alpha: 1.0),
                    ],
                    stops: const [
                      0.0,
                      0.5,
                      1.0,
                    ],
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
