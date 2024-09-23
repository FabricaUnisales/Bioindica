import 'package:bioindica/src/base/data/repositories/base_repository.dart';
import 'package:bioindica/src/bio/data/dtos/bio_location_response.dart';
import 'package:bioindica/src/bio/data/repositories/results/bio_location_result.dart';
import 'package:bioindica/src/bio/domain/entities/location.dart';
import 'package:bioindica/src/bio/domain/repositories/ilocation_repository.dart';
import 'package:bioindica/src/core/errors/failures.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class LocationRepository extends BaseRepository implements ILocationRepository {
  LocationRepository() {
    configureDio(Get.find<Dio>());
  }

  @override
  Future<BioLocationResult> getLocation({required double latitude, required double longitude}) async {
    try {
      final String locationUrl = generateUrl(method: '/reverse', locationRequest: true);

      final response = await Get.find<Dio>().get(
        locationUrl,
        queryParameters: {
          'lat': latitude,
          'lon': longitude,
          'api_key': dotenv.env['GEO_API_KEY'],
        }
      );

      final Location location = BioLocationResponse.fromJson(response.data);
      return BioLocationResult.success(location);
    } catch (error) {
      return BioLocationResult.error(Failure(message: error.toString()));
    }
  }
}
