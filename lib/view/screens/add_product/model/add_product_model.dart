import 'package:futrah/models/error_model.dart';

class AddProductModel {
  int? code;
  int? status;
  ErrorModel? errors;
  String? message;
  Data? data;

  AddProductModel(
      {this.code, this.status, this.errors, this.message, this.data});

  AddProductModel.fromJson(Map<String, dynamic> json) {
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
  String? categoryId;
  String? title;
  String? content;
  String? price;
  String? updatedAt;
  String? createdAt;
  int? id;
  AttachmentRelation? attachmentRelation;

  Data(
      {this.categoryId,
      this.title,
      this.content,
      this.price,
      this.updatedAt,
      this.createdAt,
      this.id,
      this.attachmentRelation});

  Data.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    title = json['title'];
    content = json['content'];
    price = json['price'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    attachmentRelation = json['attachment_relation'] != null
        ? AttachmentRelation.fromJson(json['attachment_relation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category_id'] = categoryId;
    data['title'] = title;
    data['content'] = content;
    data['price'] = price;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    if (attachmentRelation != null) {
      data['attachment_relation'] = attachmentRelation!.toJson();
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
