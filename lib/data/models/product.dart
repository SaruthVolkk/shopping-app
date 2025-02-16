// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Product {
  final num? id;
  final String? name;
  final num? price;
  final String? imageUrl;

  const Product({
    this.id,
    this.name,
    this.price,
    this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: int.tryParse(map['id'].toString()),
      name: map['name']?.toString(),
      price: double.tryParse(map['price'].toString()),
      imageUrl: map['imageUrl']?.toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) => Product.fromMap(json.decode(source) as Map<String, dynamic>);
}
