import 'package:futrah/models/error_model.dart';

class AboutUsModel {
  int? code;
  int? status;
  ErrorModel? errors;
  String? message;
  List<Data>? data;

  AboutUsModel({this.code, this.status, this.errors, this.message, this.data});

  AboutUsModel.fromJson(dynamic json) {
    code = json['code'];
    status = json['status'];
    errors =
        json['errors'] != null ? ErrorModel.fromJson(json['errors']) : null;
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['status'] = status;
    map['errors'] = errors;
    errors != null ? map['errors'] : errors!.toJson();
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Data {
  int? id;
  String? title;
  String? content;
  dynamic createdAt;
  dynamic updatedAt;
  Data({this.id, this.title, this.content, this.createdAt, this.updatedAt});

  Data.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['content'] = content;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}
