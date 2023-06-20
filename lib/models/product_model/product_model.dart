import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    required this.image,
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.categoryId,
    // required this.status,
    required this.isFavourite,
    this.qty,
  });
  String image;
  String id,categoryId;
  bool isFavourite;
  String name;
  double price;
  String description;
  int? qty;
  // String status;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        categoryId: json["categoryId"],
        image: json["image"],
        qty: json["qty"],
        // status: json["status"],
        isFavourite: false,
        price: double.parse(json["price"].toString()),
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "description": description,
        "categoryId": categoryId,
        // "status": status,
        "isFavourite": isFavourite,
        "price": price,
        "qty": qty
      };

  ProductModel copyWith({
    int? qty,
  }) =>
      ProductModel(
        id: id,
        name: name,
        description: description,
        categoryId: categoryId,
        image: image,
        isFavourite: isFavourite,
        qty: qty ?? this.qty,
        price: price,
      );
}
