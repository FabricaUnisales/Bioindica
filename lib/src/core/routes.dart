import 'package:bioindica/src/auth/presentation/screens/authentication_screen.dart';
import 'package:bioindica/src/auth/presentation/screens/change_password_page.dart';
import 'package:bioindica/src/auth/presentation/screens/signup_screen.dart';
import 'package:bioindica/src/base/binding/navigation_binding.dart';
import 'package:bioindica/src/bio/presentation/screens/base_bio_screen.dart';
import 'package:bioindica/src/bio/presentation/screens/binding/bio_binding.dart';
import 'package:bioindica/src/bio/presentation/screens/about_screen.dart';
import 'package:bioindica/src/bio/presentation/screens/binding/location_binding.dart';
import 'package:bioindica/src/bio/presentation/screens/bio_register_screen.dart';
import 'package:bioindica/src/bio/presentation/screens/specie_search_screen.dart';
import 'package:get/get.dart';

abstract class AppScreens {
  static final screens = <GetPage>[
    GetPage(name: ScreensRoutes.login, page: () => const AuthenticationScreen()),
    GetPage(name: ScreensRoutes.signUp, page: () => const SignUpScreen()),
    GetPage(name: ScreensRoutes.changePassword, page: () => const ChangePasswordPage()),
    GetPage(
      name: ScreensRoutes.base,
      page: () => const BaseBioScreen(),
      bindings: [
        NavigationBinding(),
        BioBinding(),
      ],
    ),
    GetPage(name: ScreensRoutes.about, page: () => const AboutTabScreen()),
    GetPage(
      name: ScreensRoutes.bioRegister,
      page: () => const BioRegisterScreen(),
      bindings: [
        LocationBinding(),
      ],
    ),
    GetPage<String>(name: ScreensRoutes.searchSpecie, page: () => const SpecieSearchScreen())
  ];
}

abstract class ScreensRoutes {
  static const login = '/login';
  static const signUp = '/register';
  static const changePassword = '/changePassword';
  static const base = '/';
  static const about = '/about';
  static const bioRegister = '/animalsRegister';
  static const searchSpecie = '/searchSpecie';
}