class ErrorModel {
  List<String>? error;

  ErrorModel({this.error});

  ErrorModel.fromJson(Map<String, dynamic> json) {
    error = json['code'] as List<String>?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = error;
    return data;
  }
}
