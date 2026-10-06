import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'gen/assets.gen.dart';
import 'gen/colors.gen.dart';
import 'helpers/ui_helpers.dart';

final class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.c0F3D3D,
        body: SafeArea(
            child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(20.h),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  UIHelper.verticalSpace(100.h),
                  Image.asset(
                    Assets.images.logo.path,
                  ),
                  FutureBuilder(
                    future: Future.delayed(const Duration(seconds: 1)),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return AnimatedOpacity(
                          opacity: 1.0,
                          duration: const Duration(milliseconds: 500),
                          child: Image.asset(
                            Assets.icons.splaceAnimationIcon.path,
                            width: MediaQuery.of(context).size.width / 2,
                          ),
                        );
                      }

                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
          ),
        )));
  }
}
