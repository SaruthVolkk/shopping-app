import 'package:shopping_app/data/models/cart.dart';

class CartState {
  const CartState();
  List<Object?> get props => [];
}

class CartInitial extends CartState {}

class CartUpdated extends CartState {
  final List<Cart> cartItems;

  const CartUpdated({required this.cartItems});

  @override
  List<Object?> get props => [cartItems];
}

class CheckoutSuccess extends CartState {
  const CheckoutSuccess();
}

class CartError extends CartState {
  final String message;

  const CartError(this.message);

  @override
  List<Object> get props => [message];
}
