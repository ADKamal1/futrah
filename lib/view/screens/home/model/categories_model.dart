import 'package:futrah/models/error_model.dart';

class CategoriesModel {
  int? code;
  int? status;
  ErrorModel? errors;
  String? message;
  List<Data>? data;

  CategoriesModel(
      {this.code, this.status, this.errors, this.message, this.data});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
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
  int? companyId;
  String? title;
  String? createdAt;
  String? updatedAt;

  Data({this.id, this.companyId, this.title, this.createdAt, this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['company_id'];
    title = json['title'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['company_id'] = companyId;
    data['title'] = title;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
