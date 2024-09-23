import 'package:bioindica/src/bio/presentation/controllers/filter_controller.dart';
import 'package:flutter/material.dart';
import 'package:bioindica/src/auth/presentation/controllers/auth_controller.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:bioindica/src/core/routes.dart';
import 'package:bioindica/src/core/theme/styles.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');

  WidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = false;

  _registerFontsLicenses();
  _injectDependencies();

  runApp(const BioIndicaApp());
}

class BioIndicaApp extends StatelessWidget {
  const BioIndicaApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        //PlatformApp
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ], //habilita a internacionalização dos widgets no flutter
          supportedLocales: const <Locale>[
            Locale("pt", "BR"),
          ],
        theme: Styles.setMaterial3Theme(),
        title: 'BioIndica',
        getPages: AppScreens.screens,
        initialRoute: ScreensRoutes.login,
      );
    });
  }
}

void _registerFontsLicenses() {
  LicenseRegistry.addLicense(() async * {
    final poppinsLicense = await rootBundle.loadString('assets/fonts/Poppins/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], poppinsLicense);
  });
  LicenseRegistry.addLicense(() async* {
    final interLicense = await rootBundle.loadString('assets/fonts/Inter/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], interLicense);
  });
}

void _injectDependencies() {
  Get.put<AuthController>(AuthController());
  Get.put<FilterController>(FilterController());
  Get.put<Dio>(Dio());
  Get.put<FlutterSecureStorage>(const FlutterSecureStorage());
}
