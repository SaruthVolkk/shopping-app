import 'dart:convert';

import 'package:shopping_app/data/client.dart';
import 'package:shopping_app/data/models/base.dart';
import 'package:shopping_app/data/models/cart.dart';
import 'package:shopping_app/data/models/product.dart';

class ProductService {
  ApiClient apiClient = ApiClient();

  Future<List<Product>> getRecommendedProduct() async {
    try {
      final response = await apiClient.client.get('/recommended-products');
      final List<dynamic> data = response.data;
      return data.map((item) => Product.fromJson(json.encode(item))).toList();
    } catch (_) {
      return [];
    }
  }

  Future<PaginationResponse<Product>> getLatestProduct(String latestProductCursor) async {
    try {
      final response = await apiClient.client.get(
        '/products',
        queryParameters: {'limit': 20, 'cursor': latestProductCursor},
      );
      return PaginationResponse<Product>.fromMap(
        response.data,
        (Map<String, dynamic> item) => Product.fromJson(json.encode(item)),
      );
    } catch (_) {
      return PaginationResponse<Product>(items: []);
    }
  }

  Future<void> checkout(List<Cart> carts) async {
    try {
      await apiClient.client.post(
        'orders/checkout',
        data: json.encode(carts.map((cart) => cart.product?.id).toList()),
      );
    } catch (_) {}
  }
}
