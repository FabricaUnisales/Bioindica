import 'package:bioindica/src/bio/presentation/screens/components/bio_ui_lib.dart';
import 'package:bioindica/src/core/routes.dart';
import 'package:bioindica/src/core/utils/version.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsTabScreen extends StatelessWidget {
  const SettingsTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            CustomSettingOption(
              icon: Icons.settings,
              title: 'Alterar senha',
              onTap: () => Get.toNamed(ScreensRoutes.changePassword),
            ),
            CustomSettingOption(
              icon: Icons.info,
              title: 'Versão do aplicativo',
              onTap: () => _showAppVersion(context),
            ),
            CustomSettingOption(
              icon: Icons.power_settings_new,
              title: 'Sair do aplicativo',
              onTap: _showLogoutDialog,
            ),
          ],
        ),
      ),
    );
  }

  void _showAppVersion(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomAlertDialogAlternative(
          title: 'Versão do aplicativo',
          contentWidget: getAppVersion(),
          confirmAction: () => Get.back(),
        );
      },
    );
  }

  void _showLogoutDialog() {
    Get.defaultDialog(
      title: 'Sair',
      middleText: 'Deseja realmente sair?',
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: UIText.cancelButton('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            // Get.find<BioController>().logout();
            Get.offAllNamed(ScreensRoutes.login);
          },
          child: UIText.confirmButton('Sair'),
        ),
      ],
    );
  }
}
