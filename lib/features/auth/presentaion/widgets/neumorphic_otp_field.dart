import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bd_doc/common_widgets/neumorphic_auth_widgets.dart';

/// 6-Digit Neumorphic OTP Input Field matching UI mockup
/// Fully controllable from parent page via [controller], [onChanged], and [onCompleted].
class NeumorphicOtpField extends StatefulWidget {
  final TextEditingController controller;
  final int length;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onCompleted;
  final bool autoFocus;
  final bool isError;
  final FocusNode? focusNode;

  const NeumorphicOtpField({
    super.key,
    required this.controller,
    this.length = 6,
    this.onChanged,
    this.onCompleted,
    this.autoFocus = true,
    this.isError = false,
    this.focusNode,
  });

  @override
  State<NeumorphicOtpField> createState() => _NeumorphicOtpFieldState();
}

class _NeumorphicOtpFieldState extends State<NeumorphicOtpField> {
  late final FocusNode _internalFocusNode;
  FocusNode get _effectiveFocusNode => widget.focusNode ?? _internalFocusNode;

  bool _showCursor = true;
  Timer? _cursorTimer;

  @override
  void initState() {
    super.initState();
    _internalFocusNode = FocusNode();
    _effectiveFocusNode.addListener(_handleFocusChange);
    widget.controller.addListener(_handleTextChange);

    _cursorTimer = Timer.periodic(const Duration(milliseconds: 550), (timer) {
      if (mounted && _effectiveFocusNode.hasFocus) {
        setState(() => _showCursor = !_showCursor);
      }
    });

    if (widget.autoFocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _effectiveFocusNode.requestFocus();
      });
    }
  }

  @override
  void dispose() {
    _cursorTimer?.cancel();
    _effectiveFocusNode.removeListener(_handleFocusChange);
    widget.controller.removeListener(_handleTextChange);
    _internalFocusNode.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    if (mounted) setState(() {});
  }

  void _handleTextChange() {
    if (mounted) {
      setState(() {});
      final text = widget.controller.text;
      widget.onChanged?.call(text);
      if (text.length == widget.length) {
        widget.onCompleted?.call(text);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final text = widget.controller.text;
    final hasFocus = _effectiveFocusNode.hasFocus;
    final int focusedIndex = text.length < widget.length ? text.length : widget.length - 1;

    return Stack(
      alignment: Alignment.center,
      children: [
        // Invisible master textfield to capture touch, keyboard, autofill, and paste
        Opacity(
          opacity: 0.0,
          child: SizedBox(
            height: 1,
            width: 1,
            child: TextField(
              controller: widget.controller,
              focusNode: _effectiveFocusNode,
              keyboardType: TextInputType.number,
              autofillHints: const [AutofillHints.oneTimeCode],
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(widget.length),
              ],
            ),
          ),
        ),

        // Visual 6 Neumorphic Inset Boxes
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            if (!_effectiveFocusNode.hasFocus) {
              _effectiveFocusNode.requestFocus();
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(widget.length, (index) {
              final bool isBoxFocused = hasFocus && (index == focusedIndex || (text.length == widget.length && index == widget.length - 1));
              final String char = index < text.length ? text[index] : '';

              return _buildOtpBox(
                char: char,
                isFocused: isBoxFocused,
                isError: widget.isError,
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildOtpBox({
    required String char,
    required bool isFocused,
    required bool isError,
  }) {
    final Color borderColor = isError
        ? Colors.redAccent
        : (isFocused ? kNeumorphicPrimary.withValues(alpha: 0.7) : Colors.transparent);

    final List<BoxShadow> outerGlow = isFocused
        ? [
            BoxShadow(
              color: isError
                  ? Colors.redAccent.withValues(alpha: 0.25)
                  : kNeumorphicPrimary.withValues(alpha: 0.25),
              offset: const Offset(0, 0),
              blurRadius: 8,
              spreadRadius: 1,
            ),
          ]
        : [];

    return Container(
      width: 44.w,
      height: 52.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: outerGlow,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14.r),
        child: InnerShadow(
          shadows: [
            Shadow(
              color: kNeumorphicDarkShadow.withValues(alpha: 0.6),
              offset: const Offset(3, 3),
              blurRadius: 4.5,
            ),
            Shadow(
              color: kNeumorphicLightShadow.withValues(alpha: 0.95),
              offset: const Offset(-3, -3),
              blurRadius: 4.5,
            ),
          ],
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: kNeumorphicBg,
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(
                color: borderColor,
                width: isFocused ? 1.5 : 0.0,
              ),
            ),
            child: char.isNotEmpty
                ? Text(
                    char,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: kNeumorphicTextColor,
                    ),
                  )
                : (isFocused && _showCursor
                    ? Container(
                        width: 2.w,
                        height: 20.h,
                        decoration: BoxDecoration(
                          color: kNeumorphicPrimary,
                          borderRadius: BorderRadius.circular(1.r),
                        ),
                      )
                    : null),
          ),
        ),
      ),
    );
  }
}
