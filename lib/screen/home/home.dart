import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/data/states/cart/bloc.dart';
import 'package:shopping_app/data/states/cart/state.dart';
import 'package:shopping_app/gen/figma_color.dart';
import 'package:shopping_app/screen/shopping/cart.dart';
import 'package:shopping_app/screen/shopping/shopping.dart';

class ShoppingApp extends StatefulWidget {
  const ShoppingApp({super.key});

  @override
  State<ShoppingApp> createState() => _ShoppingAppState();
}

class _ShoppingAppState extends State<ShoppingApp> {
  int currentIndex = 0;
  int cartCount = 0;
  late CartBloc cartBloc;
  final pages = const [ShoppingPage(), CartPage()];

  @override
  void initState() {
    cartBloc = context.read<CartBloc>();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget buildActiveIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: const Color.fromRGBO(232, 222, 248, 1),
      ),
      child: Icon(icon, color: FigmaColors.textDark),
    );
  }

  void onTap(int index) {
    if (index == 1) {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CartPage()));
    } else {
      setState(() {
        currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
      listener: (context, state) {
        if (state is CartUpdated) {
          setState(() {
            cartCount = state.cartItems
                .fold(0, (previousValue, element) => previousValue + (element.quantity ?? 0).toInt())
                .toInt();
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: pages[currentIndex],
          backgroundColor: FigmaColors.primaryBgColor,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            selectedItemColor: FigmaColors.textDark,
            backgroundColor: FigmaColors.lightBgColor,
            onTap: onTap,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.stars_rounded),
                activeIcon: buildActiveIcon(Icons.stars_rounded),
                label: 'Shopping',
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.stars_outlined),
                activeIcon: buildActiveIcon(Icons.stars_outlined),
                label: cartCount > 0 ? 'Cart ($cartCount)' : 'Cart',
              ),
            ],
          ),
        );
      },
    );
  }
}
