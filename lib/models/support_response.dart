// To parse this JSON data, do
//
//     final supportResponse = supportResponseFromJson(jsonString);

import 'dart:convert';

SupportResponse supportResponseFromJson(String str) =>
    SupportResponse.fromJson(json.decode(str));

String supportResponseToJson(SupportResponse data) =>
    json.encode(data.toJson());

class SupportResponse {
  int status;
  String message;
  Data data;

  SupportResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SupportResponse.fromJson(Map<String, dynamic> json) =>
      SupportResponse(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  String question;
  String createdBy;
  bool isAnswered;
  bool status;
  DateTime createdAt;
  DateTime updatedAt;
  String id;

  Data({
    required this.question,
    required this.createdBy,
    required this.isAnswered,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        question: json["question"],
        createdBy: json["created_by"],
        isAnswered: json["is_answered"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "question": question,
        "created_by": createdBy,
        "is_answered": isAnswered,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "id": id,
      };
}
