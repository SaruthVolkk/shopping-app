import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/data/states/home_page/bloc.dart';
import 'package:shopping_app/data/states/home_page/state.dart';
import 'package:shopping_app/screen/shopping/widgets/latest_product.dart';
import 'package:shopping_app/screen/shopping/widgets/recommended_product.dart';

class ShoppingPage extends StatefulWidget {
  const ShoppingPage({super.key});

  @override
  State<ShoppingPage> createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageBloc, HomePageState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(children: [
                const RecommendedProduct(),
                LatestProduct(scrollController: scrollController),
              ]),
            ),
          ),
        );
      },
    );
  }
}
