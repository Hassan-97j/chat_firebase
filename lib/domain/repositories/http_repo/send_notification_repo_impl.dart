import 'package:chat_firebase/data/repositories/http_repo/send_notification_repo.dart';

class SendNotificationRepoImpl implements SendNotificationRepo {
  @override
  Future<String?> sendPushNOtification(
      String token, String body, String title) async {
    throw UnimplementedError();
  }
}
