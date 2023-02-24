import 'dart:convert';

import 'package:chat_firebase/data/repositories/http_repo/maps_repo.dart';

import '../../../data/providers/apis/google_maps_api.dart';
import '../../interface/my_location_model.dart';

class MapsRepoImpl implements MapsRepo {
  @override
  Future<String> getLocation(String address) async {
    try {
      final response = await GoogleMapAPI.fetchLocation(address).request();
      MyLocationModel locModel =
          MyLocationModel.fromJson(json.decode(response));
      return locModel.results!.first.formattedAddress!;
    } catch (e) {
      // ignore: avoid_print
      print('repo exception: $e');
      rethrow;
    }
  }
}
