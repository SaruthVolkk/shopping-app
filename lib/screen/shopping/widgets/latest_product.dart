import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/data/models/product.dart';
import 'package:shopping_app/data/states/home_page/bloc.dart';
import 'package:shopping_app/data/states/home_page/event.dart';
import 'package:shopping_app/data/states/home_page/state.dart';
import 'package:shopping_app/gen/figma_color.dart';
import 'package:shopping_app/gen/figma_text_style.dart';
import 'package:shopping_app/screen/common/common_error.dart';
import 'package:shopping_app/screen/common/scroll_loading.dart';
import 'package:shopping_app/screen/shopping/widgets/shopping_list.dart';

class LatestProduct extends StatefulWidget {
  const LatestProduct({
    super.key,
    this.scrollController,
  });

  final ScrollController? scrollController;

  @override
  State<LatestProduct> createState() => _LatestProductState();
}

class _LatestProductState extends State<LatestProduct> {
  List<Product?> productList = [];
  bool isScrollLoading = false;
  bool isLoading = false;
  late ScrollController scrollController;
  late HomePageBloc homePageBloc;

  @override
  void initState() {
    super.initState();
    scrollController = widget.scrollController ?? ScrollController();
    homePageBloc = context.read<HomePageBloc>();
    homePageBloc.add(const GetLatestProducts());
    scrollController.addListener(onScrollEnd);
  }

  @override
  void dispose() {
    scrollController.removeListener(onScrollEnd);
    scrollController.dispose();
    super.dispose();
  }

  void onScrollEnd() {
    if (scrollController.position.atEdge && scrollController.position.pixels != 100) {
      setState(() {
        isScrollLoading = true;
      });
      homePageBloc.add(const GetLatestProducts());
    }
  }

  List<Widget> renderLatestProductList() {
    const padding = EdgeInsets.only(bottom: 26);
    if (isLoading && !isScrollLoading) {
      return List.generate(4, (_) => const Padding(padding: padding, child: ShoppingList(isLoading: true)));
    }
    return productList
        .where((product) => product != null)
        .map((product) => Padding(padding: padding, child: ShoppingList(product: product!)))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageBloc, HomePageState>(
      listener: (context, state) {
        if (state is GetLatestProductsLoading) {
          setState(() {
            isLoading = true;
          });
        }
        if (state is GetLatestProductsSuccess) {
          setState(() {
            productList.addAll(state.products);
            isScrollLoading = false;
            isLoading = false;
          });
        }
      },
      builder: (context, state) {
        if (state is GetLatestProductsError) {
          return CommonErrorWidget(onTryAgain: () => homePageBloc.add(const GetLatestProducts()));
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18),
              child: Text(
                'Latest Products',
                style: FigmaTextStyles.m3Large.copyWith(color: FigmaColors.textDark),
                textAlign: TextAlign.left,
              ),
            ),
            Column(children: [
              ...renderLatestProductList(),
              if (isScrollLoading) const ScrollLoading(),
            ]),
          ],
        );
      },
    );
  }
}
