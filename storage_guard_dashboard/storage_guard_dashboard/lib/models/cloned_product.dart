import 'dart:convert';

class ClonedProduct {
  int productId;
  int newProduct;
  DateTime createdAt;

  ClonedProduct({
    required this.productId,
    required this.newProduct,
    required this.createdAt,
  });

  factory ClonedProduct.fromJson(Map<String, dynamic> json) => ClonedProduct(
    productId: json["product_id"],
    newProduct: json["new_product"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "new_product": newProduct,
    "created_at": createdAt.toIso8601String(),
  };
}
