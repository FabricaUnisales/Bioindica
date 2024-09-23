import 'package:equatable/equatable.dart';
import 'package:utm/utm.dart';

///Localização em que o ser vivo foi encontrado
class Location extends Equatable {
  final UtmCoordinate utmCoordinates;
  final String? address;
  final String city;
  final String state;
  final String country;

  const Location({
    required this.utmCoordinates,
    this.address,
    required this.city,
    required this.state,
    required this.country,
  });

  Location copyWith({
    UtmCoordinate? utmCoordinates,
    String? address,
    String? city,
    String? state,
    String? country,
  }) {
    return Location(
      utmCoordinates: utmCoordinates ?? this.utmCoordinates,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
    );
  }

    @override
  List<Object?> get props =>[utmCoordinates, address, city, state, country];
}
