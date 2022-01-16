class UserModel {
  int? id;
  String? username;
  bool? isActive;
  String? email;
  String? idFirebase;
  String? tokenUser;
  List<dynamic>? shops;
  String? idDevice;

  UserModel(
      {this.id,
      this.username,
      this.isActive,
      this.email,
      this.idFirebase,
      this.tokenUser,
      this.shops,
      this.idDevice});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'],
      email: json['email'],
      idFirebase: json['id_firebase'],
      isActive: json['is_active'],
      username: json['username'],
      tokenUser: json['token'],
      shops: json['shops'],
      idDevice: json['id_device']);
}
