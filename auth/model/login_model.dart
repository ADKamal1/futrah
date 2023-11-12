class LoginModel {
  int? code;
  int? status;
  dynamic errors;
  String? message;
  Data? data;

  LoginModel({this.code, this.status, this.errors, this.message, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? name;
  String? email;
  String? phone;
  int? subscribeId;
  String? subscriptionEndDate;
  String? createdAt;
  String? updatedAt;
  String? token;
  int? days;

  Data({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.subscribeId,
    this.subscriptionEndDate,
    this.createdAt,
    this.updatedAt,
    this.token,
    this.days,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    subscribeId = json['subscribe_id'];
    subscriptionEndDate = json['subscription_end_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    token = json['token'];
    days = json['days'];
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
    data['token'] = token;
    data['days'] = days;
    return data;
  }
}
