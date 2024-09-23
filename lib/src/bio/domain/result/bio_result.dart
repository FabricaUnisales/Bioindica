import 'package:bioindica/src/core/errors/failures.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bio_result.freezed.dart';

@freezed
class BioResult<T> with _$BioResult<T> {
  factory BioResult.success(T data) = Success;
  factory BioResult.failure(Failure failure) = Error;
}