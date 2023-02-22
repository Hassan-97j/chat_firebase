import '../../../domain/interface/my_location_model.dart';

abstract class MapsRepo {
  Future<MyLocationModel> getLocation(String address);
}
