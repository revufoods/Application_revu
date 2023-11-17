// To parse this JSON data, do
//
//     final usuarioResponse = usuarioResponseFromJson(jsonString);

import 'dart:convert';

UsuarioResponse usuarioResponseFromJson(String str) =>
    UsuarioResponse.fromJson(json.decode(str));

String usuarioResponseToJson(UsuarioResponse data) =>
    json.encode(data.toJson());

class UsuarioResponse {
  int status;
  String message;
  Usuario data;

  UsuarioResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UsuarioResponse.fromJson(Map<String, dynamic> json) =>
      UsuarioResponse(
        status: json["status"],
        message: json["message"],
        data: Usuario.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Usuario {
  String names;
  String lastNames;
  String email;
  String cellphone;
  bool status;
  String role;
  DateTime createdAt;
  DateTime updatedAt;
  String id;

  Usuario({
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

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
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
