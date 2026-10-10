import 'package:equatable/equatable.dart';

class SignUpState extends Equatable {
  final bool obscurePassword;
  final bool obscureConfirmPassword;
  final bool agreeToPolicy;
  final bool isSignUpPressed;
  final bool isFacebookPressed;
  final bool isGooglePressed;
  final bool isLoading;
  final String? errorMessage;

  const SignUpState({
    this.obscurePassword = true,
    this.obscureConfirmPassword = true,
    this.agreeToPolicy = false,
    this.isSignUpPressed = false,
    this.isFacebookPressed = false,
    this.isGooglePressed = false,
    this.isLoading = false,
    this.errorMessage,
  });

  SignUpState copyWith({
    bool? obscurePassword,
    bool? obscureConfirmPassword,
    bool? agreeToPolicy,
    bool? isSignUpPressed,
    bool? isFacebookPressed,
    bool? isGooglePressed,
    bool? isLoading,
    String? errorMessage,
  }) {
    return SignUpState(
      obscurePassword: obscurePassword ?? this.obscurePassword,
      obscureConfirmPassword:
          obscureConfirmPassword ?? this.obscureConfirmPassword,
      agreeToPolicy: agreeToPolicy ?? this.agreeToPolicy,
      isSignUpPressed: isSignUpPressed ?? this.isSignUpPressed,
      isFacebookPressed: isFacebookPressed ?? this.isFacebookPressed,
      isGooglePressed: isGooglePressed ?? this.isGooglePressed,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        obscurePassword,
        obscureConfirmPassword,
        agreeToPolicy,
        isSignUpPressed,
        isFacebookPressed,
        isGooglePressed,
        isLoading,
        errorMessage,
      ];
}
