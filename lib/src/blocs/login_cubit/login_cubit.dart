import 'package:demo_branching/src/repositories/repositories.dart';
import 'package:demo_branching/src/ui/screens/authentication/validator/login_validator.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthenticationRepository authenticationRepository;
  LoginCubit({
    required this.authenticationRepository,
  }) : super(const LoginState());

  void onEmailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([email, state.password]),
    ));
  }

  void onPasswordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([state.email, password]),
    ));
  }

  void onSignInPressed() async {
    if (state.status == FormzStatus.invalid) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await authenticationRepository.signInWithEmailAndPassword(
          state.email.value, state.password.value);
    } on SignInWithEmailAndPasswordFailure catch (e) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, errorMessage: e.message));
    }
  }

  void onSignInWithGoogle() async {
    try {
      await authenticationRepository.signInWithGoogle();
    } on SignInWithGoogleFailure catch (e) {
      emit(
        state.copyWith(
          status: FormzStatus.submissionFailure,
          errorMessage: e.message,
        ),
      );
    }
  }

  void onSignInWithFacebook() async {
    try {
      await authenticationRepository.signInWithFacebook();
    } on SignInWithFacebookFailure catch (e) {
      emit(
        state.copyWith(
          status: FormzStatus.submissionFailure,
          errorMessage: e.message,
        ),
      );
    }
  }
}
