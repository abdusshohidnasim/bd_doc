import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../gen/colors.gen.dart';

class CustomScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final Key? scaffoldKey;
  final Widget? drawer;
  final Color? backgroundColor;

  const CustomScaffold({
    super.key,
    this.appBar,
    this.body,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.scaffoldKey,
    this.drawer,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        key: scaffoldKey,
        drawer: drawer,
        backgroundColor: backgroundColor ?? AppColors.cF7F6F2,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: backgroundColor ?? AppColors.cF7F6F2,
          child: SafeArea(
            child: Column(
              mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
              crossAxisAlignment:
                  crossAxisAlignment ?? CrossAxisAlignment.start,
              children: [
                if (appBar != null) appBar!,
                Expanded(
                  child: body ?? const SizedBox(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
