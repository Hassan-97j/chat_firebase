import 'package:location/location.dart';

import '../../data/repositories/location_repo.dart';

class LocationRepoImpl implements LocationRepo {
  @override
  Future<String> getLocationAddress() async {
    final location = await Location().getLocation();
    String address = "${location.latitude}, ${location.longitude}";
    return address;
  }
}
