// lib/common_widgets/custom_appbar.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bd_doc/common_widgets/skip_button.dart';
import 'package:bd_doc/gen/assets.gen.dart';
import '/constants/text_font_style.dart';
import '/gen/colors.gen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final String? titleText;
  final bool showBackArrow;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;
  final bool isSuffix;
  final bool centerTitle;
  final Color? backgroundColor;
  final double? elevation;
  final Widget? leading;
  final EdgeInsets? padding;
  final double? height;
  final bool isSkipButton;
  final bool isCancelbutton;

  const CustomAppBar({
    super.key,
    this.title,
    this.titleText,
    this.showBackArrow = true,
    this.onBackPressed,
    this.actions,
    this.isSuffix = false,
    this.centerTitle = false,
    this.backgroundColor,
    this.elevation,
    this.leading,
    this.padding,
    this.height,
    this.isSkipButton = true,
    this.isCancelbutton = false,
  });

  @override
  Size get preferredSize =>
      Size.fromHeight(height ?? 56.h + (padding?.horizontal ?? 20));

  @override
  Widget build(BuildContext context) {
    Widget appBarWidget = AppBar(
      backgroundColor: backgroundColor ?? AppColors.cF7F6F2,
      elevation: elevation ?? 0,
      centerTitle: centerTitle,
      automaticallyImplyLeading: false,
      leadingWidth: isSkipButton ? 60.w : 20.w,
      leading: showBackArrow
          ? isSkipButton
              ? SkipButton(
                  height: 40.h,
                  width: 60.w,
                  widget: Image.asset(
                    Assets.icons.leftIcon.path,
                    height: 24.h,
                    width: 24.w,
                  ),
                  onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    (leading ??
                        InkWell(
                          onTap: onBackPressed ??
                              () => Navigator.of(context).pop(),
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 10.h, top: 10.h),
                            child: Image.asset(
                              isCancelbutton
                                  ? Assets.icons.cencelIocn.path
                                  : Assets.icons.leftIcon.path,
                              height: 20.h,
                              width: 20.w,
                            ),
                          ),
                        )),
                  ],
                )
          : null,
      title: title ??
          (titleText != null
              ? isCancelbutton
                  ? Center(
                      child: Text(
                        titleText!,
                        style: TextFontStyle.textStyle16c0D0D0DRM500,
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          titleText!,
                          textAlign: TextAlign.left,
                          style: TextFontStyle.textStyle16c0D0D0DRS600,
                        ),
                      ],
                    )
              : null),
      actions: actions ??
          (isSuffix ? [SkipButton(onPressed: () => {}, title: "More")] : null),
    );

    if (padding != null) {
      return Padding(
        padding: padding!,
        child: appBarWidget,
      );
    }

    return appBarWidget;
  }
}
