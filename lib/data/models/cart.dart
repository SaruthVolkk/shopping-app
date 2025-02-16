import 'dart:convert';

import 'package:shopping_app/data/models/product.dart';

class Cart {
  final Product? product;
  num? quantity;

  Cart({
    this.product,
    this.quantity,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product': product,
      'quantity': quantity,
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      product: map['product'] != null ? Product.fromMap(map['product'] as Map<String, dynamic>) : null,
      quantity: map['quantity'] != null ? map['quantity'] as num : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Cart.fromJson(String source) => Cart.fromMap(json.decode(source) as Map<String, dynamic>);
}
