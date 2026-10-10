import 'package:flutter/material.dart';
import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bd_doc/common_widgets/neumorphic_auth_widgets.dart';

/// Circular Neumorphic sunken badge with icon inside (matches UI mockup)
class NeumorphicIconBadge extends StatelessWidget {
  final Widget? child;
  final IconData? icon;
  final double? size;
  final Color? iconColor;

  const NeumorphicIconBadge({
    super.key,
    this.child,
    this.icon,
    this.size,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final double badgeSize = size ?? 72.w;

    return Center(
      child: ClipOval(
        child: InnerShadow(
          shadows: [
            Shadow(
              color: kNeumorphicDarkShadow.withValues(alpha: 0.65),
              offset: const Offset(3.5, 3.5),
              blurRadius: 6,
            ),
            Shadow(
              color: kNeumorphicLightShadow.withValues(alpha: 0.95),
              offset: const Offset(-3.5, -3.5),
              blurRadius: 6,
            ),
          ],
          child: Container(
            height: badgeSize,
            width: badgeSize,
            decoration: const BoxDecoration(
              color: kNeumorphicBg,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: child ??
                Icon(
                  icon ?? Icons.lock_outline_rounded,
                  size: (badgeSize * 0.42).sp,
                  color: iconColor ?? const Color(0xFFD4A017),
                ),
          ),
        ),
      ),
    );
  }
}
