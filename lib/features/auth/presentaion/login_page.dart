import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bd_doc/common_widgets/custom_scaffold.dart';
import 'package:bd_doc/common_widgets/neumorphic_auth_widgets.dart';
import 'package:bd_doc/features/auth/cubit/login_cubit.dart';
import 'package:bd_doc/features/auth/cubit/login_state.dart';
import 'package:bd_doc/features/auth/presentaion/forgot_password_page.dart';
import 'package:bd_doc/features/auth/presentaion/signup_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: const _LoginPageView(),
    );
  }
}

class _LoginPageView extends StatefulWidget {
  const _LoginPageView();

  @override
  State<_LoginPageView> createState() => _LoginPageViewState();
}

class _LoginPageViewState extends State<_LoginPageView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _navigateToSignUp() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, anim, secAnim) => const SignUpPage(),
        transitionDuration: const Duration(milliseconds: 250),
        transitionsBuilder: (context, anim, secAnim, child) =>
            FadeTransition(opacity: anim, child: child),
      ),
    );
  }

  void _navigateToForgotPassword() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, anim, secAnim) =>
            const ForgotPasswordPage(),
        transitionDuration: const Duration(milliseconds: 250),
        transitionsBuilder: (context, anim, secAnim, child) =>
            FadeTransition(opacity: anim, child: child),
      ),
    );
  }

  void _handleLogin() {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text;

    if (email.isEmpty) {
      _showToast('Please enter your email');
      return;
    }
    if (password.isEmpty) {
      _showToast('Please enter your password');
      return;
    }

    _showToast('Logging in as $email...');
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
      body: BlocBuilder<LoginCubit, LoginState>(
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
                            selectedIndex: 0,
                            onTabChanged: (index) {
                              if (index == 1) {
                                _navigateToSignUp();
                              }
                            },
                          ),
                          SizedBox(height: 20.h),

                          // Header Title & Subtitle (From UI Mockup)
                          const NeumorphicAuthHeader(
                            title: 'Welcome Back',
                            subtitle: 'Please enter your details to sign in.',
                          ),
                          SizedBox(height: 24.h),

                          // Email Input Field (Debossed / Sunken)
                          NeumorphicInputField(
                            controller: _emailController,
                            hintText: 'Email Id',
                            icon: Icons.person_rounded,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: 18.h),

                          // Password Input Field (Debossed / Sunken)
                          NeumorphicInputField(
                            controller: _passwordController,
                            hintText: 'Password',
                            icon: Icons.lock_rounded,
                            obscureText: state.obscurePassword,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                context
                                    .read<LoginCubit>()
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
                          SizedBox(height: 10.h),

                          // Forgot Password Link
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: _navigateToForgotPassword,
                              behavior: HitTestBehavior.opaque,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 4.h, horizontal: 2.w),
                                child: Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600,
                                    color: kNeumorphicPrimary,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 18.h),

                          // Log in Button (Raised / Interactive)
                          NeumorphicButton(
                            text: 'Log in',
                            isLoading: state.isLoading,
                            onTap: _handleLogin,
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
                                  _showToast('Facebook login clicked');
                                },
                              ),
                              SizedBox(width: 16.w),
                              NeumorphicSocialButton(
                                label: 'Google',
                                leadingSymbol: 'G',
                                onTap: () {
                                  _showToast('Google login clicked');
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),

                          // Bottom Switch Prompt
                          NeumorphicBottomPrompt(
                            questionText: "Don't have an account?",
                            actionText: 'Sign Up',
                            onTap: _navigateToSignUp,
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
