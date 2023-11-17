// To parse this JSON data, do
//
//     final adminSupportResponse = adminSupportResponseFromJson(jsonString);

import 'dart:convert';

AdminSupportResponse adminSupportResponseFromJson(String str) =>
    AdminSupportResponse.fromJson(json.decode(str));

String adminSupportResponseToJson(AdminSupportResponse data) =>
    json.encode(data.toJson());

class AdminSupportResponse {
  int status;
  String message;
  List<Support> data;

  AdminSupportResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AdminSupportResponse.fromJson(Map<String, dynamic> json) =>
      AdminSupportResponse(
        status: json["status"],
        message: json["message"],
        data: List<Support>.from(json["data"].map((x) => Support.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Support {
  String question;
  String createdBy;
  bool isAnswered;
  bool status;
  DateTime createdAt;
  DateTime updatedAt;
  String id;
  String? answer;
  AnsweredBy? answeredBy;

  Support({
    required this.question,
    required this.createdBy,
    required this.isAnswered,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    this.answer,
    this.answeredBy,
  });

  factory Support.fromJson(Map<String, dynamic> json) => Support(
        question: json["question"],
        createdBy: json["created_by"],
        isAnswered: json["is_answered"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        id: json["id"],
        answer: json["answer"],
        answeredBy: json["answered_by"] == null
            ? null
            : AnsweredBy.fromJson(json["answered_by"]),
      );

  Map<String, dynamic> toJson() => {
        "question": question,
        "created_by": createdBy,
        "is_answered": isAnswered,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "id": id,
        "answer": answer,
        "answered_by": answeredBy?.toJson(),
      };
}

class AnsweredBy {
  String names;
  String lastNames;
  String role;
  String id;

  AnsweredBy({
    required this.names,
    required this.lastNames,
    required this.role,
    required this.id,
  });

  factory AnsweredBy.fromJson(Map<String, dynamic> json) => AnsweredBy(
        names: json["names"],
        lastNames: json["last_names"],
        role: json["role"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "names": names,
        "last_names": lastNames,
        "role": role,
        "id": id,
      };
}
