import 'package:bioindica/src/bio/domain/entities/bio_data.dart';
import 'package:bioindica/src/bio/domain/result/bio_result.dart';

abstract class IBioRepository {
  Future<BioResult<List<BioData>>> getBioList();
  Future<BioResult<List<BioData>>> getBioListBySpecieName(
      {required String specieNameSearch});

  Future<List<String>> getSpeciesList();
}
