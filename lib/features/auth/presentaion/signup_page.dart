import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bd_doc/common_widgets/custom_scaffold.dart';
import 'package:bd_doc/common_widgets/neumorphic_auth_widgets.dart';
import 'package:bd_doc/features/auth/cubit/signup_cubit.dart';
import 'package:bd_doc/features/auth/cubit/signup_state.dart';
import 'package:bd_doc/features/auth/presentaion/login_page.dart';
import 'package:bd_doc/features/auth/presentaion/otp_verification_page.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: const _SignUpPageView(),
    );
  }
}

class _SignUpPageView extends StatefulWidget {
  const _SignUpPageView();

  @override
  State<_SignUpPageView> createState() => _SignUpPageViewState();
}

class _SignUpPageViewState extends State<_SignUpPageView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _navigateToLogin() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, anim, secAnim) => const LoginPage(),
        transitionDuration: const Duration(milliseconds: 250),
        transitionsBuilder: (context, anim, secAnim, child) =>
            FadeTransition(opacity: anim, child: child),
      ),
    );
  }

  void _handleSignUp(SignUpState state) {
    final String name = _nameController.text.trim();
    final String email = _emailController.text.trim();
    final String password = _passwordController.text;
    final String confirmPassword = _confirmPasswordController.text;

    if (name.isEmpty) {
      _showToast('Please enter your full name');
      return;
    }
    if (email.isEmpty) {
      _showToast('Please enter your email');
      return;
    }
    if (password.isEmpty) {
      _showToast('Please enter your password');
      return;
    }
    if (password != confirmPassword) {
      _showToast('Passwords do not match');
      return;
    }
    if (!state.agreeToPolicy) {
      _showToast('Please agree to the Privacy Policy & Terms to continue');
      return;
    }

    _showToast('Verification code sent to $email');

    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, anim, secAnim) => OtpVerificationPage(
          destination: email,
          isFromSignUp: true,
        ),
        transitionDuration: const Duration(milliseconds: 250),
        transitionsBuilder: (context, anim, secAnim, child) =>
            FadeTransition(opacity: anim, child: child),
      ),
    );
  }

  void _showToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundColor: kNeumorphicBg,
      body: BlocBuilder<SignUpCubit, SignUpState>(
        builder: (context, state) {
          return TweenAnimationBuilder<double>(
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
                      padding: EdgeInsets.fromLTRB(22.w, 20.h, 22.w, 20.h),
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
                          // Neumorphic Tab Toggle (Login / Sign Up)
                          NeumorphicAuthToggle(
                            selectedIndex: 1,
                            onTabChanged: (index) {
                              if (index == 0) {
                                _navigateToLogin();
                              }
                            },
                          ),
                          SizedBox(height: 20.h),

                          // Header Title & Subtitle
                          const NeumorphicAuthHeader(
                            title: 'Create Account',
                            subtitle: 'Please enter your details to sign up.',
                          ),
                          SizedBox(height: 24.h),

                          // Full Name Field (Debossed / Sunken)
                          NeumorphicInputField(
                            controller: _nameController,
                            hintText: 'Full Name',
                            icon: Icons.badge_rounded,
                            keyboardType: TextInputType.name,
                          ),
                          SizedBox(height: 16.h),

                          // Email Input Field (Debossed / Sunken)
                          NeumorphicInputField(
                            controller: _emailController,
                            hintText: 'Email Id',
                            icon: Icons.alternate_email_rounded,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: 16.h),

                          // Password Input Field (Debossed / Sunken)
                          NeumorphicInputField(
                            controller: _passwordController,
                            hintText: 'Password',
                            icon: Icons.lock_rounded,
                            obscureText: state.obscurePassword,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                context
                                    .read<SignUpCubit>()
                                    .togglePasswordVisibility();
                              },
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 250),
                                transitionBuilder: (child, anim) =>
                                    ScaleTransition(scale: anim, child: child),
                                child: Icon(
                                  state.obscurePassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  key: ValueKey<bool>(state.obscurePassword),
                                  size: 18.sp,
                                  color: kNeumorphicIconColor.withValues(alpha: 0.7),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16.h),

                          // Confirm Password Input Field (Debossed / Sunken)
                          NeumorphicInputField(
                            controller: _confirmPasswordController,
                            hintText: 'Confirm Password',
                            icon: Icons.lock_outline_rounded,
                            obscureText: state.obscureConfirmPassword,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                context
                                    .read<SignUpCubit>()
                                    .toggleConfirmPasswordVisibility();
                              },
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 250),
                                transitionBuilder: (child, anim) =>
                                    ScaleTransition(scale: anim, child: child),
                                child: Icon(
                                  state.obscureConfirmPassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  key: ValueKey<bool>(
                                      state.obscureConfirmPassword),
                                  size: 18.sp,
                                  color: kNeumorphicIconColor.withValues(alpha: 0.7),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16.h),

                          // Privacy Policy & Terms Agreement
                          NeumorphicPolicyAgreement(
                            isChecked: state.agreeToPolicy,
                            onChanged: (val) {
                              context
                                  .read<SignUpCubit>()
                                  .setPolicyAgreement(val);
                            },
                            onPolicyTap: () {
                              showNeumorphicPolicySheet(
                                context,
                                onAccept: () {
                                  context
                                      .read<SignUpCubit>()
                                      .setPolicyAgreement(true);
                                },
                              );
                            },
                          ),
                          SizedBox(height: 20.h),

                          // Sign Up Button (Raised / Interactive)
                          NeumorphicButton(
                            text: 'Sign Up',
                            isLoading: state.isLoading,
                            onTap: () => _handleSignUp(state),
                          ),
                          SizedBox(height: 18.h),

                          // "Or" Divider
                          Text(
                            'Or',
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                              color: kNeumorphicSubTextColor,
                            ),
                          ),
                          SizedBox(height: 18.h),

                          // Social Buttons (Facebook & Google)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              NeumorphicSocialButton(
                                label: 'Facebook',
                                leadingSymbol: 'f',
                                onTap: () {
                                  _showToast('Facebook signup clicked');
                                },
                              ),
                              SizedBox(width: 16.w),
                              NeumorphicSocialButton(
                                label: 'Google',
                                leadingSymbol: 'G',
                                onTap: () {
                                  _showToast('Google signup clicked');
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),

                          // Bottom Switch Prompt
                          NeumorphicBottomPrompt(
                            questionText: 'Already have an account?',
                            actionText: 'Log in',
                            onTap: _navigateToLogin,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
