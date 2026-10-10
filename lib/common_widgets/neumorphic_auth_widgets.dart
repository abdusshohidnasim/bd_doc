import 'package:flutter/material.dart';
import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Neumorphic Theme Palette Constants
const Color kNeumorphicBg = Color(0xFFECF0F3);
const Color kNeumorphicDarkShadow = Color(0xFFA3B1C6);
const Color kNeumorphicLightShadow = Colors.white;
const Color kNeumorphicTextColor = Color(0xFF263238);
const Color kNeumorphicSubTextColor = Color(0xFF78849B);
const Color kNeumorphicHintColor = Color(0xFF94A3B8);
const Color kNeumorphicIconColor = Color(0xFF6B7280);
const Color kNeumorphicPrimary = Color(0xFF4A72EC);

/// Neumorphic Tab Switcher (Login / Sign Up) with smooth animated raised pill
class NeumorphicAuthToggle extends StatelessWidget {
  final int selectedIndex; // 0 for Login, 1 for Sign Up
  final ValueChanged<int> onTabChanged;

  const NeumorphicAuthToggle({
    super.key,
    required this.selectedIndex,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(26.r),
      child: InnerShadow(
        shadows: [
          Shadow(
            color: kNeumorphicDarkShadow.withValues(alpha: 0.55),
            offset: const Offset(2.5, 2.5),
            blurRadius: 4,
          ),
          Shadow(
            color: kNeumorphicLightShadow.withValues(alpha: 0.9),
            offset: const Offset(-2.5, -2.5),
            blurRadius: 4,
          ),
        ],
        child: Container(
          height: 48.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: kNeumorphicBg,
            borderRadius: BorderRadius.circular(26.r),
          ),
          padding: EdgeInsets.all(4.w),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double tabWidth = constraints.maxWidth / 2;
              return Stack(
                children: [
                  // Smoothly sliding active raised pill
                  AnimatedAlign(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOutCubic,
                    alignment: selectedIndex == 0
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    child: Container(
                      width: tabWidth,
                      height: constraints.maxHeight,
                      decoration: BoxDecoration(
                        color: kNeumorphicBg,
                        borderRadius: BorderRadius.circular(22.r),
                        boxShadow: [
                          const BoxShadow(
                            color: kNeumorphicLightShadow,
                            offset: Offset(-2, -2),
                            blurRadius: 5,
                          ),
                          BoxShadow(
                            color: kNeumorphicDarkShadow.withValues(alpha: 0.45),
                            offset: const Offset(2, 2),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Tab Labels
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => onTabChanged(0),
                          child: Center(
                            child: AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 250),
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: selectedIndex == 0
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                                color: selectedIndex == 0
                                    ? kNeumorphicPrimary
                                    : kNeumorphicSubTextColor,
                                letterSpacing: 0.2,
                              ),
                              child: const Text('Login'),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => onTabChanged(1),
                          child: Center(
                            child: AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 250),
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: selectedIndex == 1
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                                color: selectedIndex == 1
                                    ? kNeumorphicPrimary
                                    : kNeumorphicSubTextColor,
                                letterSpacing: 0.2,
                              ),
                              child: const Text('Sign Up'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

/// Neumorphic Header with Title and Subtitle
class NeumorphicAuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const NeumorphicAuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.w700,
            color: kNeumorphicTextColor,
            letterSpacing: -0.3,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 6.h),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w400,
            color: kNeumorphicSubTextColor,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

/// Neumorphic Sunken (Debossed) Input Field
class NeumorphicInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;

  const NeumorphicInputField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28.r),
      child: InnerShadow(
        shadows: [
          Shadow(
            color: kNeumorphicDarkShadow.withValues(alpha: 0.6),
            offset: const Offset(3, 3),
            blurRadius: 5,
          ),
          Shadow(
            color: kNeumorphicLightShadow.withValues(alpha: 0.9),
            offset: const Offset(-3, -3),
            blurRadius: 5,
          ),
        ],
        child: Container(
          height: 52.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: kNeumorphicBg,
            borderRadius: BorderRadius.circular(28.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Row(
            children: [
              Icon(
                icon,
                size: 18.sp,
                color: kNeumorphicIconColor,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: TextField(
                  controller: controller,
                  obscureText: obscureText,
                  keyboardType: keyboardType,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: kNeumorphicTextColor,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: TextStyle(
                      fontSize: 14.sp,
                      color: kNeumorphicHintColor,
                      fontWeight: FontWeight.w400,
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              if (suffixIcon != null) suffixIcon!,
            ],
          ),
        ),
      ),
    );
  }
}

/// Neumorphic Raised Button with interactive press / long-press feel
class NeumorphicButton extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  final bool isLoading;

  const NeumorphicButton({
    super.key,
    required this.text,
    required this.onTap,
    this.isLoading = false,
  });

  @override
  State<NeumorphicButton> createState() => _NeumorphicButtonState();
}

class _NeumorphicButtonState extends State<NeumorphicButton> {
  bool _isPressed = false;

  void _setPressed(bool val) {
    if (_isPressed != val) {
      setState(() => _isPressed = val);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      onLongPressDown: (_) => _setPressed(true),
      onLongPressEnd: (_) => _setPressed(false),
      onLongPressCancel: () => _setPressed(false),
      onTap: widget.isLoading ? null : widget.onTap,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 150),
        child: _isPressed
            ? ClipRRect(
                key: const ValueKey<bool>(true),
                borderRadius: BorderRadius.circular(25.r),
                child: InnerShadow(
                  shadows: [
                    Shadow(
                      color: kNeumorphicDarkShadow.withValues(alpha: 0.6),
                      offset: const Offset(3, 3),
                      blurRadius: 5,
                    ),
                    Shadow(
                      color: kNeumorphicLightShadow.withValues(alpha: 0.9),
                      offset: const Offset(-3, -3),
                      blurRadius: 5,
                    ),
                  ],
                  child: Container(
                    height: 50.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: kNeumorphicBg,
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                    alignment: Alignment.center,
                    child: widget.isLoading
                        ? SizedBox(
                            height: 20.h,
                            width: 20.h,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              color: kNeumorphicPrimary,
                            ),
                          )
                        : Text(
                            widget.text,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: kNeumorphicTextColor,
                              letterSpacing: 0.2,
                            ),
                          ),
                  ),
                ),
              )
            : Container(
                key: const ValueKey<bool>(false),
                height: 50.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kNeumorphicBg,
                  borderRadius: BorderRadius.circular(25.r),
                  boxShadow: [
                    const BoxShadow(
                      color: kNeumorphicLightShadow,
                      offset: Offset(-4, -4),
                      blurRadius: 8,
                    ),
                    BoxShadow(
                      color: kNeumorphicDarkShadow.withValues(alpha: 0.45),
                      offset: const Offset(4, 4),
                      blurRadius: 8,
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: widget.isLoading
                    ? SizedBox(
                        height: 20.h,
                        width: 20.h,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: kNeumorphicPrimary,
                        ),
                      )
                    : Text(
                        widget.text,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: kNeumorphicTextColor,
                          letterSpacing: 0.2,
                        ),
                      ),
              ),
      ),
    );
  }
}

/// Neumorphic Raised Social Button (Facebook / Google / etc.)
class NeumorphicSocialButton extends StatefulWidget {
  final String label;
  final String leadingSymbol;
  final VoidCallback onTap;

  const NeumorphicSocialButton({
    super.key,
    required this.label,
    required this.leadingSymbol,
    required this.onTap,
  });

  @override
  State<NeumorphicSocialButton> createState() => _NeumorphicSocialButtonState();
}

class _NeumorphicSocialButtonState extends State<NeumorphicSocialButton> {
  bool _isPressed = false;

  void _setPressed(bool val) {
    if (_isPressed != val) {
      setState(() => _isPressed = val);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      onLongPressDown: (_) => _setPressed(true),
      onLongPressEnd: (_) => _setPressed(false),
      onLongPressCancel: () => _setPressed(false),
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: kNeumorphicBg,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: _isPressed
              ? [
                  BoxShadow(
                    color: kNeumorphicDarkShadow.withValues(alpha: 0.35),
                    offset: const Offset(1, 1),
                    blurRadius: 2,
                  ),
                  const BoxShadow(
                    color: kNeumorphicLightShadow,
                    offset: Offset(-1, -1),
                    blurRadius: 2,
                  ),
                ]
              : [
                  const BoxShadow(
                    color: kNeumorphicLightShadow,
                    offset: Offset(-3, -3),
                    blurRadius: 6,
                  ),
                  BoxShadow(
                    color: kNeumorphicDarkShadow.withValues(alpha: 0.4),
                    offset: const Offset(3, 3),
                    blurRadius: 6,
                  ),
                ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.leadingSymbol,
              style: TextStyle(
                fontSize: widget.leadingSymbol == 'f' ? 16.sp : 14.sp,
                fontWeight: FontWeight.w900,
                color: kNeumorphicTextColor,
                fontFamily: 'Roboto',
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              widget.label,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: kNeumorphicTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Neumorphic Prompt (e.g. "Don't have an account? Sign Up")
class NeumorphicBottomPrompt extends StatelessWidget {
  final String questionText;
  final String actionText;
  final VoidCallback onTap;

  const NeumorphicBottomPrompt({
    super.key,
    required this.questionText,
    required this.actionText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              questionText,
              style: TextStyle(
                fontSize: 13.sp,
                color: kNeumorphicSubTextColor,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(width: 4.w),
            Text(
              actionText,
              style: TextStyle(
                fontSize: 13.sp,
                color: kNeumorphicPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Neumorphic Checkbox with 3D sunken state and smooth active state
class NeumorphicCheckbox extends StatelessWidget {
  final bool isChecked;
  final ValueChanged<bool> onChanged;

  const NeumorphicCheckbox({
    super.key,
    required this.isChecked,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!isChecked),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 22.w,
        width: 22.w,
        decoration: BoxDecoration(
          color: isChecked ? kNeumorphicPrimary : kNeumorphicBg,
          borderRadius: BorderRadius.circular(6.r),
          boxShadow: isChecked
              ? [
                  BoxShadow(
                    color: kNeumorphicPrimary.withValues(alpha: 0.35),
                    offset: const Offset(1, 2),
                    blurRadius: 4,
                  ),
                ]
              : [
                  const BoxShadow(
                    color: kNeumorphicLightShadow,
                    offset: Offset(-2, -2),
                    blurRadius: 3,
                  ),
                  BoxShadow(
                    color: kNeumorphicDarkShadow.withValues(alpha: 0.4),
                    offset: const Offset(2, 2),
                    blurRadius: 3,
                  ),
                ],
        ),
        alignment: Alignment.center,
        child: isChecked
            ? Icon(
                Icons.check_rounded,
                size: 15.sp,
                color: Colors.white,
              )
            : null,
      ),
    );
  }
}

/// Neumorphic Terms & Privacy Policy Agreement Row
class NeumorphicPolicyAgreement extends StatelessWidget {
  final bool isChecked;
  final ValueChanged<bool> onChanged;
  final VoidCallback onPolicyTap;

  const NeumorphicPolicyAgreement({
    super.key,
    required this.isChecked,
    required this.onChanged,
    required this.onPolicyTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        NeumorphicCheckbox(
          isChecked: isChecked,
          onChanged: onChanged,
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: GestureDetector(
            onTap: onPolicyTap,
            behavior: HitTestBehavior.opaque,
            child: Text.rich(
              TextSpan(
                text: 'I agree to the ',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: kNeumorphicSubTextColor,
                  fontWeight: FontWeight.w400,
                  height: 1.3,
                ),
                children: [
                  TextSpan(
                    text: 'Privacy Policy',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: kNeumorphicPrimary,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                      decorationColor: kNeumorphicPrimary,
                    ),
                  ),
                  const TextSpan(text: ' & '),
                  TextSpan(
                    text: 'Terms',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: kNeumorphicPrimary,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                      decorationColor: kNeumorphicPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Show Neumorphic Privacy Policy & Terms Modal BottomSheet
void showNeumorphicPolicySheet(
  BuildContext context, {
  VoidCallback? onAccept,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) {
      return Container(
        decoration: BoxDecoration(
          color: kNeumorphicBg,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
          boxShadow: [
            BoxShadow(
              color: kNeumorphicDarkShadow.withValues(alpha: 0.4),
              offset: const Offset(0, -4),
              blurRadius: 16,
            ),
          ],
        ),
        padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 28.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: kNeumorphicDarkShadow.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 18.h),
            Text(
              'Privacy Policy & Terms of Service',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: kNeumorphicTextColor,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              'Please review our policies before continuing.',
              style: TextStyle(
                fontSize: 12.sp,
                color: kNeumorphicSubTextColor,
              ),
            ),
            SizedBox(height: 16.h),
            _buildPolicyItem(
              icon: Icons.security_rounded,
              title: 'Data Protection & Privacy',
              desc:
                  'We take your data security seriously. Your personal details and medical information are encrypted and never shared with unauthorized third parties.',
            ),
            SizedBox(height: 12.h),
            _buildPolicyItem(
              icon: Icons.verified_user_rounded,
              title: 'Account Responsibilities',
              desc:
                  'You agree to provide accurate information and keep your login credentials secure. You are responsible for all activities under your account.',
            ),
            SizedBox(height: 12.h),
            _buildPolicyItem(
              icon: Icons.notifications_active_rounded,
              title: 'Communications & Updates',
              desc:
                  'We may send important system notifications, appointment updates, or account alerts to your registered email address.',
            ),
            SizedBox(height: 22.h),
            NeumorphicButton(
              text: 'I Understand & Accept',
              onTap: () {
                Navigator.pop(context);
                if (onAccept != null) onAccept();
              },
            ),
          ],
        ),
      );
    },
  );
}

Widget _buildPolicyItem({
  required IconData icon,
  required String title,
  required String desc,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: kNeumorphicBg,
          shape: BoxShape.circle,
          boxShadow: [
            const BoxShadow(
              color: kNeumorphicLightShadow,
              offset: Offset(-2, -2),
              blurRadius: 4,
            ),
            BoxShadow(
              color: kNeumorphicDarkShadow.withValues(alpha: 0.35),
              offset: const Offset(2, 2),
              blurRadius: 4,
            ),
          ],
        ),
        child: Icon(
          icon,
          size: 16.sp,
          color: kNeumorphicPrimary,
        ),
      ),
      SizedBox(width: 12.w),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: kNeumorphicTextColor,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              desc,
              style: TextStyle(
                fontSize: 11.5.sp,
                color: kNeumorphicSubTextColor,
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
