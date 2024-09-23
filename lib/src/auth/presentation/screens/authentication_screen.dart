import 'package:bioindica/src/auth/presentation/controllers/auth_controller.dart';
import 'package:bioindica/src/core/routes.dart';
import 'package:bioindica/src/core/utils/local_storage_keys.dart';
import 'package:flutter/material.dart';

import 'package:bioindica/src/auth/presentation/screens/components/authentication_form.dart';
import 'package:bioindica/src/core/ui_widgets/ui_widgets_lib.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _ctrlEmail = TextEditingController();
  final _ctrlPassword = TextEditingController();

  bool _rememberUser = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final storage = Get.find<FlutterSecureStorage>();

      await storage
          .read(key: LocalStorageKeys.rememberUser)
          .then((value) async {
        if (value == null) {
          setState(() => _rememberUser = false);
          return;
        }

        final String email =
            await storage.read(key: LocalStorageKeys.email) ?? '';
        final String password =
            await storage.read(key: LocalStorageKeys.password) ?? '';

        setState(() {
          _ctrlEmail.text = email;
          _ctrlPassword.text = password;
        });
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/auth_background.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 70, bottom: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      UIText.label('Bem-vindo ao'),
                      const SizedBox(height: 10),
                      Image.asset(
                        "assets/logo.png",
                        width: 200,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      AuthenticationForm(
                        formKey: _formKey,
                        ctrlEmail: _ctrlEmail,
                        ctrlPassword: _ctrlPassword,
                        rememberUser: _rememberUser,
                        onChangedRememberUser: (value) {
                          setState(() => _rememberUser = value!);
                        },
                        validateLogin: () => _validateLogin(
                          email: _ctrlEmail.text,
                          password: _ctrlPassword.text,
                        ),
                      ),
                      InkWell(
                        onTap: () => Get.toNamed(ScreensRoutes.signUp),
                        child: UIText.label3('Criar conta'),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _validateLogin({required String email, required String password}) {
    if (_formKey.currentState!.validate()) {
      final storage = Get.find<FlutterSecureStorage>();

      if (_rememberUser) {
        storage.write(key: LocalStorageKeys.email, value: _ctrlEmail.text);
        storage.write(
            key: LocalStorageKeys.password, value: _ctrlPassword.text);
        storage.write(key: LocalStorageKeys.rememberUser, value: 'remember');
      } else {
        storage.delete(key: LocalStorageKeys.email);
        storage.delete(key: LocalStorageKeys.password);
        storage.delete(key: LocalStorageKeys.rememberUser);
      }

      Get.find<AuthController>().login(email: email, password: password);

      Get.offAllNamed(ScreensRoutes.base);
    }
  }
}
