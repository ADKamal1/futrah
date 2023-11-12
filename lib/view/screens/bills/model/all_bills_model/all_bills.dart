import 'package:futrah/models/error_model.dart';

class GetAllBills {
  int? code;
  int? status;
  ErrorModel? errors;
  String? message;
  List<Data>? data;
  int? billsTotalAmount;
  int? totalTaxAmount;

  GetAllBills({this.code, this.status, this.errors, this.message, this.data});

  num get totalNetAmount {
    return (billsTotalAmount ?? 0) - (totalTaxAmount ?? 0);
  }

  GetAllBills.fromJson(Map<String, dynamic> json) {
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
    billsTotalAmount = json['bills_total_amount'];
    totalTaxAmount = json['total_tax_amount'];
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
    data['bills_total_amount'] = billsTotalAmount;
    data['total_tax_amount'] = totalTaxAmount;
    return data;
  }
}

class Data {
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

  Data.fromJson(dynamic json) {
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
      products = [];
      json['products'].forEach((v) {
        products?.add(Products.fromJson(v));
      });
    }
  }
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

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['client_id'] = clientId;
    map['company_id'] = companyId;
    map['final_price'] = finalPrice;
    map['tax_amount'] = taxAmount;
    map['payment_type'] = paymentType;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['price_before_tax'] = priceBeforeTax;
    if (client != null) {
      map['client'] = client?.toJson();
    }
    if (company != null) {
      map['company'] = company?.toJson();
    }
    if (products != null) {
      map['products'] = products?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Client {
  Client({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.phone,
    this.taxNumber,
    this.companyId,
  });

  Client.fromJson(dynamic json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    phone = json['phone'];
    taxNumber = json['tax_number'];
    companyId = json['company_id'];
  }
  int? id;
  String? createdAt;
  String? updatedAt;
  String? name;
  String? phone;
  int? taxNumber;
  int? companyId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['name'] = name;
    map['phone'] = phone;
    map['tax_number'] = taxNumber;
    map['company_id'] = companyId;
    return map;
  }
}

class Company {
  Company({
    this.id,
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
  });

  Company.fromJson(dynamic json) {
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

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;
    map['subscribe_id'] = subscribeId;
    map['subscription_end_date'] = subscriptionEndDate;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['fire_base_id'] = fireBaseId;
    map['address'] = address;
    map['tax_number'] = taxNumber;
    map['tax_rate'] = taxRate;
    return map;
  }
}

class Pivot {
  Pivot({
    this.billId,
    this.productId,
  });

  Pivot.fromJson(dynamic json) {
    billId = json['bill_id'];
    productId = json['product_id'];
  }
  int? billId;
  int? productId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bill_id'] = billId;
    map['product_id'] = productId;
    return map;
  }
}

class Products {
  Products({
    this.id,
    this.categoryId,
    this.createdAt,
    this.updatedAt,
    this.title,
    this.optionalPrice,
    this.price,
    this.isTax,
    this.pivot,
  });

  Products.fromJson(dynamic json) {
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
  int? id;
  int? categoryId;
  String? createdAt;
  String? updatedAt;
  String? title;
  int? optionalPrice;
  int? price;
  int? isTax;
  Pivot? pivot;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['category_id'] = categoryId;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['title'] = title;
    map['optional_price'] = optionalPrice;
    map['price'] = price;
    map['is_tax'] = isTax;
    if (pivot != null) {
      map['pivot'] = pivot?.toJson();
    }
    return map;
  }
}
