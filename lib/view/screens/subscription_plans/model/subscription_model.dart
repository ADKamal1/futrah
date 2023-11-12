import 'package:futrah/models/error_model.dart';

class SubscriptionModel {
  int? code;
  int? status;
  ErrorModel? errors;
  String? message;
  List<Data>? data;

  SubscriptionModel({
    this.code,
    this.status,
    this.errors,
    this.message,
    this.data,
  });

  SubscriptionModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    errors =
        json['errors'] != null ? ErrorModel.fromJson(json['errors']) : null;
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['status'] = status;
    errors != null ? data['errors'] : errors!.toJson();
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? days;
  String? name;
  int? price;

  Data({
    this.id,
    this.days,
    this.name,
    this.price,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    days = json['days'];
    name = json['name'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['days'] = days;
    data['name'] = name;
    data['price'] = price;
    return data;
  }
}
