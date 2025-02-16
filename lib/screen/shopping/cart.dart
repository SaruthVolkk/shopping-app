import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/data/models/cart.dart';
import 'package:shopping_app/data/states/cart/bloc.dart';
import 'package:shopping_app/data/states/cart/event.dart';
import 'package:shopping_app/data/states/cart/state.dart';
import 'package:shopping_app/gen/figma_color.dart';
import 'package:shopping_app/gen/figma_text_style.dart';
import 'package:shopping_app/screen/common/primary_button.dart';
import 'package:shopping_app/screen/shopping/widgets/shopping_list.dart';
import 'package:intl/intl.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Cart> cartList = [];
  late CartBloc cartBloc;

  @override
  void initState() {
    cartBloc = context.read<CartBloc>();
    cartList = cartBloc.cartItems;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget renderEmptyCart() {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Empty Cart', style: FigmaTextStyles.m3Large.copyWith(color: Colors.black)),
            const SizedBox(height: 10),
            PrimaryButton(label: 'Go to shopping', onPressed: () => Navigator.pop(context)),
          ],
        ),
      ),
    );
  }

  Widget renderSuccessCheckout() {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Success!', style: FigmaTextStyles.m3Large.copyWith(color: Colors.black)),
            const SizedBox(height: 10),
            Text('Thank you for shopping with us!', style: FigmaTextStyles.m3Small.copyWith(color: Colors.black)),
            const SizedBox(height: 10),
            PrimaryButton(
              label: 'Go to shopping',
              onPressed: () {
                cartBloc.add(ClearCart());
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget renderCartDetail() {
    final numberFormat = NumberFormat("#,##0.00", "en_US");
    final total = cartList.fold(
      0,
      (previousValue, element) => previousValue + (element.product!.price! * element.quantity!).toInt(),
    );
    const discount = 500;

    return Container(
      padding: const EdgeInsets.all(16),
      color: const Color.fromRGBO(232, 222, 248, 1),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Subtotal', style: FigmaTextStyles.m3Medium.copyWith(color: FigmaColors.primaryPurpleText)),
            Text(numberFormat.format(total),
                style: FigmaTextStyles.m3Medium.copyWith(color: FigmaColors.primaryPurpleText)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Promotion Discount', style: FigmaTextStyles.m3Medium.copyWith(color: FigmaColors.primaryPurpleText)),
            Text('-${numberFormat.format(discount)}',
                style: FigmaTextStyles.m3Medium.copyWith(color: FigmaColors.errorRed)),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              numberFormat.format(total - discount <= 0 ? 0 : total - discount),
              style: FigmaTextStyles.m3ExtraLarge.copyWith(color: FigmaColors.primaryPurpleText),
            ),
            PrimaryButton(
              label: 'Checkout',
              padding: const EdgeInsets.symmetric(horizontal: 58, vertical: 11.5),
              onPressed: () => cartBloc.add(Checkout()),
            )
          ],
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
      listener: (context, state) {
        if (state is CartError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
            backgroundColor: FigmaColors.errorRed,
          ));
        }
      },
      builder: (context, state) {
        if (state is CheckoutSuccess && cartList.isNotEmpty) {
          return renderSuccessCheckout();
        } else if (cartList.isEmpty) {
          return renderEmptyCart();
        } else {
          return Scaffold(
            appBar: AppBar(title: const Text('Cart')),
            body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ListView.separated(
                    itemCount: cartList.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 24),
                    itemBuilder: (context, index) {
                      final cart = cartList[index];
                      return ShoppingList(product: cart.product!, disableSwipe: false);
                    },
                  ),
                ),
              ),
              renderCartDetail(),
            ]),
          );
        }
      },
    );
  }
}
