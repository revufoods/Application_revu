// To parse this JSON data, do
//
//     final registerResponse = registerResponseFromJson(jsonString);

import 'dart:convert';

RegisterResponse registerResponseFromJson(String str) =>
    RegisterResponse.fromJson(json.decode(str));

String registerResponseToJson(RegisterResponse data) =>
    json.encode(data.toJson());

class RegisterResponse {
  int status;
  String message;
  Data data;

  RegisterResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      RegisterResponse(
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
  String names;
  String lastNames;
  String email;
  String cellphone;
  bool status;
  String role;
  DateTime createdAt;
  DateTime updatedAt;
  String id;

  Data({
    required this.names,
    required this.lastNames,
    required this.email,
    required this.cellphone,
    required this.status,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    required this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        names: json["names"],
        lastNames: json["last_names"],
        email: json["email"],
        cellphone: json["cellphone"],
        status: json["status"],
        role: json["role"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "names": names,
        "last_names": lastNames,
        "email": email,
        "cellphone": cellphone,
        "status": status,
        "role": role,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "id": id,
      };
}
