import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bd_doc/common_widgets/custom_scaffold.dart';
import 'package:bd_doc/common_widgets/neumorphic_auth_widgets.dart';
import 'package:bd_doc/features/auth/presentaion/otp_verification_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;
  bool _emailSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleResetPassword() async {
    final String email = _emailController.text.trim();
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your email address'),
          duration: Duration(seconds: 1),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    // Simulate network request
    await Future.delayed(const Duration(milliseconds: 900));

    if (!mounted) return;

    setState(() {
      _isLoading = false;
      _emailSent = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('OTP verification code sent to $email'),
        duration: const Duration(seconds: 1),
      ),
    );

    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, anim, secAnim) => OtpVerificationPage(
          destination: email,
          isFromForgotPassword: true,
        ),
        transitionDuration: const Duration(milliseconds: 250),
        transitionsBuilder: (context, anim, secAnim, child) =>
            FadeTransition(opacity: anim, child: child),
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
                // Main Neumorphic Card
                Container(
                  padding: EdgeInsets.fromLTRB(22.w, 20.h, 22.w, 24.h),
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
                      // Top Row with Back Button
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              padding: EdgeInsets.all(10.w),
                              decoration: BoxDecoration(
                                color: kNeumorphicBg,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  const BoxShadow(
                                    color: kNeumorphicLightShadow,
                                    offset: Offset(-3, -3),
                                    blurRadius: 6,
                                  ),
                                  BoxShadow(
                                    color: kNeumorphicDarkShadow
                                        .withValues(alpha: 0.4),
                                    offset: const Offset(3, 3),
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.arrow_back_rounded,
                                size: 18.sp,
                                color: kNeumorphicTextColor,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Icon(
                            Icons.lock_reset_rounded,
                            size: 26.sp,
                            color: kNeumorphicPrimary,
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),

                      // Header Title & Subtitle
                      NeumorphicAuthHeader(
                        title: 'Forgot Password?',
                        subtitle: _emailSent
                            ? 'Check your inbox for password reset instructions.'
                            : 'Enter your registered email address and we\'ll send you a link to reset your password.',
                      ),
                      SizedBox(height: 24.h),

                      // Email Input Field
                      NeumorphicInputField(
                        controller: _emailController,
                        hintText: 'Enter your email',
                        icon: Icons.alternate_email_rounded,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 24.h),

                      // Submit Button
                      NeumorphicButton(
                        text: _emailSent ? 'Resend Reset Link' : 'Send Reset Link',
                        isLoading: _isLoading,
                        onTap: _handleResetPassword,
                      ),
                      SizedBox(height: 20.h),

                      // Return to Login Prompt
                      NeumorphicBottomPrompt(
                        questionText: 'Remember password?',
                        actionText: 'Log in',
                        onTap: () => Navigator.pop(context),
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
