// ignore_for_file: overridden_fields

import 'package:chat_firebase/data/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDataModel extends UserData {
  @override
  final String? id;
  @override
  final String? name;
  @override
  final String? email;
  @override
  final String? photourl;
  @override
  final String? location;
  @override
  final String? fcmtoken;
  @override
  final Timestamp? addtime;

  UserDataModel({
    this.id,
    this.name,
    this.email,
    this.photourl,
    this.location,
    this.fcmtoken,
    this.addtime,
  }) : super(
          addtime: addtime,
          email: email,
          fcmtoken: fcmtoken,
          id: id,
          location: location,
          name: name,
          photourl: photourl,
        );

  factory UserDataModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserDataModel(
      id: data?['id'],
      name: data?['name'],
      email: data?['email'],
      photourl: data?['photourl'],
      location: data?['location'],
      fcmtoken: data?['fcmtoken'],
      addtime: data?['addtime'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
      if (name != null) "name": name,
      if (email != null) "email": email,
      if (photourl != null) "photourl": photourl,
      if (location != null) "location": location,
      if (fcmtoken != null) "fcmtoken": fcmtoken,
      if (addtime != null) "addtime": addtime,
    };
  }
}

class UserLoginResponseEntityModel extends UserLoginResponseEntity {
  @override
  String? accessToken;
  @override
  String? displayName;
  @override
  String? email;
  @override
  String? photoUrl;

  UserLoginResponseEntityModel({
    this.accessToken,
    this.displayName,
    this.email,
    this.photoUrl,
  });

  factory UserLoginResponseEntityModel.fromJson(Map<String, dynamic> json) =>
      UserLoginResponseEntityModel(
        accessToken: json["access_token"],
        displayName: json["display_name"],
        email: json["email"],
        photoUrl: json["photoUrl"],
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "display_name": displayName,
        "email": email,
        "photoUrl": photoUrl,
      };
}

class MeListItemModel extends MeListItem {
  @override
  String? name;
  @override
  String? icon;
  @override
  String? explain;
  @override
  String? route;

  MeListItemModel({
    this.name,
    this.icon,
    this.explain,
    this.route,
  }) : super(
          explain: explain,
          icon: icon,
          name: name,
          route: route,
        );

  factory MeListItemModel.fromJson(Map<String, dynamic> json) =>
      MeListItemModel(
        name: json["name"],
        icon: json["icon"],
        explain: json["explain"],
        route: json["route"],
      );
}
