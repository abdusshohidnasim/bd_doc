import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bd_doc/constants/text_font_style.dart';
import 'package:bd_doc/gen/colors.gen.dart';

class SkipButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String? title;
  final double? width;
  final double? height;
  final Widget? widget;

  const SkipButton({
    super.key,
    required this.onPressed,
    this.title,
    this.width,
    this.height,
    this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width ?? double.infinity,
        height: height ?? 52.h,
        decoration: BoxDecoration(
          color: AppColors.cF7F6F2,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: Colors.black.withValues(alpha: 0.04),
            width: 1.5.w,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              offset: const Offset(1, 2),
              blurRadius: 4,
            ),
            const BoxShadow(
              color: AppColors.cF7F6F2,
              offset: Offset(-1, -1),
              blurRadius: 2,
            ),
          ],
        ),
        child: Center(
          child: widget ??
              Text(title ?? "", style: TextFontStyle.textStyle16c0F3D3DRS600),
        ),
      ),
    );
  }
}
