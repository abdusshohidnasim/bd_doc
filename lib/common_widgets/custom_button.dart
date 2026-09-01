// lib/widgets/buttons/custom_button.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/constants/text_font_style.dart';
import '/gen/colors.gen.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.isLoading = false,
    this.backgroundColor,
    this.foregroundColor,
    this.borderRadius,
    this.height,
    this.width,
    this.textStyle,
    this.padding,
    this.borderColor,
    this.prefixIcon,
    this.suffixIcon,
    this.gap,
  });

  final VoidCallback? onPressed;
  final String title;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final BorderRadiusGeometry? borderRadius;
  final double? height;
  final double? width;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final Color? borderColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? gap;

  @override
  Widget build(BuildContext context) {
    final defaultBgColor = backgroundColor ?? AppColors.cC7D700;
    final defaultFgColor = foregroundColor ?? AppColors.cC7D700;

    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 52.h,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: defaultBgColor,
          foregroundColor: defaultFgColor,
          disabledBackgroundColor: defaultBgColor.withValues(alpha: 0.5),
          disabledForegroundColor: defaultFgColor.withValues(alpha: 0.5),
          elevation: 0,
          shadowColor: Colors.transparent,
          padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w),
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(12.r),
            side: borderColor != null
                ? BorderSide(color: borderColor!, width: 1.w)
                : BorderSide.none,
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: 20.w,
                height: 20.h,
                child: CircularProgressIndicator(
                  strokeWidth: 2.w,
                  valueColor: AlwaysStoppedAnimation<Color>(defaultFgColor),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (prefixIcon != null) ...[
                    prefixIcon!,
                    SizedBox(width: gap ?? 8.w),
                  ],
                  Text(
                    title,
                    style: textStyle ?? TextFontStyle.textStyle16c0D0D0DRR600,
                    textAlign: TextAlign.center,
                  ),
                  if (suffixIcon != null) ...[
                    SizedBox(width: gap ?? 8.w),
                    suffixIcon!,
                  ],
                ],
              ),
      ),
    );
  }
}
