import 'package:bioindica/src/bio/presentation/screens/components/bio_ui_lib.dart';
import 'package:bioindica/src/core/utils/validators.dart';
import 'package:flutter/material.dart';

class AuthenticationForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController ctrlEmail;
  final TextEditingController ctrlPassword;
  final bool rememberUser;
  final Function(bool?) onChangedRememberUser;
  final Function() validateLogin;

  const AuthenticationForm({super.key, required this.formKey, required this.ctrlEmail, required this.ctrlPassword, required this.rememberUser, required this.onChangedRememberUser, required this.validateLogin});

  @override
  State<AuthenticationForm> createState() => _AuthenticationFormState();
}

class _AuthenticationFormState extends State<AuthenticationForm> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 30, 30, 20),
      child: Form(
        key: widget.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextField(
              controller: widget.ctrlEmail,
              labelText: 'E-mail',
              validatorFunction: (email) =>
                  Validators.isEmailAndRequired(email),
            ),
            const SizedBox(height: 5),
            CustomTextField(
              isPassword: true,
              controller: widget.ctrlPassword,
              labelText: 'Senha',
              validatorFunction: (password) =>
                  Validators.isRequired(password, 'Senha'),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomCheckboxAndLabel(
                  label: UIText.body('Lembrar usuário'),
                  value: widget.rememberUser,
                  onChanged: widget.onChangedRememberUser,
                  isWhiteBorder: true,
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: UIText.body('Esqueceu a senha?'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 5),
            CustomPrimaryButton(
              onPressed: widget.validateLogin,
              titleText: 'Entrar',
            ),
          ],
        ),
      ),
    );
  }
}
