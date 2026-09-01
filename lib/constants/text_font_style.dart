import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../gen/colors.gen.dart';

class TextFontStyle {
  //Initialising Constractor
  TextFontStyle._();

  //Splash & Onboarding Screens
  static final textStylec28cFFFFFFDMSans900 = TextStyle(
    fontFamily: "DMSans",
    fontFamilyFallback: const [
      'Open Sans',
      'Roboto',
      'Noto Sans',
    ],
    color: const Color(0xFFFFFFFF),
    fontSize: 28.sp,
    fontWeight: FontWeight.w900,
  );

  static final textStylec11c606060DMSans400 = TextStyle(
    fontFamily: "DMSans",
    fontFamilyFallback: const [
      'Poppins',
      'Inter',
      'Roboto',
      'Noto Sans',
    ],
    color: const Color(0xFF606060),
    fontSize: 11.sp,
    fontWeight: FontWeight.w400,
  );

  // Login Screen Text Styles
  static final textStyle26c202020DMSans600 = TextStyle(
    fontFamily: "DMSans",
    fontFamilyFallback: const ['Open Sans', 'Roboto', 'Noto Sans'],
    color: AppColors.c000000,
    fontSize: 26.sp,
    fontWeight: FontWeight.w600,
  );

  static final textStyle14c383838DMSans600 = TextStyle(
    fontFamily: "DMSans",
    fontFamilyFallback: const ['Open Sans', 'Roboto', 'Noto Sans'],
    color: AppColors.c000000,
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
  );

  // /****************** Profile Screen Text Styles ******************/

  // PP Hatton Madium
  static final textStyle24c0D0D0DPHM500 = TextStyle(
    fontFamily: "PHM",
    fontFamilyFallback: const ['RR', 'RM', 'RS'],
    color: AppColors.c0D0D0D,
    fontSize: 24.sp,
    fontWeight: FontWeight.w500,
  );
  static final textStyle24c000000alpha2PHM500 = TextStyle(
    fontFamily: "PHM",
    fontFamilyFallback: const ['RR', 'RM', 'RS'],
    color: AppColors.c000000.withValues(alpha: 0.2),
    fontSize: 24.sp,
    fontWeight: FontWeight.w500,
  );
  static final textStyle18c0D0D0DPHM500 = TextStyle(
    fontFamily: "PHM",
    fontFamilyFallback: const ['RR', 'RM', 'RS'],
    color: AppColors.c0D0D0D,
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
  );
  static final textStyle18c000000alpha2PHM500 = TextStyle(
    fontFamily: "PHM",
    fontFamilyFallback: const ['RR', 'RM', 'RS'],
    color: AppColors.c000000.withValues(alpha: 0.2),
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
  );

  static final textStyle16c0D0D0DPHM700 = TextStyle(
    fontFamily: "PHM",
    fontFamilyFallback: const ['RR', 'RM', 'RS'],
    color: AppColors.c0D0D0D,
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
  );

  static final textStyle12c0D0D0DPHM700 = TextStyle(
    fontFamily: "PHM",
    fontFamilyFallback: const ['RR', 'RM', 'RS'],
    color: AppColors.c0D0D0D,
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
  );

  static final textStyle40cFFFFFFPHM700 = TextStyle(
    fontFamily: "PHM",
    fontFamilyFallback: const ['RR', 'RM', 'RS'],
    color: AppColors.cFFFFFF,
    fontSize: 40.sp,
    fontWeight: FontWeight.w700,
  );

  static final textStyle20cFFFFFFPHM400 = TextStyle(
    fontFamily: "PHM",
    fontFamilyFallback: const ['RR', 'RM', 'RS'],
    color: AppColors.cFFFFFF,
    fontSize: 20.sp,
    fontWeight: FontWeight.w400,
  );

  static final textStyle24cFFFFFalpha2PHM500 = TextStyle(
    fontFamily: "PHM",
    fontFamilyFallback: const ['RR', 'RM', 'RS'],
    color: AppColors.cFFFFFF.withValues(alpha: 0.2),
    fontSize: 24.sp,
    fontWeight: FontWeight.w500,
  );

