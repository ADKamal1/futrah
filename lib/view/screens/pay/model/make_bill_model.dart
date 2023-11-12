import 'package:futrah/models/error_model.dart';

class MakeBillsModel {
  int? code;
  int? status;
  ErrorModel? errors;
  String? message;
  Data? data;

  MakeBillsModel(
      {this.code, this.status, this.errors, this.message, this.data});

  MakeBillsModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    errors =
        json['errors'] != null ? ErrorModel.fromJson(json['errors']) : null;
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['status'] = status;
    data['message'] = message;
    errors != null ? data['errors'] : errors!.toJson();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? companyId;
  String? clientId;
  num? taxAmount;
  num? finalPrice;
  String? updatedAt;
  String? createdAt;
  String? paymentType;
  int? id;
  num? priceBeforeTax;
  List<Products>? products;
  Company? company;

  Data({
    this.companyId,
    this.clientId,
    this.taxAmount,
    this.finalPrice,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.priceBeforeTax,
    this.products,
    this.company,
    this.paymentType,
  });

  Data.fromJson(Map<String, dynamic> json) {
    companyId = json['company_id'];
    clientId = json['client_id'];
    paymentType = json['payment_type'];
    taxAmount = json['tax_amount'];
    finalPrice = json['final_price'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    priceBeforeTax = json['price_before_tax'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
    company =
        json['company'] != null ? Company.fromJson(json['company']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['company_id'] = companyId;
    data['payment_type'] = paymentType;
    data['client_id'] = clientId;
    data['tax_amount'] = taxAmount;
    data['final_price'] = finalPrice;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    data['price_before_tax'] = priceBeforeTax;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    if (company != null) {
      data['company'] = company!.toJson();
    }
    return data;
  }
}

class Products {
  int? id;
  int? categoryId;
  String? createdAt;
  String? updatedAt;
  String? title;
  int? optionalPrice;
  int? price;
  int? isTax;
  Pivot? pivot;

  Products(
      {this.id,
      this.categoryId,
      this.createdAt,
      this.updatedAt,
      this.title,
      this.optionalPrice,
      this.price,
      this.isTax,
      this.pivot});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    title = json['title'];
    optionalPrice = json['optional_price'];
    price = json['price'];
    isTax = json['is_tax'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category_id'] = categoryId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['title'] = title;
    data['optional_price'] = optionalPrice;
    data['price'] = price;
    data['is_tax'] = isTax;
    if (pivot != null) {
      data['pivot'] = pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  int? billId;
  int? productId;

  Pivot({this.billId, this.productId});

  Pivot.fromJson(Map<String, dynamic> json) {
    billId = json['bill_id'];
    productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bill_id'] = billId;
    data['product_id'] = productId;
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
      this.taxRate});

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
    return data;
  }
}
