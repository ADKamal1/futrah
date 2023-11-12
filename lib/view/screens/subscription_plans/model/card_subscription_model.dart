import 'package:futrah/models/error_model.dart';

class CardSubscriptionModel {
  int? code;
  int? status;
  ErrorModel? errors;
  String? message;
  CardData? cardData;
  Data? data;

  CardSubscriptionModel(
      {this.code,
      this.status,
      this.errors,
      this.message,
      this.cardData,
      this.data});

  CardSubscriptionModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    errors =
        json['errors'] != null ? ErrorModel.fromJson(json['errors']) : null;
    message = json['message'];
    cardData =
        json['card_data'] != null ? CardData.fromJson(json['card_data']) : null;
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['status'] = status;
    errors != null ? data['errors'] : errors!.toJson();
    data['message'] = message;
    if (cardData != null) {
      data['card_data'] = cardData!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CardData {
  int? id;
  String? name;
  String? code;
  int? days;
  int? status;
  String? createdAt;
  String? updatedAt;

  CardData({
    this.id,
    this.name,
    this.code,
    this.days,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  CardData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    days = json['days'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    data['days'] = days;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  String? phone;
  int? subscribeId;
  String? subscriptionEndDate;
  String? createdAt;
  String? updatedAt;
  String? fireBaseId;
  String? address;
  String? taxNumber;
  int? taxRate;
  int? days;

  Data(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.subscribeId,
      this.subscriptionEndDate,
      this.createdAt,
      this.updatedAt,
      this.fireBaseId,
      this.address,
      this.taxNumber,
      this.taxRate,
      this.days});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    subscribeId = json['subscribe_id'];
    subscriptionEndDate = json['subscription_end_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fireBaseId = json['fire_base_id'];
    address = json['address'];
    taxNumber = json['tax_number'];
    taxRate = json['tax_rate'];
    days = json['days'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['subscribe_id'] = subscribeId;
    data['subscription_end_date'] = subscriptionEndDate;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['fire_base_id'] = fireBaseId;
    data['address'] = address;
    data['tax_number'] = taxNumber;
    data['tax_rate'] = taxRate;
    data['days'] = days;
    return data;
  }
}
