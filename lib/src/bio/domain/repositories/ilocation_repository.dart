import 'package:bioindica/src/bio/data/repositories/results/bio_location_result.dart';

abstract class ILocationRepository {
  Future<BioLocationResult> getLocation({required double latitude, required double longitude});
} 