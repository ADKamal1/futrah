import 'package:futrah/models/error_model.dart';

class CompanyUpdateModel {
  int? code;
  int? status;
  String? message;
  ErrorModel? errors;
  Data? data;

  CompanyUpdateModel(
      {this.code, this.status, this.errors, this.message, this.data});

  CompanyUpdateModel.fromJson(Map<String, dynamic> json) {
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
  AttachmentRelation? attachmentRelation;

  Data(
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
      this.attachmentRelation});

  Data.fromJson(Map<String, dynamic> json) {
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
    attachmentRelation = json['attachment_relation'] != null
        ? AttachmentRelation.fromJson(json['attachment_relation'])
        : null;
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
