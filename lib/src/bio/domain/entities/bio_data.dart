import 'dart:typed_data';

import 'package:bioindica/src/bio/data/enums/bio_state.dart';
import 'package:bioindica/src/bio/data/enums/fauna_or_flora.dart';
import 'package:bioindica/src/bio/domain/entities/location.dart';
import 'package:utm/utm.dart';

class BioData {
  final int userId;
  final Location localization;
  final List<Uint8List> photos;
  final FaunaOrFlora faunaOrFlora;
  final String specie;
  final String? latimName;
  final BioState? lifeStateInFauna; // Only for fauna
  final String? specieTypeInFlora; // Only for flora - Invasora, Endêmica, etc...
  final String? aproximatedAge;
  final RegisterInformation? registerInformation; // Only for flora - Nativa, Exótica, etc...
  final int quantityFound;
  final String observations;
  final DateTime createdAt;

  BioData({
    required this.userId,
    required this.localization,
    required this.photos,
    required this.faunaOrFlora,
    required this.specie,
    this.latimName,
    this.lifeStateInFauna,
    this.specieTypeInFlora,
    this.aproximatedAge,
    this.registerInformation,
    required this.quantityFound,
    required this.observations,
    required this.createdAt,
  });

  BioData.empty()
      : userId = 1, 
      localization = const Location(
        utmCoordinates: UtmCoordinate(0, 0, 0, 0, 0, 'Z'),
          address: '',
          city: '',
          state: '',
          country: '',
        ),
        photos = [],
        faunaOrFlora = FaunaOrFlora.fauna,
        specie = '',
        latimName = '',
        lifeStateInFauna = null,
        specieTypeInFlora = null,
        quantityFound = 1,
        aproximatedAge = null,
        registerInformation = null,
        observations = '',
        createdAt = DateTime.now();

  BioData copyWith({
    Location? localization,
    List<Uint8List>? photos,
    FaunaOrFlora? faunaOrFlora,
    String? specie,
    String? latimName,
    BioState? lifeStateInFauna,
    String? specieTypeInFlora,
    String? aproximatedAge,
    RegisterInformation? registerInformation,
    int? quantityFound,
    String? observations,
    DateTime? date,
  }) {
    return BioData(
      userId: userId,
      localization: localization ?? this.localization,
      photos: photos ?? this.photos,
      faunaOrFlora: faunaOrFlora ?? this.faunaOrFlora,
      specie: specie ?? this.specie,
      latimName: latimName ?? this.latimName,
      lifeStateInFauna: lifeStateInFauna ?? this.lifeStateInFauna,
      specieTypeInFlora: specieTypeInFlora ?? this.specieTypeInFlora,
      aproximatedAge: aproximatedAge ?? this.aproximatedAge,
      registerInformation: registerInformation ?? this.registerInformation,
      quantityFound: quantityFound ?? this.quantityFound,
      observations: observations ?? this.observations,
      createdAt: date ?? this.createdAt,
    );
  }
}
