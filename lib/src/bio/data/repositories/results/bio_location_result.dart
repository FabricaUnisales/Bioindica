import 'package:bioindica/src/bio/domain/entities/location.dart';
import 'package:bioindica/src/core/errors/failures.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bio_location_result.freezed.dart';

@freezed
class BioLocationResult with _$BioLocationResult {
  factory BioLocationResult.success(Location location) = Success;
  factory BioLocationResult.error(Failure failure) = Error;
}
