// ignore_for_file: overridden_fields, prefer_null_aware_operators

import 'dart:convert';

import 'package:chat_firebase/data/models/mylocation.dart';

MyLocationModel locationFromJson(String str) =>
    MyLocationModel.fromJson(json.decode(str));

String locationToJson(MyLocationModel data) => json.encode(data.toJson());

class MyLocationModel extends MyLocation {
  MyLocationModel({
    this.results,
    this.status,
  }) : super(
          results: results,
          status: status,
        );

  @override
  final List<ResultModel>? results;
  @override
  final String? status;

  factory MyLocationModel.fromJson(Map<String, dynamic> json) =>
      MyLocationModel(
        results: json["results"] == null
            ? null
            : List<ResultModel>.from(
                json["results"].map((x) => ResultModel.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "results": results == null
            ? null
            : List<dynamic>.from(results!.map((x) => x.toJson())),
        "status": status,
      };
}

class ResultModel extends Result {
  ResultModel({
    this.addressComponents,
    this.formattedAddress,
    this.geometry,
    this.placeId,
    this.types,
  }) : super(
          addressComponents: addressComponents,
          formattedAddress: formattedAddress,
          geometry: geometry,
          placeId: placeId,
          types: types,
        );

  @override
  final List<AddressComponentModel>? addressComponents;
  @override
  final String? formattedAddress;
  @override
  final GeometryModel? geometry;
  @override
  final String? placeId;
  @override
  final List<String>? types;

  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
        addressComponents: json["address_components"] == null
            ? null
            : List<AddressComponentModel>.from(json["address_components"]
                .map((x) => AddressComponentModel.fromJson(x))),
        formattedAddress: json["formatted_address"],
        geometry: json["geometry"] == null
            ? null
            : GeometryModel.fromJson(json["geometry"]),
        placeId: json["place_id"],
        types: json["types"] == null
            ? null
            : List<String>.from(json["types"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "address_components": addressComponents == null
            ? null
            : List<dynamic>.from(addressComponents!.map((x) => x.toJson())),
        "formatted_address": formattedAddress,
        "geometry": geometry == null ? null : geometry!.toJson(),
        "place_id": placeId,
        "types":
            types == null ? null : List<dynamic>.from(types!.map((x) => x)),
      };
}

class AddressComponentModel extends AddressComponent {
  AddressComponentModel({
    this.longName,
    this.shortName,
    this.types,
  }) : super(
          longName: longName,
          shortName: shortName,
          types: types,
        );

  @override
  final String? longName;
  @override
  final String? shortName;
  @override
  final List<String>? types;

  factory AddressComponentModel.fromJson(Map<String, dynamic> json) =>
      AddressComponentModel(
        longName: json["long_name"],
        shortName: json["short_name"],
        types: json["types"] == null
            ? null
            : List<String>.from(json["types"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "long_name": longName,
        "short_name": shortName,
        "types":
            types == null ? null : List<dynamic>.from(types!.map((x) => x)),
      };
}

class GeometryModel extends Geometry {
  GeometryModel({
    this.location,
    this.locationType,
    this.viewport,
    this.bounds,
  }) : super(
          bounds: bounds,
          location: location,
          locationType: locationType,
          viewport: viewport,
        );

  @override
  final MyLocationClassModel? location;
  @override
  final String? locationType;
  @override
  final BoundsModel? viewport;
  @override
  final BoundsModel? bounds;

  factory GeometryModel.fromJson(Map<String, dynamic> json) => GeometryModel(
        location: json["location"] == null
            ? null
            : MyLocationClassModel.fromJson(json["location"]),
        locationType: json["location_type"],
        viewport: json["viewport"] == null
            ? null
            : BoundsModel.fromJson(json["viewport"]),
        bounds: json["bounds"] == null
            ? null
            : BoundsModel.fromJson(json["bounds"]),
      );

  Map<String, dynamic> toJson() => {
        "location": location == null ? null : location!.toJson(),
        "location_type": locationType,
        "viewport": viewport == null ? null : viewport!.toJson(),
        "bounds": bounds == null ? null : bounds!.toJson(),
      };
}

class BoundsModel extends Bounds {
  BoundsModel({
    this.northeast,
    this.southwest,
  }) : super(
          northeast: northeast,
          southwest: southwest,
        );

  @override
  final MyLocationClassModel? northeast;
  @override
  final MyLocationClassModel? southwest;

  factory BoundsModel.fromJson(Map<String, dynamic> json) => BoundsModel(
        northeast: json["northeast"] == null
            ? null
            : MyLocationClassModel.fromJson(json["northeast"]),
        southwest: json["southwest"] == null
            ? null
            : MyLocationClassModel.fromJson(json["southwest"]),
      );

  Map<String, dynamic> toJson() => {
        "northeast": northeast == null ? null : northeast!.toJson(),
        "southwest": southwest == null ? null : southwest!.toJson(),
      };
}

class MyLocationClassModel extends MyLocationClass {
  MyLocationClassModel({
    this.lat,
    this.lng,
  }) : super(lat: lat, lng: lng);

  @override
  final double? lat;
  @override
  final double? lng;

  factory MyLocationClassModel.fromJson(Map<String, dynamic> json) =>
      MyLocationClassModel(

        lat: json["lat"] == null ? null : json["lat"].toDouble(),
        lng: json["lng"] == null ? null : json["lng"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };
}
