import 'package:bioindica/src/base/presentation/components/custom_text_field.dart';
import 'package:bioindica/src/core/theme/colors.dart';
import 'package:bioindica/src/core/ui_widgets/ui_text.dart';
import 'package:bioindica/src/core/utils/validators.dart';
import 'package:flutter/material.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _ctrlEmail = TextEditingController();
  final _ctrlPassword = TextEditingController();
  final _ctrlConfirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 30, 30, 15),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextField(
              controller: _ctrlEmail,
              labelText: 'E-mail',
              validatorFunction: (email) => Validators.isEmailAndRequired(email),
              
            ),
            const SizedBox(height: 5),
            CustomTextField(
              isPassword: true,
              controller: _ctrlPassword,
              labelText: 'Senha',
              validatorFunction: Validators.isPasswordGreaterThan7Char
            ),
            const SizedBox(height: 5),
            CustomTextField(
              isPassword: true,
              controller: _ctrlConfirmPassword,
              validatorFunction: (passwordValue) {
                return Validators.confirmPassword(passwordValue, passwordToCompare: _ctrlConfirmPassword.text);
              },
              labelText: 'Confirme sua senha',

            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  backgroundColor: secondaryColor),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  
                }
              },
              child: UIText.label2('Entrar'),
            ),
          ],
        ),
      ),
    );
  }
}
