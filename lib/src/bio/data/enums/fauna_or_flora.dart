enum FaunaOrFlora {
  fauna,
  flora,
}

extension FaunaOrFloraExtension on FaunaOrFlora {
  String get value {
    switch (this) {
      case FaunaOrFlora.fauna:
        return 'Fauna';
      case FaunaOrFlora.flora:
        return 'Flora';
    }
  }
}