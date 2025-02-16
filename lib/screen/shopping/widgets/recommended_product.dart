import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/data/models/product.dart';
import 'package:shopping_app/data/states/home_page/bloc.dart';
import 'package:shopping_app/data/states/home_page/event.dart';
import 'package:shopping_app/data/states/home_page/state.dart';
import 'package:shopping_app/gen/figma_color.dart';
import 'package:shopping_app/gen/figma_text_style.dart';
import 'package:shopping_app/screen/common/common_error.dart';
import 'package:shopping_app/screen/shopping/widgets/shopping_list.dart';

class RecommendedProduct extends StatefulWidget {
  const RecommendedProduct({super.key});

  @override
  State<RecommendedProduct> createState() => _RecommendedProductState();
}

class _RecommendedProductState extends State<RecommendedProduct> {
  List<Product?> productList = [];
  bool isLoading = false;
  late HomePageBloc homePageBloc;

  @override
  void initState() {
    super.initState();
    homePageBloc = context.read<HomePageBloc>();
    homePageBloc.add(const GetRecommendedProducts());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageBloc, HomePageState>(listener: (context, state) {
      if (state is GetRecommendedProductsLoading) {
        setState(() {
          isLoading = true;
        });
      }
      if (state is GetRecommendedProductsSuccess) {
        setState(() {
          isLoading = false;
          productList = state.products;
        });
      }
    }, builder: (context, state) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 18),
          child: Text('Recommend Product', style: FigmaTextStyles.m3Large.copyWith(color: FigmaColors.textDark)),
        ),
        if (state is GetRecommendedProductsError) ...[
          CommonErrorWidget(onTryAgain: () => homePageBloc.add(const GetRecommendedProducts()))
        ] else ...[
          SizedBox(
            height: 400,
            child: ListView.separated(
              itemCount: 4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => const SizedBox(height: 24),
              itemBuilder: (context, index) {
                if (isLoading) {
                  return ShoppingList(isLoading: isLoading);
                } else {
                  final product = productList[index]!;
                  return ShoppingList(product: product);
                }
              },
            ),
          ),
        ]
      ]);
    });
  }
}
