import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final bool isButtonAtBottom;
  final bool isLoginPressed;
  final bool isFacebookPressed;
  final bool isGooglePressed;
  final bool obscurePassword;
  final bool isLoading;
  final String? errorMessage;

  const LoginState({
    this.isButtonAtBottom = false,
    this.isLoginPressed = false,
    this.isFacebookPressed = false,
    this.isGooglePressed = false,
    this.obscurePassword = true,
    this.isLoading = false,
    this.errorMessage,
  });

  LoginState copyWith({
    bool? isButtonAtBottom,
    bool? isLoginPressed,
    bool? isFacebookPressed,
    bool? isGooglePressed,
    bool? obscurePassword,
    bool? isLoading,
    String? errorMessage,
  }) {
    return LoginState(
      isButtonAtBottom: isButtonAtBottom ?? this.isButtonAtBottom,
      isLoginPressed: isLoginPressed ?? this.isLoginPressed,
      isFacebookPressed: isFacebookPressed ?? this.isFacebookPressed,
      isGooglePressed: isGooglePressed ?? this.isGooglePressed,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        isButtonAtBottom,
        isLoginPressed,
        isFacebookPressed,
        isGooglePressed,
        obscurePassword,
        isLoading,
        errorMessage,
      ];
}
