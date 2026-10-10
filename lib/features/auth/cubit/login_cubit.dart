import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  void togglePasswordVisibility() {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  void setLoginButtonPressed(bool isPressed) {
    emit(state.copyWith(isLoginPressed: isPressed));
  }

  void setFacebookPressed(bool isPressed) {
    emit(state.copyWith(isFacebookPressed: isPressed));
  }

  void setGooglePressed(bool isPressed) {
    emit(state.copyWith(isGooglePressed: isPressed));
  }

  /// Handles login button press
  void onLoginButtonPressed() {
    // Keep button in its place without moving it
  }

  void moveButtonToBottom() {
    emit(state.copyWith(isButtonAtBottom: true));
  }

  void resetButtonPosition() {
    emit(state.copyWith(isButtonAtBottom: false));
  }
}
