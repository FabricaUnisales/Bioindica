import 'package:bioindica/src/bio/domain/entities/location.dart';
import 'package:utm/utm.dart';

class BioLocationResponse extends Location {
  const BioLocationResponse({
    required super.utmCoordinates,
    required super.address,
    required super.city,
    required super.state,
    required super.country,
  });

  factory BioLocationResponse.fromJson(Map<String, dynamic> json) {
    return BioLocationResponse(
      utmCoordinates: UTM.fromLatLon(lat: double.parse(json['lat']), lon: double.parse(json['lon'])),
      address: json['address']['road'],
      city: json['address']['city'],
      state: json['address']['state'],
      country: json['address']['country'],
    );
  }
}

