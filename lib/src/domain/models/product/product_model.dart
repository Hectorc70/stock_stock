class ProductModel {
  int? id;
  String? name;
  int? pieces;
  double? price;

  ProductModel({
    this.id,
    this.name,
    this.pieces,
    this.price,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
      id: json['id'],
      name: json['name'],
      pieces: json['pieces'],
      price: json['price']);
}
