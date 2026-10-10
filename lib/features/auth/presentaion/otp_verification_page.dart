import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bd_doc/common_widgets/custom_scaffold.dart';
import 'package:bd_doc/features/auth/presentaion/login_page.dart';
import 'package:bd_doc/features/auth/presentaion/reset_password_page.dart';
import 'package:bd_doc/features/auth/presentaion/widgets/auth_neumorphic_widgets.dart';

class OtpVerificationPage extends StatefulWidget {
  final String destination;
  final bool isFromForgotPassword;
  final bool isFromSignUp;

  /// Optional callbacks allowing parent page / router to hook into API calls directly
  final Future<bool> Function(String otp)? onVerifyOtp;
  final Future<void> Function()? onResendOtp;

  const OtpVerificationPage({
    super.key,
    required this.destination,
    this.isFromForgotPassword = false,
    this.isFromSignUp = false,
    this.onVerifyOtp,
    this.onResendOtp,
  });

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final TextEditingController _otpController = TextEditingController();
  bool _isLoading = false;
  bool _isResending = false;
  bool _hasError = false;

  int _resendCountdown = 45;
  Timer? _countdownTimer;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _otpController.dispose();
    super.dispose();
  }

  void _startCountdown() {
    _countdownTimer?.cancel();
    setState(() => _resendCountdown = 45);
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendCountdown > 0) {
        if (mounted) setState(() => _resendCountdown--);
      } else {
        timer.cancel();
      }
    });
  }

  /// Handles OTP verification - API ready for both Forgot Password & Sign Up
  void _handleVerifyOtp() async {
    final String otp = _otpController.text.trim();

    if (otp.length != 6) {
      setState(() => _hasError = true);
      _showToast('Please enter the complete 6-digit code');
      return;
    }

    setState(() {
      _hasError = false;
      _isLoading = true;
    });

    try {
      // If a custom API callback was provided, invoke it
      if (widget.onVerifyOtp != null) {
        final bool success = await widget.onVerifyOtp!(otp);
        if (!success) {
          if (mounted) setState(() => _isLoading = false);
          return;
        }
      } else {
        // Default simulated network delay (replace with API call e.g. Dio / Cubit)
        await Future.delayed(const Duration(milliseconds: 900));
      }

      if (!mounted) return;
      setState(() => _isLoading = false);

      if (widget.isFromForgotPassword) {
        _showToast('OTP verified successfully!');
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, anim, secAnim) => ResetPasswordPage(
              email: widget.destination,
              otpCode: otp,
            ),
            transitionDuration: const Duration(milliseconds: 250),
            transitionsBuilder: (context, anim, secAnim, child) =>
                FadeTransition(opacity: anim, child: child),
          ),
        );
      } else {
        // Sign Up confirmation complete -> Navigate to Login
        _showToast('Email verified successfully! Please log in.');
        Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(
            pageBuilder: (context, anim, secAnim) => const LoginPage(),
            transitionDuration: const Duration(milliseconds: 250),
            transitionsBuilder: (context, anim, secAnim, child) =>
                FadeTransition(opacity: anim, child: child),
          ),
          (route) => false,
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _hasError = true;
        });
        _showToast('Verification failed: $e');
      }
    }
  }

  /// Handles resend OTP request
  void _handleResendOtp() async {
    if (_resendCountdown > 0 || _isResending) return;

    setState(() => _isResending = true);

    try {
      if (widget.onResendOtp != null) {
        await widget.onResendOtp!();
      } else {
        // Simulated resend API call
        await Future.delayed(const Duration(milliseconds: 600));
      }

      if (!mounted) return;
      setState(() => _isResending = false);
      _showToast('A new OTP has been sent to ${widget.destination}');
      _startCountdown();
    } catch (e) {
      if (mounted) {
        setState(() => _isResending = false);
        _showToast('Failed to resend OTP: $e');
      }
    }
  }

  void _showToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundColor: kNeumorphicBg,
      body: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutCubic,
        builder: (context, animValue, child) {
          return Opacity(
            opacity: animValue,
            child: Transform.translate(
              offset: Offset(0, 16 * (1 - animValue)),
              child: child,
            ),
          );
        },
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 24.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Main Neumorphic Card matching screenshot
                Container(
                  padding: EdgeInsets.fromLTRB(22.w, 24.h, 22.w, 24.h),
                  decoration: BoxDecoration(
                    color: kNeumorphicBg,
                    borderRadius: BorderRadius.circular(32.r),
                    boxShadow: [
                      const BoxShadow(
                        color: kNeumorphicLightShadow,
                        offset: Offset(-8, -8),
                        blurRadius: 18,
                        spreadRadius: 1,
                      ),
                      BoxShadow(
                        color: kNeumorphicDarkShadow.withValues(alpha: 0.4),
                        offset: const Offset(8, 8),
                        blurRadius: 18,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Top Lock & Key Neumorphic Badge
                      const NeumorphicIconBadge(
                        child: Icon(
                          Icons.lock_rounded,
                          size: 32,
                          color: Color(0xFFD4A017), // Golden lock color from mockup
                        ),
                      ),
                      SizedBox(height: 20.h),

                      // Title: "Verify Your OTP"
                      Text(
                        'Verify Your OTP',
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w700,
                          color: kNeumorphicTextColor,
                          letterSpacing: -0.3,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8.h),

                      // Subtitle
                      Text(
                        "We've sent a 6-digit verification code to",
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          color: kNeumorphicSubTextColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 4.h),

                      // Destination (Email or Phone number)
                      Text(
                        widget.destination,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: kNeumorphicTextColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 24.h),

                      // 6 Neumorphic Inset OTP Boxes (matches mockup)
                      NeumorphicOtpField(
                        controller: _otpController,
                        length: 6,
                        isError: _hasError,
                        onChanged: (val) {
                          if (_hasError) setState(() => _hasError = false);
                        },
                        onCompleted: (val) {
                          _handleVerifyOtp();
                        },
                      ),
                      SizedBox(height: 28.h),

                      // "VERIFY OTP" Button
                      NeumorphicButton(
                        text: 'VERIFY OTP',
                        isLoading: _isLoading,
                        onTap: _handleVerifyOtp,
                      ),
                      SizedBox(height: 20.h),

                      // "RESEND OTP" Link with Countdown
                      GestureDetector(
                        onTap: _resendCountdown == 0 ? _handleResendOtp : null,
                        behavior: HitTestBehavior.opaque,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.h),
                          child: Text(
                            _resendCountdown > 0
                                ? 'RESEND OTP in ${_resendCountdown}s'
                                : 'RESEND OTP',
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w700,
                              color: _resendCountdown > 0
                                  ? kNeumorphicSubTextColor
                                  : kNeumorphicPrimary,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),

                      // Back / Cancel Option
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        behavior: HitTestBehavior.opaque,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 6.h),
                          child: Text(
                            'Cancel & Go Back',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: kNeumorphicSubTextColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
