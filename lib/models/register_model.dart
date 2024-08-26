class RegisterModel {
  bool? status;
  String? message;
  Data? data;

  RegisterModel({this.status, this.message, this.data});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  dynamic name;
  dynamic email;
  dynamic phone;
  int? id;
  dynamic image;
  dynamic token;

  Data({this.name, this.email, this.phone, this.id, this.image, this.token});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    id = json['id'];
    image = json['image'];
    token = json['token'];
  }
}
