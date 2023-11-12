class RegisterModel {
  int? code;
  int? status;
  dynamic errors;
  String? message;
  Data? data;

  RegisterModel({this.code, this.status, this.errors, this.message, this.data});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    errors = json['errors'];
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
  String? name;
  String? email;
  String? phone;
  String? updatedAt;
  String? createdAt;
  int? id;
  String? subscriptionEndDate;
  int? days;

  Data(
      {this.name,
      this.email,
      this.phone,
      this.updatedAt,
      this.createdAt,
      this.id,
      this.subscriptionEndDate,
      this.days});

  Data.fromJson(Map<String, dynamic> json) {
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
