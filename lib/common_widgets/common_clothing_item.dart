import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bd_doc/constants/app_constants.dart';
import 'package:bd_doc/gen/assets.gen.dart';

import 'custom_network_image.dart';
import '../constants/text_font_style.dart';
import '../gen/colors.gen.dart';
import '../helpers/ui_helpers.dart';

class ClothingItem extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final String? urls;
  final String? price;
  final bool isFavorite;
  final VoidCallback? onFavoriteTap;
  final VoidCallback? onShopNowTap;
  final double? imageheight;
  final double? imagewidth;
  final bool isFavoriteshow;

  const ClothingItem({
    super.key,
    this.title,
    this.subtitle,
    this.urls,
    this.price,
    this.isFavorite = false,
    this.onFavoriteTap,
    this.onShopNowTap,
    this.imageheight,
    this.imagewidth,
    required this.isFavoriteshow,
  });

  static String _formatPrice(String? rawPrice) {
    if (rawPrice == null) return "\$299";
    final double? value = double.tryParse(rawPrice);
    if (value == null) return rawPrice;

    if (value == value.truncateToDouble()) {
      return "\$${value.toInt()}";
    } else {
      return "\$${value.toStringAsFixed(2)}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: AppColors.cE6E4DE,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CustomNetworkImage(
                urls: urls ?? fallBackImage,
                borderRadiuswidget: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  topRight: Radius.circular(16.r),
                ),
                height: imageheight ?? 220.h,
                width: imagewidth ?? double.infinity,
              ),
              if (isFavoriteshow) ...[
                Positioned(
                  top: 12.h,
                  right: 12.w,
                  child: GestureDetector(
                    onTap: onFavoriteTap,
                    child: Container(
                      height: 32.h,
                      width: 32.w,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Image.asset(
                          isFavorite
                              ? Assets.icons.loveFullColors.path
                              : Assets.icons.love.path,
                          height: 16.h,
                          width: 16.w,
                          color: isFavorite
                              ? AppColors.c0F3D3D
                              : AppColors.c0D0D0D,
                        ),
                      ),
                    ),
                  ),
                ),
              ]
            ],
          ),
          UIHelper.verticalSpace(12.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title ?? "leather loafers",
                  style: TextFontStyle.textStyle14c0A0A0ARM500,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                UIHelper.verticalSpace(2.h),
                // Text(
                //   subtitle ?? "shoes",
                //   style: TextFontStyle.textStyle12cc525252RR400,
                //   maxLines: 1,
                //   overflow: TextOverflow.ellipsis,
                // ),
                if (price != null) ...[
                  UIHelper.verticalSpace(12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formatPrice(price),
                        //style: TextFontStyle.textStyle14c0d,
                        style: TextFontStyle.textStyle12c0D0D0DPHM700,

                        overflow: TextOverflow.ellipsis,
                      ),
                      FittedBox(
                        child: GestureDetector(
                          onTap: onShopNowTap,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 8.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.cFFFFFF,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text(
                              "shop now",
                              style: TextFontStyle.textStyle12c0F3D3DRM500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
                UIHelper.verticalSpace(12.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
