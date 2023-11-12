import 'package:futrah/models/error_model.dart';

class GetAllProductModel {
  int? code;
  int? status;
  ErrorModel? errors;
  String? message;
  List<Data>? data;

  GetAllProductModel(
      {this.code, this.status, this.errors, this.message, this.data});

  GetAllProductModel.fromJson(Map<String, dynamic> json) {
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
  int? categoryId;
  String? createdAt;
  String? updatedAt;
  String? title;
  int? optionalPrice;
  int? price;
  int? isTax;
  AttachmentRelation? image;

  Data(
      {this.id,
      this.categoryId,
      this.createdAt,
      this.updatedAt,
      this.title,
      this.optionalPrice,
      this.price,
      this.isTax,
      this.image});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    title = json['title'];
    optionalPrice = json['optional_price'];
    price = json['price'];
    isTax = json['is_tax'];
    image = json['attachment_relation'] != null
        ? AttachmentRelation.fromJson(json['attachment_relation'])
        : null;
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
    if (image != null) {
      data['attachment_relation'] = image!.toJson();
    }
    return data;
  }
}

class AttachmentRelation {
  int? id;
  String? path;
  String? type;
  String? usage;
  String? attachmentableType;
  int? attachmentableId;
  String? createdAt;
  String? updatedAt;

  AttachmentRelation(
      {this.id,
      this.path,
      this.type,
      this.usage,
      this.attachmentableType,
      this.attachmentableId,
      this.createdAt,
      this.updatedAt});

  AttachmentRelation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    path = json['path'];
    type = json['type'];
    usage = json['usage'];
    attachmentableType = json['attachmentable_type'];
    attachmentableId = json['attachmentable_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['path'] = path;
    data['type'] = type;
    data['usage'] = usage;
    data['attachmentable_type'] = attachmentableType;
    data['attachmentable_id'] = attachmentableId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
