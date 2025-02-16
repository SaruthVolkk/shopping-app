import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/data/models/cart.dart';
import 'package:shopping_app/data/service/product.dart';
import 'package:shopping_app/data/states/cart/event.dart';
import 'package:shopping_app/data/states/cart/state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  List<Cart> cartItems = [];

  CartBloc() : super(CartInitial()) {
    on<UpdateCartItem>(updateCartItem);
    on<RemoveCartItem>(removeCartItem);
    on<Checkout>(checkout);
    on<ClearCart>(clearCart);
  }

  void updateCartItem(UpdateCartItem event, Emitter<CartState> emit) async {
    final index = cartItems.indexWhere((element) => element.product?.id == event.product.id);
    if (event.quantity <= 0) {
      cartItems.removeWhere((element) => element.product?.id == event.product.id);
    } else {
      if (index != -1) {
        cartItems[index].quantity = event.quantity;
      } else {
        cartItems.add(Cart(product: event.product, quantity: event.quantity));
      }
    }
    emit(CartUpdated(cartItems: cartItems));
  }

  void removeCartItem(RemoveCartItem event, Emitter<CartState> emit) async {
    cartItems.removeWhere((element) => element.product?.id == event.product.id);
    emit(CartUpdated(cartItems: cartItems));
  }

  void clearCart(ClearCart event, Emitter<CartState> emit) async {
    cartItems.clear();
    print('cartItems <==' + cartItems.toList().toString());
    emit(CartUpdated(cartItems: cartItems));
  }

  void checkout(Checkout event, Emitter<CartState> emit) async {
    try {
      await ProductService().checkout(cartItems);
      emit(const CheckoutSuccess());
    } catch (error) {
      emit(CartError(error.toString()));
    }
  }
}
