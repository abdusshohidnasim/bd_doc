// logout_dialog.dart

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/text_font_style.dart';
import '../gen/colors.gen.dart';
import '../helpers/ui_helpers.dart';

void showLogoutDialog(BuildContext context,
    {required String? titel,
    String? subtitel,
    required Widget fristbutton,
    required Widget secendbutton,
    required String icon}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withValues(alpha: 0.4),
    isScrollControlled: true,
    builder: (_) => _LogoutBottomSheet(
      titel: titel,
      subtitel: subtitel,
      fristbutton: fristbutton,
      secendbutton: secendbutton,
      icon: icon,
    ),
  );
}

class _LogoutBottomSheet extends StatelessWidget {
  final String? titel;
  final String? subtitel;
  final Widget fristbutton;
  final Widget secendbutton;
  final String icon;

  const _LogoutBottomSheet(
      {this.titel,
      this.subtitel,
      required this.fristbutton,
      required this.secendbutton,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(
          left: 24.w,
          right: 24.w,
          top: 28.h,
          bottom: 32.h,
        ),
        decoration: BoxDecoration(
          color: AppColors.cF7F6F2,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(28.r),
            topRight: Radius.circular(28.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Logout icon circle
            Container(
                decoration: const BoxDecoration(
                  color: AppColors.cFFE7D9,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: EdgeInsets.all(13.w),
                  child: Image.asset(
                    icon,
                    color: AppColors.cB72136,
                    height: 24.h,
                    width: 24.w,
                  ),
                )),

            UIHelper.verticalSpace(20.h),

            // Title
            Text(titel ?? "are you sure you want to\nlog out?",
                textAlign: TextAlign.center,
                maxLines: null,
                style: TextFontStyle.textStyle24c0D0D0DPHM500),

            UIHelper.verticalSpace(10.h),

            // Subtitle
            Text(
              subtitel ??
                  "you’ll need to log in again to access your style recommendations",
              maxLines: null,
              textAlign: TextAlign.center,
              style: TextFontStyle.textStyle16c0D0D0DRR400,
            ),

            UIHelper.verticalSpace(28.h),

            Row(
              children: [
                // Cancel
                Expanded(child: fristbutton),

                UIHelper.horizontalSpace(12.w),

                Expanded(child: secendbutton)
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void showCustomDialogBox(BuildContext context,
    {required String? titel,
    String? subtitel,
    required Widget fristbutton,
    required Widget secendbutton,
    required String icon}) {
  showDialog(
    context: context,
    barrierColor: Colors.black.withValues(alpha: 0.4),
    builder: (_) => Center(
      child: Material(
        color: Colors.transparent,
        child: _CustomDialogBox(
          titel: titel,
          subtitel: subtitel,
          fristbutton: fristbutton,
          secendbutton: secendbutton,
          icon: icon,
        ),
      ),
    ),
  );
}

class _CustomDialogBox extends StatelessWidget {
  final String? titel;
  final String? subtitel;
  final Widget fristbutton;
  final Widget secendbutton;
  final String icon;

  const _CustomDialogBox(
      {this.titel,
      this.subtitel,
      required this.fristbutton,
      required this.secendbutton,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 24.w),
        width: double.infinity,
        padding: EdgeInsets.only(
          left: 24.w,
          right: 24.w,
          top: 28.h,
          bottom: 32.h,
        ),
        decoration: BoxDecoration(
          color: AppColors.cF7F6F2,
          borderRadius: BorderRadius.circular(28.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: AppColors.cFFE7D9,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: EdgeInsets.all(13.w),
                child: Image.asset(
                  icon,
                  color: AppColors.cB72136,
                  height: 24.h,
                  width: 24.w,
                ),
              ),
            ),
            UIHelper.verticalSpace(20.h),
            if (titel != null) ...[
              Text(titel!,
                  textAlign: TextAlign.center,
                  maxLines: null,
                  style: TextFontStyle.textStyle24c0D0D0DPHM500),
              UIHelper.verticalSpace(10.h),
            ],
            if (subtitel != null) ...[
              Text(
                subtitel!,
                maxLines: null,
                textAlign: TextAlign.center,
                style: TextFontStyle.textStyle16c0D0D0DRR400,
              ),
              UIHelper.verticalSpace(28.h),
            ],
            Row(
              children: [
                Expanded(child: fristbutton),
                UIHelper.horizontalSpace(12.w),
                Expanded(child: secendbutton),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
