// To parse this JSON data, do
//
//     final supermarketResponse = supermarketResponseFromJson(jsonString);

import 'dart:convert';

SupermarketResponse supermarketResponseFromJson(String str) =>
    SupermarketResponse.fromJson(json.decode(str));

String supermarketResponseToJson(SupermarketResponse data) =>
    json.encode(data.toJson());

class SupermarketResponse {
  int status;
  String message;
  List<Supermarket> data;

  SupermarketResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SupermarketResponse.fromJson(Map<String, dynamic> json) =>
      SupermarketResponse(
        status: json["status"],
        message: json["message"],
        data: List<Supermarket>.from(
            json["data"].map((x) => Supermarket.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Supermarket {
  String id;
  String name;
  String category;
  CoverPhoto? logo;
  CoverPhoto? coverPhoto;
  Branch branch;
  get fullCoverPhoto {
    if (coverPhoto?.url != null) return coverPhoto?.url;

    return 'https://static.vecteezy.com/system/resources/thumbnails/004/141/669/small/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg';
  }

  get fullLogo {
    if (logo?.url != null) return logo?.url;

    return 'https://static.vecteezy.com/system/resources/thumbnails/004/141/669/small/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg';
  }

  Supermarket({
    required this.id,
    required this.name,
    required this.category,
    this.logo,
    this.coverPhoto,
    required this.branch,
  });

  factory Supermarket.fromJson(Map<String, dynamic> json) => Supermarket(
        id: json["id"],
        name: json["name"],
        category: json["category"],
        logo: CoverPhoto.fromJson(json["logo"] == null ? null : json["logo"]),
        coverPhoto: CoverPhoto.fromJson(
            json["cover_photo"] == null ? null : json["cover_photo"]),
        branch: Branch.fromJson(json["branch"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category": category,
        "logo": logo?.toJson(),
        "cover_photo": coverPhoto?.toJson(),
        "branch": branch.toJson(),
      };
}

class Branch {
  String id;
  int number;
  String address;
  String phone;
  List<double> coordinates;

  Branch({
    required this.id,
    required this.number,
    required this.address,
    required this.phone,
    required this.coordinates,
  });

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        id: json["id"],
        number: json["number"],
        address: json["address"],
        phone: json["phone"],
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x?.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "number": number,
        "address": address,
        "phone": phone,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
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
