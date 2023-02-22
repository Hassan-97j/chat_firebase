
// ignore_for_file: overridden_fields

import '../../data/models/gen_res.dart';

class GenResponseModel extends GenResponse {
  GenResponseModel({this.msg, this.success, this.id, this.error})
      : super(msg: msg, success: success, id: id, error: error);

  @override
  String? msg;
  @override
  String? error;
  @override
  int? id;
  @override
  bool? success;

  factory GenResponseModel.fromJson(Map<String, dynamic>? json) {
    return GenResponseModel(
      msg: json?['message'] as String?,
      success: json?['success'] as bool?,
      id: json?['id'],
      error: json?['error'],
    );
  }
}