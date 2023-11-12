import 'package:futrah/models/error_model.dart';

class SingleBillModel {
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
  

  SingleBillModel({
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

  SingleBillModel.fromJson(Map<String, dynamic> json) {
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
  int? clientId;
  int? companyId;
  int? finalPrice;
  int? taxAmount;
  String? paymentType;
  String? createdAt;
  String? updatedAt;
  int? priceBeforeTax;
  Client? client;
  Company? company;
  List<Products>? products;

  Data({
    this.id,
    this.clientId,
    this.companyId,
    this.finalPrice,
    this.taxAmount,
    this.paymentType,
    this.createdAt,
    this.updatedAt,
    this.priceBeforeTax,
    this.client,
    this.company,
    this.products,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['client_id'];
    companyId = json['company_id'];
    finalPrice = json['final_price'];
    taxAmount = json['tax_amount'];
    paymentType = json['payment_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    priceBeforeTax = json['price_before_tax'];
    client = json['client'] != null ? Client.fromJson(json['client']) : null;
    company =
        json['company'] != null ? Company.fromJson(json['company']) : null;
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['client_id'] = clientId;
    data['company_id'] = companyId;
    data['final_price'] = finalPrice;
    data['tax_amount'] = taxAmount;
    data['payment_type'] = paymentType;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['price_before_tax'] = priceBeforeTax;
    if (client != null) {
      data['client'] = client!.toJson();
    }
    if (company != null) {
      data['company'] = company!.toJson();
    }
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Client {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? name;
  String? phone;
  int? taxNumber;
  int? companyId;

  Client(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.name,
      this.phone,
      this.taxNumber,
      this.companyId});

  Client.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    phone = json['phone'];
    taxNumber = json['tax_number'];
    companyId = json['company_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['name'] = name;
    data['phone'] = phone;
    data['tax_number'] = taxNumber;
    data['company_id'] = companyId;
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

class Products {
  int? id;
  int? categoryId;
  String? createdAt;
  String? updatedAt;
  String? title;
  int? optionalPrice;
  int? price;
  int? isTax;
  String? deletedAt;
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
      this.deletedAt,
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
    deletedAt = json['deleted_at'];
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
    data['deleted_at'] = deletedAt;
    if (pivot != null) {
      data['pivot'] = pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  int? billId;
  int? productId;
  int? quantity;

  Pivot({this.billId, this.productId, this.quantity});

  Pivot.fromJson(Map<String, dynamic> json) {
    billId = json['bill_id'];
    productId = json['product_id'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bill_id'] = billId;
    data['product_id'] = productId;
    data['quantity'] = quantity;
    return data;
  }
}
