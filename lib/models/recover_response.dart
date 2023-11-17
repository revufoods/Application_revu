// To parse this JSON data, do
//
//     final recoverResponse = recoverResponseFromJson(jsonString);

import 'dart:convert';

RecoverResponse recoverResponseFromJson(String str) =>
    RecoverResponse.fromJson(json.decode(str));

String recoverResponseToJson(RecoverResponse data) =>
    json.encode(data.toJson());

class RecoverResponse {
  int status;
  String message;

  RecoverResponse({
    required this.status,
    required this.message,
  });

  factory RecoverResponse.fromJson(Map<String, dynamic> json) =>
      RecoverResponse(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
