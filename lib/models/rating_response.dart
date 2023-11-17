// To parse this JSON data, do
//
//     final ratingResponse = ratingResponseFromJson(jsonString);

import 'dart:convert';

RatingResponse ratingResponseFromJson(String str) =>
    RatingResponse.fromJson(json.decode(str));

String ratingResponseToJson(RatingResponse data) => json.encode(data.toJson());

class RatingResponse {
  int status;
  String message;
  Data data;

  RatingResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory RatingResponse.fromJson(Map<String, dynamic> json) => RatingResponse(
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
  String businesse;
  String branch;
  String user;
  double rating;
  String comment;
  bool status;
  DateTime createdAt;
  DateTime updatedAt;
  String id;

  Data({
    required this.businesse,
    required this.branch,
    required this.user,
    required this.rating,
    required this.comment,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        businesse: json["businesse"],
        branch: json["branch"],
        user: json["user"],
        rating: json["rating"]?.toDouble(),
        comment: json["comment"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "businesse": businesse,
        "branch": branch,
        "user": user,
        "rating": rating,
        "comment": comment,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "id": id,
      };
}
