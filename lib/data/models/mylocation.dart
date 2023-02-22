class MyLocation {
  MyLocation({
    this.results,
    this.status,
  });

  final List<Result>? results;
  final String? status;
}

class Result {
  Result({
    this.addressComponents,
    this.formattedAddress,
    this.geometry,
    this.placeId,
    this.types,
  });

  final List<AddressComponent>? addressComponents;
  final String? formattedAddress;
  final Geometry? geometry;
  final String? placeId;
  final List<String>? types;
}

class AddressComponent {
  AddressComponent({
    this.longName,
    this.shortName,
    this.types,
  });

  final String? longName;
  final String? shortName;
  final List<String>? types;
}

class Geometry {
  Geometry({
    this.location,
    this.locationType,
    this.viewport,
    this.bounds,
  });

  final MyLocationClass? location;
  final String? locationType;
  final Bounds? viewport;
  final Bounds? bounds;
}

class Bounds {
  Bounds({
    this.northeast,
    this.southwest,
  });

  final MyLocationClass? northeast;
  final MyLocationClass? southwest;
}

class MyLocationClass {
  MyLocationClass({
    this.lat,
    this.lng,
  });

  final double? lat;
  final double? lng;
}