  static final textStyle24cF7F6F2PHM500 = TextStyle(
    fontFamily: "PHM",
    fontFamilyFallback: const ['RR', 'RM', 'RS'],
    color: AppColors.cF7F6F2,
    fontSize: 24.sp,
    fontWeight: FontWeight.w500,
  );
// Raleway Medium
  static final textStyle14c38388DMSans600 = TextStyle(
    fontFamily: "RM",
    fontFamilyFallback: const ['RR', 'RM', 'RS'],
    color: AppColors.c000000,
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
  );
  static final textStyle16c000000RM400 = TextStyle(
    fontFamily: "RM",
    fontFamilyFallback: const ['RR', 'RM', 'RS'],
    color: AppColors.c000000,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
  );

  static final textStyle16c000000RM500 = TextStyle(
    fontFamily: "RM",
    fontFamilyFallback: const ['RR', 'RM', 'RS'],
    color: AppColors.c000000.withValues(alpha: 0.2),
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
  );

  static final textStyle16c0D0D0DRM500 = TextStyle(
    fontFamily: "RM",
    fontFamilyFallback: const ['RR', 'RM', 'RS'],
    color: AppColors.c0D0D0D,
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
  );
  static final textStyle12c0F3D3DRM500 = TextStyle(
    fontFamily: "RM",
    fontFamilyFallback: const ['RR', 'RM', 'RS'],
    color: AppColors.c0F3D3D,
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
  );

  static final textStyle12c0D0D0DRM500 = TextStyle(
    fontFamily: "RM",
    fontFamilyFallback: const ['RR', 'RM', 'RS'],
    color: AppColors.c0D0D0D,
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
  );

  static final textStyle16c404040RM500 = TextStyle(
    fontFamily: "RM",
    fontFamilyFallback: const ['RR', 'RM', 'RS'],
    color: AppColors.c404040,
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
  );

  static final textStyle24cF7F6F2RM500 = TextStyle(
    fontFamily: "RM",
    fontFamilyFallback: const ['RR', 'RM', 'RS'],
    color: AppColors.cF7F6F2,
    fontSize: 24.sp,
    fontWeight: FontWeight.w500,
  );

  static final textStyle18cF7F6F2RM500 = TextStyle(
    fontFamily: "RM",
    fontFamilyFallback: const ['RR', 'RM', 'RS'],
    color: AppColors.cF7F6F2,
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
  );

  static final textStyle14c0A0A0ARM500 = TextStyle(
    fontFamily: "RM",
    fontFamilyFallback: const ['RR', 'RM', 'RS'],
    color: AppColors.c0A0A0A,
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
  );

  static final textStyle14c0D0D0DRM500 = TextStyle(
    fontFamily: "RM",
    fontFamilyFallback: const ['RR', 'RM', 'RS'],
    color: AppColors.c0D0D0D,
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
  );

  static final textStyle14c525252RM500 = TextStyle(
    fontFamily: "RM",
    fontFamilyFallback: const ['RR', 'RM', 'RS'],
    color: AppColors.c525252,
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
  );

// Raleway Regular
  static final textStyle16c000000alfa2RR400 = TextStyle(
    fontFamily: "RR",
    fontFamilyFallback: const ['RR', 'RM', 'RS'],
    color: AppColors.c000000.withValues(alpha: 0.2),
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
  );

  static final textStyle16c0D0D0DRR400 = TextStyle(
    fontFamily: "RR",
    fontFamilyFallback: const ['RR', 'RM', 'RS'],
    color: AppColors.c0D0D0D,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
  );

  static final textStyle16c0D0D0DRR600 = TextStyle(
    fontFamily: "RR",
    fontFamilyFallback: const ['RR', 'RM', 'RS'],
    color: AppColors.c0D0D0D,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
  );

  static final textStyle16c0F3D3DRR600 = TextStyle(
    fontFamily: "RR",
    fontFamilyFallback: const ['RR', 'RM', 'RS'],
    color: AppColors.c0F3D3D,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
  );

  static final textStyle16cC5D400RR400 = TextStyle(
    fontFamily: "RR",
    fontFamilyFallback: const ['RR', 'RM', 'RS'],
    color: AppColors.cC5D400,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
  );

  static final textStyle20cFFFFFFRR400 = TextStyle(
    fontFamily: "RR",
    fontFamilyFallback: const ['RR', 'RM', 'RS'],
    color: AppColors.cFFFFFF,
    fontSize: 20.sp,
    fontWeight: FontWeight.w400,
  );

