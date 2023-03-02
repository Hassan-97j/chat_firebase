import '../networks/api_endpoint.dart';
import '../networks/api_provider.dart';
import '../networks/api_req_represent.dart';

class GoogleMapAPI extends APIRequestRepresentable {
  Map<String, dynamic>? loginBody;
  String? address;
  String? secretKey;

  GoogleMapAPI._({
    this.loginBody,
    this.address,
    this.secretKey,
  });

  GoogleMapAPI.fetchLocation(String address)
      : this._(
          address: address,
        );

  @override
  get body {
    return {};
  }

  @override
  String get endpoint => GoogleMApsAPIEndpoint.mapsURl;

  @override
  Map<String, String> get headers => {};

  @override
  HTTPMethod get method {
    return HTTPMethod.get;
  }

  @override
  Map<String, dynamic> get urlParams => {
        "address": address,
        "key": GoogleMApsAPIEndpoint.mapsKey,
      };

  Future request() {
    return APIProvider.instance.request(this);
  }

  @override
  String get url => endpoint + path;

  @override
  String get path {
    return GoogleMApsAPIEndpoint.mapsMiddleWare +
        GoogleMApsAPIEndpoint.geocodeUrl;
  }
}
