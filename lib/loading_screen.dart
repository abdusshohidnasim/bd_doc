import 'dart:async';
import 'package:bd_doc/features/auth/presentaion/login_page.dart';
import 'package:flutter/material.dart';
import 'constants/app_constants.dart';
import 'helpers/di.dart';
import 'helpers/helper_methods.dart';
import 'networks/dio/dio.dart';
import 'splash_screen.dart';
import 'bottom_nav_bar.dart';

final class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  bool _isLoading = true;
  bool isFirstTime = true;
  Timer? _timer;

  @override
  void initState() {
    loadInitialData();

    super.initState();
    _timer = Timer(const Duration(seconds: 35), () {
      if (_isLoading) {
        // Only log out if internet is connected but loading is taking too long
        _handleLogout();
      }
    });
  }

  loadInitialData() async {
    //AutoAppUpdateUtil.instance.checkAppUpdate();
    await setInitValue();
    if (appData.read(kKeyIsLoggedIn)) {
      String token = appData.read(kKeyAccessToken);
      DioSingleton.instance.update(token);
    }
    setState(() {
      _timer!.cancel();
      _isLoading = false;
    });
  }

  void _handleLogout() {
    appData.write(kKeyIsLoggedIn, false);

    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (context) => LogInScreen()),
    // );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const SplashScreen();
    } else {
      final bool isLoggedIn = appData.read(kKeyIsLoggedIn) ?? false;
      final bool isOnboardingCompleted =
          appData.read(kKeyIsOnboardingCompleted) ?? true;

      if (isLoggedIn) {
        if (!isOnboardingCompleted) {
          return const LoginPage();
        }
        return const BottomNavBar();
      } else {
        return appData.read(kKeyfirstTime)
            ? const LoginPage()
            : const LoginPage();
      }
    }
  }
}
