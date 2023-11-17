// To parse this JSON data, do
//
//     final getBranchMapResponse = getBranchMapResponseFromJson(jsonString);

import 'dart:convert';

GetBranchMapResponse getBranchMapResponseFromJson(String str) =>
    GetBranchMapResponse.fromJson(json.decode(str));

String getBranchMapResponseToJson(GetBranchMapResponse data) =>
    json.encode(data.toJson());

class GetBranchMapResponse {
  int status;
  String message;
  List<BranchMap> data;

  GetBranchMapResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetBranchMapResponse.fromJson(Map<String, dynamic> json) =>
      GetBranchMapResponse(
        status: json["status"],
        message: json["message"],
        data: List<BranchMap>.from(
            json["data"].map((x) => BranchMap.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class BranchMap {
  String id;
  String name;
  int number;
  List<double> coordinates;
  String phone;

  BranchMap({
    required this.id,
    required this.name,
    required this.number,
    required this.coordinates,
    required this.phone,
  });

  factory BranchMap.fromJson(Map<String, dynamic> json) => BranchMap(
        id: json["id"],
        name: json["name"],
        number: json["number"],
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x?.toDouble())),
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "number": number,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
        "phone": phone,
      };
}
