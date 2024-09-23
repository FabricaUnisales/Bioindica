import 'package:bioindica/src/bio/data/enums/app_state.dart';
import 'package:bioindica/src/bio/domain/entities/bio_data.dart';
import 'package:bioindica/src/bio/domain/repositories/ibio_repository.dart';
import 'package:bioindica/src/bio/domain/result/bio_result.dart';
import 'package:get/get.dart';

class BioController extends GetxController {
  final Rx<AppState> appState = AppState.initial.obs;
  bool get isLoading => appState.value == AppState.loading;

  final RxList<BioData> _animalsList = <BioData>[].obs;
  Rx<BioData>? _selectedAnimal;

  @override
  Future<void> onInit() async {
    await getBioList();
    super.onInit();
  }

  BioData? get selectedAnimal => _selectedAnimal?.value;
  List<BioData> get animalsList => _animalsList;

  Future<void> getBioList() async {
    appState.value = AppState.loading;
    final BioResult result = await Get.find<IBioRepository>().getBioList();

    result.when(
      success: (data) {
        appState.value = AppState.loaded;
        _animalsList.value = data;
      },
      failure: (failure) {
        appState.value = AppState.failure;
        Get.showSnackbar(GetSnackBar(message: failure.message));
      },
    );
  }

  Future<void> getBioListBySpecieName({required String search}) async {
    appState.value = AppState.loading;
    final BioResult result = await Get.find<IBioRepository>()
        .getBioListBySpecieName(specieNameSearch: search);

    await Future.delayed(const Duration(seconds: 1));

    result.when(
      success: (data) {
        appState.value = AppState.loaded;
        _animalsList.value = data;
      },
      failure: (failure) {
        appState.value = AppState.failure;
        Get.showSnackbar(GetSnackBar(message: failure.message));
      },
    );
  }

  void selectBioData(BioData data) {
    _selectedAnimal = data.obs;
  }

  Future<void> registerNewBio(BioData data) async {
    _animalsList.add(data);
  }

  Future<List<String>> getSpeciesList() async {
    return await Get.find<IBioRepository>().getSpeciesList();
  }
}
