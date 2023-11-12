import 'package:futrah/models/error_model.dart';

class GetCustomersModel {
  int? code;
  int? status;
  ErrorModel? errors;
  String? message;
  List<Data>? data;

  GetCustomersModel(
      {this.code, this.status, this.errors, this.message, this.data});

  GetCustomersModel.fromJson(Map<String, dynamic> json) {
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
  String? createdAt;
  String? updatedAt;
  String? name;
  String? phone;
  int? taxNumber;
  int? companyId;

  Data(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.name,
      this.phone,
      this.taxNumber,
      this.companyId});

  Data.fromJson(Map<String, dynamic> json) {
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
