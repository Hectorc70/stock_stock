class ProductModel {
  int? id;
  String? name;
  int? pieces;
  double? price;
  int? shopId;

  ProductModel({this.id, this.name, this.pieces, this.price, this.shopId});

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
      id: json['id'],
      name: json['name'],
      pieces: json['pieces'],
      price: json['price'],
      shopId: json['shop']);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'pieces': pieces.toString(),
      'price': price.toString(),
      'shop': shopId.toString()
    };
  }
}
