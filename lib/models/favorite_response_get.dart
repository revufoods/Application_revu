// To parse this JSON data, do
//
//     final favoriteResponseGet = favoriteResponseGetFromJson(jsonString);

import 'dart:convert';

FavoriteResponseGet favoriteResponseGetFromJson(String str) =>
    FavoriteResponseGet.fromJson(json.decode(str));

String favoriteResponseGetToJson(FavoriteResponseGet data) =>
    json.encode(data.toJson());

class FavoriteResponseGet {
  int status;
  String message;
  List<Favorite> data;

  FavoriteResponseGet({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FavoriteResponseGet.fromJson(Map<String, dynamic> json) =>
      FavoriteResponseGet(
        status: json["status"],
        message: json["message"],
        data:
            List<Favorite>.from(json["data"].map((x) => Favorite.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Favorite {
  String id;
  String businesse;
  Logo? logo;
  Branch branch;

  Favorite({
    required this.id,
    required this.businesse,
    this.logo,
    required this.branch,
  });
  get fullLogofavorite {
    if (logo?.url != null) return logo?.url;

    return 'https://static.vecteezy.com/system/resources/thumbnails/004/141/669/small/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg';
  }

  factory Favorite.fromJson(Map<String, dynamic> json) => Favorite(
        id: json["id"],
        businesse: json["businesse"],
        logo: Logo.fromJson(json["logo"] == null ? null : json["logo"]),
        branch: Branch.fromJson(json["branch"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "businesse": businesse,
        "logo": logo?.toJson(),
        "branch": branch.toJson(),
      };
}

class Branch {
  int number;
  String address;

  Branch({
    required this.number,
    required this.address,
  });

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        number: json["number"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "address": address,
      };
}

class Logo {
  String key;
  String url;

  Logo({
    required this.key,
    required this.url,
  });

  factory Logo.fromJson(Map<String, dynamic> json) => Logo(
        key: json["key"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "url": url,
      };
}
