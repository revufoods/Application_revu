// To parse this JSON data, do
//
//     final userPutResponse = userPutResponseFromJson(jsonString);

import 'dart:convert';

UserPutResponse userPutResponseFromJson(String str) =>
    UserPutResponse.fromJson(json.decode(str));

String userPutResponseToJson(UserPutResponse data) =>
    json.encode(data.toJson());

class UserPutResponse {
  int status;
  String message;

  UserPutResponse({
    required this.status,
    required this.message,
  });

  factory UserPutResponse.fromJson(Map<String, dynamic> json) =>
      UserPutResponse(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
