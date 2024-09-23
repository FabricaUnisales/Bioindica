import 'package:bioindica/src/bio/data/repositories/location_repository.dart';
import 'package:bioindica/src/bio/domain/repositories/ilocation_repository.dart';
import 'package:bioindica/src/bio/presentation/controllers/location_controller.dart';
import 'package:get/get.dart';

class LocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ILocationRepository>(() => LocationRepository());
    Get.lazyPut<LocationController>(() => LocationController());
  }
}