import 'package:futrah/models/error_model.dart';

class AddCustomersModel {
  int? code;
  int? status;
  ErrorModel? errors;
  String? message;
  Data? data;

  AddCustomersModel(
      {this.code, this.status, this.errors, this.message, this.data});

  AddCustomersModel.fromJson(Map<String, dynamic> json) {
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

class Data {
  String? companyId;
  String? name;
  String? phone;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.companyId,
      this.name,
      this.phone,
      this.updatedAt,
      this.createdAt,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    companyId = json['company_id'];
    name = json['name'];
    phone = json['phone'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['company_id'] = companyId;
    data['name'] = name;
    data['phone'] = phone;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}
