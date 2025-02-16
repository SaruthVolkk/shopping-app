import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shopping_app/data/models/cart.dart';
import 'package:shopping_app/data/models/product.dart';
import 'package:shopping_app/data/states/cart/bloc.dart';
import 'package:shopping_app/data/states/cart/event.dart';
import 'package:shopping_app/data/states/cart/state.dart';
import 'package:shopping_app/gen/assets.gen.dart';
import 'package:shopping_app/gen/figma_color.dart';
import 'package:shopping_app/gen/figma_text_style.dart';
import 'package:shopping_app/screen/common/counter.dart';
import 'package:shopping_app/screen/common/primary_button.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ShoppingList extends StatefulWidget {
  const ShoppingList({
    super.key,
    this.product,
    this.disableSwipe = true,
    this.isLoading = false,
  });

  final bool isLoading;
  final bool disableSwipe;
  final Product? product;

  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  List<Cart> cartList = [];
  late CartBloc cartBloc;

  @override
  void initState() {
    cartBloc = context.read<CartBloc>();
    setState(() {
      cartList = cartBloc.cartItems;
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget renderAddToCart() {
    if (widget.product == null) return const SizedBox.shrink();

    final cartItem = cartList.firstWhere(
      (element) => element.product?.id == widget.product?.id,
      orElse: () => Cart(product: widget.product),
    );
    if (cartItem.quantity == 0 || cartItem.quantity == null) {
      return PrimaryButton(
        label: 'Add to cart',
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        onPressed: () {
          cartBloc.add(UpdateCartItem(widget.product!, 1));
        },
      );
    }
    return CounterWidget(
      initialValue: cartItem.quantity,
      onChanged: (counter) {
        cartBloc.add(UpdateCartItem(widget.product!, counter));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(listener: (context, state) {
      if (state is CartUpdated) {
        setState(() {
          cartList = state.cartItems;
        });
      }
    }, builder: (context, state) {
      return Slidable(
        key: const ValueKey(0),
        endActionPane: widget.disableSwipe
            ? null
            : ActionPane(
                extentRatio: 0.3,
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) => cartBloc.add(RemoveCartItem(widget.product!)),
                    backgroundColor: FigmaColors.errorRed,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                  ),
                ],
              ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                widget.product?.imageUrl ?? '',
                width: 76,
                height: 76,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) => Image.asset(
                  Assets.images.defaultShopping.path,
                  fit: BoxFit.cover,
                  width: 76,
                  height: 76,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Skeletonizer(
                enabled: widget.isLoading,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.isLoading ? '...........................' : widget.product?.name ?? '-',
                      style: FigmaTextStyles.m3Medium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(children: [
                      Text((widget.product?.price ?? 0).toString(), style: FigmaTextStyles.m3Large),
                      const Text(' / unit', style: FigmaTextStyles.m3Small)
                    ]),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 6),
            renderAddToCart(),
          ],
        ),
      );
    });
  }
}
