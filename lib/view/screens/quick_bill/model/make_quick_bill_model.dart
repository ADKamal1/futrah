import 'package:futrah/models/error_model.dart';

class MakeQuickBillModel {
  int? code;
  int? status;
  ErrorModel? errors;
  String? message;
  Data? data;

  MakeQuickBillModel(
      {this.code, this.status, this.errors, this.message, this.data});

  MakeQuickBillModel.fromJson(dynamic json) {
    code = json['code'];
    status = json['status'];
    errors =
        json['errors'] != null ? ErrorModel.fromJson(json['errors']) : null;
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['status'] = status;
    errors != null ? map['errors'] : errors!.toJson();
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

class Data {
  String? companyId;
  String? name;
  String? price;
  num? tax;
  num? finalPrice;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data({
    this.companyId,
    this.name,
    this.price,
    this.tax,
    this.finalPrice,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  Data.fromJson(dynamic json) {
    companyId = json['company_id'];
    name = json['name'];
    price = json['price'];
    tax = json['tax'];
    finalPrice = json['final_price'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['company_id'] = companyId;
    map['name'] = name;
    map['price'] = price;
    map['tax'] = tax;
    map['final_price'] = finalPrice;
    map['updated_at'] = updatedAt;
    map['created_at'] = createdAt;
    map['id'] = id;
    return map;
  }
}
