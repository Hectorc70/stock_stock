import 'package:stock_stock/src/domain/models/employee/employee_model.dart';

class ShopModel {
  int? id;
  String? nameShop;
  List<dynamic>? employes;

  ShopModel({this.id, this.nameShop, this.employes});

  factory ShopModel.fromJson(Map<String, dynamic> json) => ShopModel(
      id: json['id'], nameShop: json['nameShop'], employes: json['employes']);
}
