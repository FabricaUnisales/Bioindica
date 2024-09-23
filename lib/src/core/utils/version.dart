import 'package:bioindica/src/bio/presentation/screens/components/bio_ui_lib.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

Future<String> appVersion() async {
  String version;
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  version = packageInfo.version;
  return 'BioIndica v$version';
}

FutureBuilder<String> getAppVersion() {
  return FutureBuilder(
    future: appVersion(),
    builder: (BuildContext context, AsyncSnapshot<String?> text) {
      if (text.data == null) {
        return const Text('');
      }
      return UIText.label6(text.data!);
    },
  );
}
