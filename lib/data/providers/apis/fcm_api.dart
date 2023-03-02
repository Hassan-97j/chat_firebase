import 'dart:convert';

import '../networks/api_endpoint.dart';
import '../networks/api_provider.dart';
import '../networks/api_req_represent.dart';

class FCMAPI extends APIRequestRepresentable {
  Map<String, dynamic>? fcmBody;
  String? notifyToken;
  String? notifyBody;
  String? notifyTitle;
  String? secretKey;

  FCMAPI._({
    this.fcmBody,
    this.notifyBody,
    this.notifyTitle,
    this.notifyToken,
    this.secretKey,
  });

  FCMAPI.sendNotification(String token, String body, String title)
      : this._(
          notifyBody: body,
          notifyTitle: title,
          notifyToken: token,
        );

  @override
  get body => jsonEncode(
        {
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'Flutter_NOTIFICATION_CLICK',
            'status': 'done',
            'body': notifyBody,
            'title': notifyTitle,
          },
          'notification': <String, dynamic>{
            'title': notifyTitle,
            'body': notifyBody,
            'android_channel_id': 'xyz',
          },
          'to': notifyToken,
        },
      );

  @override
  String get endpoint => FCMAPIEndPoint.fcmURL;

  @override
  Map<String, String> get headers => {
        'Content-Type': 'application/json',
        'Authorization': 'key=${FCMAPIEndPoint.fcmKey}',
      };

  @override
  HTTPMethod get method {
    return HTTPMethod.post;
  }

  @override
  Map<String, dynamic> get urlParams => {};

  Future request() {
    return APIProvider.instance.request(this);
  }

  @override
  String get url => endpoint + path;

  @override
  String get path {
    return FCMAPIEndPoint.fcmMiddleWare + FCMAPIEndPoint.sendUrl;
  }
}
