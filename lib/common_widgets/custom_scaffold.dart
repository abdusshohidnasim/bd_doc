import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bd_doc/gen/colors.gen.dart';

class CustomScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final Key? scaffoldKey;
  final Widget? drawer;

  const CustomScaffold({
    super.key,
    this.appBar,
    this.body,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.scaffoldKey,
    this.drawer,
  });

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        key: scaffoldKey,
        drawer: drawer,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: AppColors.cF7F6F2,
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
