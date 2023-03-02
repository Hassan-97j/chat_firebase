abstract class SendNotificationRepo {
  Future<String?> sendPushNOtification(String token,String body, String title);
}