  static final textStyle14cc525252RR400 = TextStyle(
    fontFamily: "RR",
    fontFamilyFallback: const ['RR', 'RM', 'RS'],
    color: AppColors.c525252,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
  );

  static final textStyle12cc525252RR400 = TextStyle(
    fontFamily: "RR",
    fontFamilyFallback: const ['RR', 'RM', 'RS'],
    color: AppColors.c525252,
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
  );

  static final textStyle16cF7F6F2RR400 = TextStyle(
    fontFamily: "RR",
    fontFamilyFallback: const ['RR', 'RM', 'RS'],
    color: AppColors.cF7F6F2,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
  );

  static final textStyle14cF7F6F2RR400 = TextStyle(
    fontFamily: "RR",
    fontFamilyFallback: const ['RR', 'RM', 'RS'],
    color: AppColors.cF7F6F2,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
  );
  static final textStyle14c0D0D0DRR400 = TextStyle(
    fontFamily: "RR",
    fontFamilyFallback: const ['RR', 'RM', 'RS'],
    color: AppColors.c0D0D0D,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
  );

  static final textStyle14c0F3D3DRR400 = TextStyle(
    fontFamily: "RR",
    fontFamilyFallback: const ['RR', 'RM', 'RS'],
    color: AppColors.c0F3D3D,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
  );

// Raleway SemiBold
  static final textStyle16c0D0D0DRS600 = TextStyle(
    fontFamily: "RS",
    fontFamilyFallback: const ['RR', 'RM', 'RS'],
    color: AppColors.c0D0D0D,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
  );
  static final textStyle16c0F3D3DRS600 = TextStyle(
    fontFamily: "RS",
    fontFamilyFallback: const ['RR', 'RM', 'RS'],
    color: AppColors.c0F3D3D,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
  );
  static final textStyle12c0F3D3DRS500 = TextStyle(
    fontFamily: "RS",
    fontFamilyFallback: const ['RR', 'RM', 'RS'],
    color: AppColors.c0F3D3D,
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
  );

  static final textStyle14cF7F6F2RS400 = TextStyle(
    fontFamily: "RS",
    fontFamilyFallback: const ['RR', 'RM', 'RS'],
    color: AppColors.cF7F6F2,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
  );

  static final textStyle14cF7F6F2RS600 = TextStyle(
    fontFamily: "RS",
    fontFamilyFallback: const ['RR', 'RM', 'RS'],
    color: AppColors.cF7F6F2,
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
  );

  static final textStyle14cC5D400RS500 = TextStyle(
    fontFamily: "RS",
    fontFamilyFallback: const ['RR', 'RM', 'RS'],
    color: AppColors.cC5D400,
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
  );

  static final textStyle14cC5D400RS600 = TextStyle(
    fontFamily: "RS",
    fontFamilyFallback: const ['RR', 'RM', 'RS'],
    color: AppColors.cC5D400,
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
  );
  static final textStyle16cc0D0D0DRS600 = TextStyle(
    fontFamily: "RS",
    fontFamilyFallback: const ['RR', 'RM', 'RS'],
    color: AppColors.c0D0D0D,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
  );

  static final textStyle12cF7F6F2RS400 = TextStyle(
    fontFamily: "RS",
    fontFamilyFallback: const ['RR', 'RM', 'RS'],
    color: AppColors.cF7F6F2,
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
  );

  static final textStyle16ccF7F6F2RS600 = TextStyle(
    fontFamily: "RS",
    fontFamilyFallback: const ['RR', 'RM', 'RS'],
    color: AppColors.cF7F6F2,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
  );
  static final textStyle16ccF7F6F2RS400 = TextStyle(
    fontFamily: "RS",
    fontFamilyFallback: const ['RR', 'RM', 'RS'],
    color: AppColors.cF7F6F2,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
  );

  static final textStyle10cFFFFFFRS600 = TextStyle(
    fontFamily: "RS",
    fontFamilyFallback: const ['RR', 'RM', 'RS'],
    color: AppColors.cFFFFFF,
    fontSize: 10.sp,
    fontWeight: FontWeight.w600,
  );

  static final textStyle16c0A0A0ARS600 = TextStyle(
    fontFamily: "RS",
    fontFamilyFallback: const ['RR', 'RM', 'RS'],
    color: AppColors.c0A0A0A,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
  );
}
