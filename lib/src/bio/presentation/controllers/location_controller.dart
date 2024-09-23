import 'package:bioindica/src/bio/data/enums/app_state.dart';
import 'package:bioindica/src/bio/data/repositories/results/bio_location_result.dart';
import 'package:bioindica/src/bio/domain/entities/location.dart';
import 'package:bioindica/src/bio/domain/repositories/ilocation_repository.dart';
import 'package:get/get.dart';
import 'package:utm/utm.dart';

class LocationController extends GetxController {
  final Rx<AppState> appState = AppState.initial.obs;
  bool get isLoading => appState.value == AppState.loading;
  bool get isFailure => appState.value == AppState.failure;

  Rx<Location> location = const Location(
    utmCoordinates: UtmCoordinate(0, 0, 0, 0, 0, ''),
    city: 'Não informado',
    state: 'Não informado',
    country: 'Não informado',
  ).obs;

  Future<String?> getLocation(
      {required double latitude, required double longitude}) async {
    String? errorMessage;

    final BioLocationResult result =
        await Get.find<ILocationRepository>().getLocation(
      latitude: latitude,
      longitude: longitude,
    );

    result.when(
      success: (data) {
        location.value = data;
        update();
      },
      error: (failure) {
        errorMessage = failure.message;
      },
    );

    return errorMessage;
  }
}
