// To parse this JSON data, do
//
//     final revuSopresaResponse = revuSopresaResponseFromJson(jsonString);

import 'dart:convert';

RevuSopresaResponse revuSopresaResponseFromJson(String str) =>
    RevuSopresaResponse.fromJson(json.decode(str));

String revuSopresaResponseToJson(RevuSopresaResponse data) =>
    json.encode(data.toJson());

class RevuSopresaResponse {
  int status;
  String message;
  RevuSopresa data;

  RevuSopresaResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory RevuSopresaResponse.fromJson(Map<String, dynamic> json) =>
      RevuSopresaResponse(
        status: json["status"],
        message: json["message"],
        data: RevuSopresa.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class RevuSopresa {
  String businesse;
  String branch;
  int price;
  int amount;
  String description;
  String startPickupTime;
  String endPickupTime;
  List<Images>? images;
  bool status;
  DateTime createdAt;
  DateTime updatedAt;
  double revuPrice;
  String id;

  RevuSopresa({
    required this.businesse,
    required this.branch,
    required this.price,
    required this.amount,
    required this.description,
    required this.startPickupTime,
    required this.endPickupTime,
    this.images,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.revuPrice,
    required this.id,
  });

  factory RevuSopresa.fromJson(Map<String, dynamic> json) => RevuSopresa(
        businesse: json["businesse"],
        branch: json["branch"],
        price: json["price"],
        amount: json["amount"],
        description: json["description"],
        startPickupTime: json["start_pickup_time"],
        endPickupTime: json["end_pickup_time"],
        images:
            List<Images>.from(json["images"].map((x) => Images.fromJson(x))),
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        revuPrice: json["revu_price"]?.toDouble(),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "businesse": businesse,
        "branch": branch,
        "price": price,
        "amount": amount,
        "description": description,
        "start_pickup_time": startPickupTime,
        "end_pickup_time": endPickupTime,
        "images": List<dynamic>.from(images!.map((x) => x.toJson())),
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "revu_price": revuPrice,
        "id": id,
      };
}

class Images {
  String key;
  String url;
  String id;

  Images({
    required this.key,
    required this.url,
    required this.id,
  });

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        key: json["key"],
        url: json["url"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "url": url,
        "_id": id,
      };
}
