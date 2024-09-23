import 'package:bioindica/src/auth/presentation/screens/components/signup_form.dart';
import 'package:bioindica/src/core/ui_widgets/ui_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/auth_background.png"),
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
                      const SignUpForm(),
                      InkWell(
                        onTap: () => Get.back(),
                        child: UIText.label3('Retornar para Login'),
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
}