///Life state of the animal or plant
enum BioState {
  vivo,
  doenteFerido,
  morto,
  vestigio
}

extension BioStateExtension on BioState {
  String get value {
    switch (this) {
      case BioState.vivo:
        return 'Vivo';
      case BioState.morto:
        return 'Morto';
      case BioState.doenteFerido:
        return 'Doente/Ferido';
      case BioState.vestigio:
        return 'Vestígio';
    }
  }
}

enum VestigioType {
  pegadas,
  fezes,
  carcaca,
  outros
}

extension VestigioStateExtension on VestigioType {
  String get value {
    switch (this) {
      case VestigioType.pegadas:
        return 'Pegadas';
      case VestigioType.fezes:
        return 'Fezes';
      case VestigioType.carcaca:
        return 'Carcaça';
      case VestigioType.outros:
        return 'Outros';
    }
  }
}

enum RegisterInformation {
  nativa,
  exotica,
  desconhecida //não sei
}

extension InformacoesRegistroExtension on RegisterInformation {
  String get value {
    switch (this) {
      case RegisterInformation.nativa:
        return 'Nativa';
      case RegisterInformation.exotica:
        return 'Exótica';
      case RegisterInformation.desconhecida:
        return 'Desconhecida';
    }
  }
}

enum Porte {
  arboreo,
  arbusto,
  herbaceo,
}

extension PorteExtension on Porte {
  String get value {
    switch (this) {
      case Porte.arboreo:
        return 'Arbóreo';
      case Porte.arbusto:
        return 'Arbusto';
      case Porte.herbaceo:
        return 'Herbáceo';
    }
  }
}
