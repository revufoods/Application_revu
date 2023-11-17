// To parse this JSON data, do
//
//     final favoriteResponse = favoriteResponseFromJson(jsonString);

import 'dart:convert';

FavoriteResponse favoriteResponseFromJson(String str) =>
    FavoriteResponse.fromJson(json.decode(str));

String favoriteResponseToJson(FavoriteResponse data) =>
    json.encode(data.toJson());

class FavoriteResponse {
  int status;
  String message;

  FavoriteResponse({
    required this.status,
    required this.message,
  });

  factory FavoriteResponse.fromJson(Map<String, dynamic> json) =>
      FavoriteResponse(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
