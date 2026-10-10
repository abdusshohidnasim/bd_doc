import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bd_doc/common_widgets/custom_scaffold.dart';
import 'package:bd_doc/features/auth/presentaion/login_page.dart';
import 'package:bd_doc/features/auth/presentaion/widgets/auth_neumorphic_widgets.dart';

class ResetPasswordPage extends StatefulWidget {
  final String email;
  final String otpCode;

  const ResetPasswordPage({
    super.key,
    required this.email,
    required this.otpCode,
  });

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleResetPassword() async {
    final String newPassword = _newPasswordController.text;
    final String confirmPassword = _confirmPasswordController.text;

    if (newPassword.isEmpty) {
      _showToast('Please enter your new password');
      return;
    }
    if (newPassword.length < 6) {
      _showToast('Password must be at least 6 characters');
      return;
    }
    if (newPassword != confirmPassword) {
      _showToast('Passwords do not match');
      return;
    }

    setState(() => _isLoading = true);

    // Simulated API call (replace with e.g. Endpoints.newpasswordsatap())
    await Future.delayed(const Duration(milliseconds: 900));

    if (!mounted) return;
    setState(() => _isLoading = false);

    _showToast('Password updated successfully! Please log in.');

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
                // Neumorphic Card
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

                      // Header
                      const NeumorphicAuthHeader(
                        title: 'New Password',
                        subtitle:
                            'Create a new strong password for your account.',
                      ),
                      SizedBox(height: 24.h),

                      // New Password Field
                      NeumorphicInputField(
                        controller: _newPasswordController,
                        hintText: 'New Password',
                        icon: Icons.lock_rounded,
                        obscureText: _obscureNewPassword,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() =>
                                _obscureNewPassword = !_obscureNewPassword);
                          },
                          child: Icon(
                            _obscureNewPassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            size: 18.sp,
                            color: kNeumorphicIconColor.withValues(alpha: 0.7),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),

                      // Confirm New Password Field
                      NeumorphicInputField(
                        controller: _confirmPasswordController,
                        hintText: 'Confirm Password',
                        icon: Icons.lock_outline_rounded,
                        obscureText: _obscureConfirmPassword,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() => _obscureConfirmPassword =
                                !_obscureConfirmPassword);
                          },
                          child: Icon(
                            _obscureConfirmPassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            size: 18.sp,
                            color: kNeumorphicIconColor.withValues(alpha: 0.7),
                          ),
                        ),
                      ),
                      SizedBox(height: 26.h),

                      // Submit Button
                      NeumorphicButton(
                        text: 'Update Password',
                        isLoading: _isLoading,
                        onTap: _handleResetPassword,
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
