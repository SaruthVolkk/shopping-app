import 'package:shopping_app/data/models/product.dart';

abstract class CartEvent {
  const CartEvent();
  List<Object> get props => [];
}

class UpdateCartItem extends CartEvent {
  final Product product;
  final num quantity;

  const UpdateCartItem(this.product, this.quantity);

  @override
  List<Object> get props => [product, quantity];
}

class RemoveCartItem extends CartEvent {
  final Product product;

  const RemoveCartItem(this.product);

  @override
  List<Object> get props => [product];
}

class ClearCart extends CartEvent {}

class Checkout extends CartEvent {}
