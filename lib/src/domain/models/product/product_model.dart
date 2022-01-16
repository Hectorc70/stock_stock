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
  Map<String, dynamic> fromJsonToSelectItem(Map<String, dynamic> json) {
    return {
      'icon': null,
      'label': json['name'],
      'value': json['id'],
    };
  }

  Map<String, ProductModel> fromJsonToMapSelect(List<dynamic> json) {
    Map<String, ProductModel> items = {};

    for (final item in json) {
      ProductModel prod = ProductModel.fromJson(item);

      items[prod.id.toString()] = prod;
    }

    return items;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'pieces': pieces.toString(),
      'price': price.toString(),
      'shop': shopId.toString()
    };
  }
}
