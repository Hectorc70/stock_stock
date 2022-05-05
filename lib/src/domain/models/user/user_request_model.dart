class UserRequestModel {
  String email;
  String typeAcount;
  String names;
  String lastName;
  String secondLastName;
  String? idFirebase;
  String? idDevice;
  int? keyShop;

  UserRequestModel(
      {required this.email,
      required this.typeAcount,
      required this.names,
      required this.lastName,
      required this.secondLastName,
      this.idFirebase,
      this.idDevice,
      this.keyShop});

  Map<String, dynamic> toJson() => {
        'email': email,
        'type_acount': typeAcount,
        'names': names,
        'last_name': lastName,
        'second_last_name': secondLastName,
        'id_firebase': idFirebase,
        'id_device': idDevice,
        'keyShop': idDevice,
      };
}
