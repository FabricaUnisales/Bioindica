import 'package:bioindica/src/base/presentation/controller/navigation_controller.dart';
import 'package:bioindica/src/base/presentation/components/custom_icon_svg.dart';
import 'package:bioindica/src/bio/presentation/controllers/bio_controller.dart';
import 'package:bioindica/src/bio/presentation/screens/tabs/main_tab_screen.dart';
import 'package:bioindica/src/bio/presentation/screens/tabs/settings_tab_screen.dart';
import 'package:bioindica/src/core/routes.dart';
import 'package:bioindica/src/core/ui_widgets/ui_widgets_lib.dart';
import 'package:bioindica/src/core/utils/photo_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseBioScreen extends GetView<NavigationController> {
  const BaseBioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop || Get.find<BioController>().isLoading) return;
        return _showLogoutDialog();
      },
      child: Scaffold(
        body: PageView(
          controller: controller.pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            HomeTabScreen(),
            SettingsTabScreen(),
          ],
        ),
        bottomNavigationBar: Obx(
          () {
            return BottomAppBar(
              surfaceTintColor: Colors.transparent,
              color: bottomNavigationColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomIconSVG(
                    svgIconPath: 'assets/custom_icons/homeIcon.svg',
                    isSelected: controller.currentIndex == 0,
                    onTap: Get.find<BioController>().isLoading
                        ? null
                        : () => controller.navigatePageView(0),
                  ),
                  const SizedBox(),
                  CustomIconSVG(
                    svgIconPath: 'assets/custom_icons/settingsIcon.svg',
                    onTap: Get.find<BioController>().isLoading
                        ? null
                        : () => controller.navigatePageView(1),
                    isSelected: controller.currentIndex == 1,
                  ),
                ],
              ),
            );
          },
        ),
        floatingActionButton: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.fromBorderSide(
                BorderSide(color: bottomNavigationColor, width: 10.s)),
          ),
          child: Obx(() => FloatingActionButton(
                shape: const CircleBorder(),
                onPressed: Get.find<BioController>().isLoading
                    ? null
                    : () async {
                      await PhotoUtil.takePhoto().then(
                          (photoBytes) {
                            if (photoBytes != null) {
                              Get.toNamed(ScreensRoutes.bioRegister, arguments: photoBytes);
                            }
                          },
                        );
                    },
                backgroundColor: secondaryColor,
                child: Icon(
                  Icons.add_circle_outline,
                  color: primaryColor,
                  size: 28.s,
                ),
              )),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
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
