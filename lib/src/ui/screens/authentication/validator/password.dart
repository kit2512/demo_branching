import 'package:formz/formz.dart';

enum PasswordError {
  invalid,
}

class Password extends FormzInput<String, PasswordError> {
  const Password.pure() : super.pure('');
  const Password.dirty([String value = '']) : super.dirty(value);

  @override
  PasswordError? validator(String value) {
    return value.length < 8 ? PasswordError.invalid : null;
  }
}
