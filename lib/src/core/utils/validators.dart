import 'package:get/get.dart';

class Validators {
  static String? isRequired(String? value, String field) {
    if (value == null || value.isEmpty) {
      return "O campo \"$field\" é obrigatório";
    }

    return null;
  }

  static String? isEmailAndRequired(String? value) {
    String? message = isRequired(value, 'Email');
    if (message != null) return message;

    if (!value!.isEmail) {
      return 'Formato de E-mail inválido';
    }
    return null;
  }

  static String? isPasswordGreaterThan7Char(String? value, {String field = 'Senha'}) {
    String? message = isRequired(value, field);
    if (message != null) return message;

    if (value!.length < 7) {
      return 'A senha deve ter no mínimo 7 caracteres';
    }
    return null;
  }

  static String? confirmPassword(
    String? passwordValue,
    {required String passwordToCompare}
  ) {
    String? validatePassword = Validators.isRequired(passwordValue, 'Confimação de Senha');
    if (validatePassword != null) return validatePassword;

    if (passwordValue != passwordToCompare) {
      return 'As senhas não coincidem';
    }
    return null;
  }
}
