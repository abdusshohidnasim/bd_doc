import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/text_font_style.dart';
import '../gen/colors.gen.dart';

final class CustomTextformField extends StatelessWidget {
  final String? hintText;
  final double? hintFontSize;
  final String? labelText;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final double? fildContainntVarticalPading;
  final double? fildContainntHorizontalPading;
  final int? maxline;
  final int? minline;
  final String? Function(String?)? validator;
  final bool? validation;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final EdgeInsets? prefixIconPadding;
  final BoxConstraints? prefixIconConstraints;
  final bool isObsecure;
  final bool isPass;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? labelStyle;
  final TextStyle? style;
  final bool? isEnabled;
  final double? cursorHeight;
  final Color? disableColor;
  final bool isRead;
  final double? borderRadius;
  final Color? enableBorderColor;
  final Color? focusBorderColor;
  final Color? fillColor;
  final TextStyle? hintsTextStyle;
  final AutovalidateMode? autovalidateMode;

  const CustomTextformField(
      {super.key,
      this.hintText,
      this.labelText,
      this.controller,
      this.inputType,
      this.fildContainntVarticalPading,
      this.fildContainntHorizontalPading,
      this.maxline,
      this.minline,
      this.validator,
      this.validation = false,
      this.suffixIcon,
      this.prefixIcon,
      this.prefixIconPadding,
      this.prefixIconConstraints,
      this.isObsecure = false,
      this.isPass = false,
      this.focusNode,
      this.textInputAction = TextInputAction.next,
      this.onFieldSubmitted,
      this.onChanged,
      this.inputFormatters,
      this.labelStyle,
      this.isEnabled,
      this.style,
      this.cursorHeight,
      this.disableColor,
      this.isRead = false,
      this.borderRadius,
      this.hintFontSize,
      this.enableBorderColor,
      this.focusBorderColor,
      this.fillColor,
      this.hintsTextStyle,
      this.autovalidateMode});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: isRead,
      cursorHeight: cursorHeight ?? 20.h,
      cursorColor: AppColors.c000000,
      focusNode: focusNode,
      obscureText: isPass ? isObsecure : false,
      textInputAction: textInputAction,
      autovalidateMode: validation!
          ? AutovalidateMode.always
          : AutovalidateMode.onUserInteraction,
      validator: validator,
      maxLines: maxline ?? 1,
      minLines: minline ?? 1,
      controller: controller,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      inputFormatters: inputFormatters,
      enabled: isEnabled,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: fildContainntVarticalPading ?? 19.h,
            horizontal: fildContainntHorizontalPading ?? 15.w),
        filled: true,
        fillColor: fillColor ?? AppColors.cE6E4DE,
        isDense: true,
        suffixIcon: suffixIcon,
        prefixIconConstraints: prefixIconConstraints,
        prefixIcon: prefixIcon != null
            ? Padding(
                padding: prefixIconPadding ?? EdgeInsets.all(12.sp),
                child: prefixIcon,
              )
            : null,
        hintText: hintText,
        hintStyle: hintsTextStyle ?? TextFontStyle.textStyle16c0D0D0DRR400,
        labelText: labelText,
        errorStyle: TextStyle(
            fontSize: 14.sp, fontWeight: FontWeight.w500, color: Colors.red),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
          borderSide: BorderSide(color: Colors.red, width: 2.w),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
          borderSide: BorderSide(
            color: focusBorderColor ?? AppColors.c0D0D0D,
            width: 1.w,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
          borderSide: BorderSide(
            color: disableColor ?? AppColors.c000000,
            width: 1.w,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
          borderSide: BorderSide(
            color:
                enableBorderColor ?? AppColors.cFFFFFF.withValues(alpha: 0.1),
            width: 1.w,
          ),
        ),
      ),
      style: style ?? TextFontStyle.textStyle14c0D0D0DRR400,
      keyboardType: inputType,
    );
  }
}
