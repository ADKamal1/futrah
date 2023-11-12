import 'package:futrah/models/error_model.dart';

class Data {
  int id;
  String name;
  String email;
  String phone;
  int subscribeId;
  String subscriptionEndDate;
  DateTime createdAt;
  DateTime updatedAt;
  String? fireBaseId;
  String? address;
  String? taxNumber;
  dynamic? taxRate;
  int isActive;
  String token;
  int days;

  Data({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.subscribeId,
    required this.subscriptionEndDate,
    required this.createdAt,
    required this.updatedAt,
     this.fireBaseId,
     this.address,
     this.taxNumber,
     this.taxRate,
    required this.isActive,
    required this.token,
    required this.days,
  });
  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      subscribeId: json['subscribe_id'] as int,
      subscriptionEndDate: json['subscription_end_date'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      fireBaseId: json['fire_base_id'] as String?,
      address: json['address'] as String?,
      taxNumber: json['tax_number'] as String?,
      taxRate: json['tax_rate'] as dynamic?,
      isActive: json['is_active'] as int,
      token: json['token'] as String,
      days: json['days'] as int,
    );
  }


  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'phone': phone,
    'subscribe_id': subscribeId,
    'subscription_end_date': subscriptionEndDate,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
    'fire_base_id': fireBaseId,
    'address': address,
    'tax_number': taxNumber,
    'tax_rate': taxRate,
    'is_active': isActive,
    'token': token,
    'days': days,
  };
}






class LoginModel {
  int? code;
  int? status;
  ErrorModel? errors;
  String? message;
  Data? data;

  LoginModel({this.code, this.status, this.errors, this.message, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
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
    errors != null ? data['errors'] : errors!.toJson();
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }

}

class Data2 {
  String? fireBaseId;
  String? phone;
  String? name;
  String? email;
  String? updatedAt;
  String? createdAt;
  int? id;
  String? token;

  Data2({
    this.fireBaseId,
    this.phone,
    this.name,
    this.email,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.token,
  });

  Data2.fromJson(Map<String, dynamic> json) {
    fireBaseId = json['fire_base_id'];
    phone = json['phone'];
    name = json['name'];
    email = json['email'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fire_base_id'] = fireBaseId;
    data['phone'] = phone;
    data['name'] = name;
    data['email'] = email;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    data['token'] = token;
    return data;
  }
}
class RegisterModel {
  int? code;
  int? status;
  dynamic errors;
  String? message;
  Data2? data;

  RegisterModel({this.code, this.status, this.errors, this.message, this.data});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    errors = json['errors'];
    message = json['message'];
    data = json['data'] != null ? Data2.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['status'] = status;
    errors != null ? data['errors'] : errors!.toJson();
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class RegisterData {
  String? name;
  String? email;
  String? phone;
  String? updatedAt;
  String? createdAt;
  int? id;
  String? subscriptionEndDate;
  int? days;

  RegisterData(
      {this.name,
        this.email,
        this.phone,
        this.updatedAt,
        this.createdAt,
        this.id,
        this.subscriptionEndDate,
        this.days});

  RegisterData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    subscriptionEndDate = json['subscription_end_date'];
    days = json['days'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    data['subscription_end_date'] = subscriptionEndDate;
    data['days'] = days;
    return data;
  }
}
