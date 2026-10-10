import 'package:flutter_bloc/flutter_bloc.dart';
import 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(const SignUpState());

  void togglePasswordVisibility() {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  void toggleConfirmPasswordVisibility() {
    emit(state.copyWith(
        obscureConfirmPassword: !state.obscureConfirmPassword));
  }

  void togglePolicyAgreement() {
    emit(state.copyWith(agreeToPolicy: !state.agreeToPolicy));
  }

  void setPolicyAgreement(bool value) {
    emit(state.copyWith(agreeToPolicy: value));
  }

  void setSignUpButtonPressed(bool isPressed) {
    emit(state.copyWith(isSignUpPressed: isPressed));
  }

  void setFacebookPressed(bool isPressed) {
    emit(state.copyWith(isFacebookPressed: isPressed));
  }

  void setGooglePressed(bool isPressed) {
    emit(state.copyWith(isGooglePressed: isPressed));
  }
}
