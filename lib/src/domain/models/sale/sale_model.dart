class SaleModel {
  int? id;
  int? pieces;
  double? total;
  String? username;
  String? emailUser;
  String? productName;
  String? dateSale;
  String? timeSale;
  int? productId;

  SaleModel(
      {this.id, this.pieces, this.total, this.username, this.productName});

  factory SaleModel.fromJson(Map<String, dynamic> json) => SaleModel(
        id: json['id'],
        pieces: json['pieces'],
        productName: json['product_name'],
        username: json['username'],
        total: json['total_sale'],
      );

  Map<String, dynamic> toJson() {
    final dateTime = DateTime.now().toString().split(' ');
    return {
      'pieces': pieces.toString(),
      'product': productId.toString(),
      'total_sale': total.toString(),
      'username': username,
      'email_user': emailUser,
      'date': dateTime[0],
      'time': dateTime[1],
    };
  }
}
