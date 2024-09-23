import 'package:bioindica/src/base/data/repositories/base_repository.dart';
import 'package:bioindica/src/bio/domain/entities/bio_data.dart';
import 'package:bioindica/src/bio/domain/repositories/ibio_repository.dart';
import 'package:bioindica/src/bio/domain/result/bio_result.dart';
import 'package:bioindica/src/core/errors/failures.dart';
import 'package:bioindica/src/core/utils/formatters.dart';
import 'package:bioindica/src/core/utils/mock_app_data.dart' as mock;
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class BioRepository extends BaseRepository implements IBioRepository {
  BioRepository() {
    configureDio(Get.find<Dio>());
  }

  @override
  Future<BioResult<List<BioData>>> getBioList() async {
    await Future.delayed(const Duration(seconds: 2));

    try {
      List<BioData> bioList = mock.bioData.map((bio) {
        return bio.copyWith(latimName: Formatters.getLatimName(bio.specie));
      }).toList();

      return BioResult.success(bioList);
    } catch (e) {
      return BioResult.failure(Failure(
          message: 'Erro ao buscar dados dos seres-vivos: ${e.toString()}'));
    }
  }

  @override
  Future<BioResult<List<BioData>>> getBioListBySpecieName(
      {required String specieNameSearch}) async {
    try {
      // final String url = generateUrl(method: 'bio-list-request');

      List<BioData> filteredBioList = [];
      for (BioData bioData in mock.bioData) {
        if (bioData.specie
            .toLowerCase()
            .contains(specieNameSearch.toLowerCase())) {
          final BioData bioDataFound = bioData.copyWith(
              latimName: Formatters.getLatimName(bioData.specie));
          filteredBioList.add(bioDataFound);
        }
      }

      return BioResult.success(filteredBioList);
    } catch (e) {
      return BioResult.failure(Failure(message: 'Erro ao buscar dados dos seres-vivos: ${e.toString()}'));
    }
  }

  @override
  Future<List<String>> getSpeciesList() async {
    await Future.delayed(const Duration(seconds: 2));
    return mock.especiesFauna;
  }
}
