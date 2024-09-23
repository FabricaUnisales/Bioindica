import 'package:bioindica/src/bio/data/repositories/bio_repository.dart';
import 'package:bioindica/src/bio/domain/repositories/ibio_repository.dart';
import 'package:bioindica/src/bio/presentation/controllers/bio_controller.dart';
import 'package:get/get.dart';

class BioBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IBioRepository>(() => BioRepository());
    Get.lazyPut<BioController>(() => BioController());
  }
}