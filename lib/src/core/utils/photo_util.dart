import 'dart:io';
import 'dart:typed_data';

import 'package:bioindica/src/bio/presentation/screens/components/bio_ui_lib.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

abstract class PhotoUtil {
  static Future<Uint8List?> takePhoto() async {
    final XFile? xFile = await ImagePicker().pickImage(source: ImageSource.camera);
    
    if (xFile != null) {
      final CroppedFile? croppedImageFile = await _cropImage(xFile);
      if (croppedImageFile != null) {
        final Uint8List photoBytes = File(croppedImageFile.path).readAsBytesSync();
        return photoBytes;
      }
    }
    return null;
  }

  static Future<CroppedFile?> _cropImage(XFile file) async {
    return await ImageCropper().cropImage(
      sourcePath: file.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cortar Imagem',
            toolbarColor: secondaryColor,
            toolbarWidgetColor: primaryColor,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cortar Imagem',
        ),
      ],
    );
  }
}