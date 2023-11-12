import 'package:futrah/models/error_model.dart';

class GetQuickBillModel {
  int? code;
  int? status;
  ErrorModel? errors;
  String? message;
  List<Data>? data;
  String? taxNumber;
  String? companyLogo;
  String? qr;
  String? qrView;
  String? qrBase64;
  

  GetQuickBillModel({
    this.code,
    this.status,
    this.errors,
    this.message,
    this.data,
    this.taxNumber,
    this.companyLogo,
    this.qr,
    this.qrView,
    this.qrBase64,
  });

  GetQuickBillModel.fromJson(Map<String, dynamic> json) {
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
    taxNumber = json['tax_number'];
    companyLogo = json['company_logo'];
    qr = json['qr'];
    qrView = json['qr_view'];
    qrBase64 = json['qr_base64'];
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
    data['tax_number'] = taxNumber;
    data['company_logo'] = companyLogo;
    data['qr'] = qr;
    data['qr_view'] = qrView;
    data['qr_base64'] = qrBase64;
    return data;
  }
}

class Data {
  int? id;
  int? companyId;
  String? name;
  int? price;
  int? tax;
  int? finalPrice;
  String? createdAt;
  String? updatedAt;
  Company? company;

  Data(
      {this.id,
      this.companyId,
      this.name,
      this.price,
      this.tax,
      this.finalPrice,
      this.createdAt,
      this.updatedAt,
      this.company});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['company_id'];
    name = json['name'];
    price = json['price'];
    tax = json['tax'];
    finalPrice = json['final_price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    company =
        json['company'] != null ? Company.fromJson(json['company']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['company_id'] = companyId;
    data['name'] = name;
    data['price'] = price;
    data['tax'] = tax;
    data['final_price'] = finalPrice;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (company != null) data['company'] = company!.toJson();
    return data;
  }
}

class Company {
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

  Company(
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

  Company.fromJson(Map<String, dynamic> json) {
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
