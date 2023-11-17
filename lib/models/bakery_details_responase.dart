// To parse this JSON data, do
//
//     final bakeryDetailsResponse = bakeryDetailsResponseFromJson(jsonString);

import 'dart:convert';

BakeryDetailsResponse bakeryDetailsResponseFromJson(String str) =>
    BakeryDetailsResponse.fromJson(json.decode(str));

String bakeryDetailsResponseToJson(BakeryDetailsResponse data) =>
    json.encode(data.toJson());

class BakeryDetailsResponse {
  int status;
  String message;
  BakeryAliado data;

  BakeryDetailsResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory BakeryDetailsResponse.fromJson(Map<String, dynamic> json) =>
      BakeryDetailsResponse(
        status: json["status"],
        message: json["message"],
        data: BakeryAliado.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class BakeryAliado {
  CoverPhoto? logo;
  CoverPhoto? coverPhoto;
  String name;
  String category;
  List<Branch> branches;
  String id;
  get fullCoverPhoto {
    if (coverPhoto?.url != null) return coverPhoto?.url;

    return 'https://static.vecteezy.com/system/resources/thumbnails/004/141/669/small/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg';
  }

  get fullLogo {
    if (logo?.url != null) return logo?.url;

    return 'https://static.vecteezy.com/system/resources/thumbnails/004/141/669/small/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg';
  }

  BakeryAliado({
    this.logo,
    this.coverPhoto,
    required this.name,
    required this.category,
    required this.branches,
    required this.id,
  });

  factory BakeryAliado.fromJson(Map<String, dynamic> json) => BakeryAliado(
        logo: CoverPhoto.fromJson(json["logo"]),
        coverPhoto: CoverPhoto.fromJson(json["cover_photo"]),
        name: json["name"],
        category: json["category"],
        branches:
            List<Branch>.from(json["branches"].map((x) => Branch.fromJson(x))),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "logo": logo?.toJson(),
        "cover_photo": coverPhoto?.toJson(),
        "name": name,
        "category": category,
        "branches": List<dynamic>.from(branches.map((x) => x.toJson())),
        "id": id,
      };
}

class Branch {
  int number;
  String address;
  List<double> coordinates;
  String phone;
  String id;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  Branch({
    required this.number,
    required this.address,
    required this.coordinates,
    required this.phone,
    required this.id,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        number: json["number"],
        address: json["address"],
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x?.toDouble())),
        phone: json["phone"],
        id: json["_id"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "address": address,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
        "phone": phone,
        "_id": id,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class CoverPhoto {
  String key;
  String url;

  CoverPhoto({
    required this.key,
    required this.url,
  });

  factory CoverPhoto.fromJson(Map<String, dynamic> json) => CoverPhoto(
        key: json["key"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "url": url,
      };
}
