// To parse this JSON data, do
//
//     final payResponse = payResponseFromJson(jsonString);

import 'dart:convert';

PayResponse payResponseFromJson(String str) =>
    PayResponse.fromJson(json.decode(str));

String payResponseToJson(PayResponse data) => json.encode(data.toJson());

class PayResponse {
  int status;
  String message;
  Data data;

  PayResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory PayResponse.fromJson(Map<String, dynamic> json) => PayResponse(
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
  String user;
  List<Product> products;
  Detail detail;
  Distribution distribution;
  DateTime createdAt;
  DateTime updatedAt;
  String id;

  Data({
    required this.user,
    required this.products,
    required this.detail,
    required this.distribution,
    required this.createdAt,
    required this.updatedAt,
    required this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: json["user"],
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
        detail: Detail.fromJson(json["detail"]),
        distribution: Distribution.fromJson(json["distribution"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "detail": detail.toJson(),
        "distribution": distribution.toJson(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "id": id,
      };
}

class Detail {
  int subtotal;
  PaymentGateway tax;
  PaymentGateway paymentGateway;
  double total;

  Detail({
    required this.subtotal,
    required this.tax,
    required this.paymentGateway,
    required this.total,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        subtotal: json["subtotal"],
        tax: PaymentGateway.fromJson(json["tax"]),
        paymentGateway: PaymentGateway.fromJson(json["payment_gateway"]),
        total: json["total"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "subtotal": subtotal,
        "tax": tax.toJson(),
        "payment_gateway": paymentGateway.toJson(),
        "total": total,
      };
}

class PaymentGateway {
  int percentage;
  double value;

  PaymentGateway({
    required this.percentage,
    required this.value,
  });

  factory PaymentGateway.fromJson(Map<String, dynamic> json) => PaymentGateway(
        percentage: json["percentage"],
        value: json["value"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "percentage": percentage,
        "value": value,
      };
}

class Distribution {
  Businesse businesse;
  PaymentGateway company;
  PaymentGateway tax;
  PaymentGateway paymentGateway;

  Distribution({
    required this.businesse,
    required this.company,
    required this.tax,
    required this.paymentGateway,
  });

  factory Distribution.fromJson(Map<String, dynamic> json) => Distribution(
        businesse: Businesse.fromJson(json["businesse"]),
        company: PaymentGateway.fromJson(json["company"]),
        tax: PaymentGateway.fromJson(json["tax"]),
        paymentGateway: PaymentGateway.fromJson(json["payment_gateway"]),
      );

  Map<String, dynamic> toJson() => {
        "businesse": businesse.toJson(),
        "company": company.toJson(),
        "tax": tax.toJson(),
        "payment_gateway": paymentGateway.toJson(),
      };
}

class Businesse {
  int percentage;
  int value;
  List<Branch> branches;

  Businesse({
    required this.percentage,
    required this.value,
    required this.branches,
  });

  factory Businesse.fromJson(Map<String, dynamic> json) => Businesse(
        percentage: json["percentage"],
        value: json["value"],
        branches:
            List<Branch>.from(json["branches"].map((x) => Branch.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "percentage": percentage,
        "value": value,
        "branches": List<dynamic>.from(branches.map((x) => x.toJson())),
      };
}

class Branch {
  String revuSurprise;
  int value;
  String id;

  Branch({
    required this.revuSurprise,
    required this.value,
    required this.id,
  });

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        revuSurprise: json["revu_surprise"],
        value: json["value"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "revu_surprise": revuSurprise,
        "value": value,
        "id": id,
      };
}

class Product {
  String revuSurprise;
  int price;
  int amount;
  int total;
  String id;

  Product({
    required this.revuSurprise,
    required this.price,
    required this.amount,
    required this.total,
    required this.id,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        revuSurprise: json["revu_surprise"],
        price: json["price"],
        amount: json["amount"],
        total: json["total"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "revu_surprise": revuSurprise,
        "price": price,
        "amount": amount,
        "total": total,
        "id": id,
      };
}
