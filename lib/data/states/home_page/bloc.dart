import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/data/models/product.dart';
import 'package:shopping_app/data/service/product.dart';
import 'package:shopping_app/data/states/home_page/event.dart';
import 'package:shopping_app/data/states/home_page/state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(HomePageInitial()) {
    on<GetRecommendedProducts>(getRecommendedProducts);
    on<GetLatestProducts>(getLatestProducts);
  }

  String latestProductCursor = '';
  List<Product> latestProducts = [];

  void getLatestProducts(GetLatestProducts event, Emitter<HomePageState> emit) async {
    try {
      emit(GetLatestProductsLoading());
      final response = await ProductService().getLatestProduct(latestProductCursor);
      latestProductCursor = response.cursor ?? '';
      emit(GetLatestProductsSuccess(response.items ?? []));
    } catch (error) {
      emit(GetLatestProductsError(error.toString()));
    }
  }

  void getRecommendedProducts(GetRecommendedProducts event, Emitter<HomePageState> emit) async {
    try {
      emit(GetRecommendedProductsLoading());
      final response = await ProductService().getRecommendedProduct();
      emit(GetRecommendedProductsSuccess(response));
    } catch (error) {
      emit(GetRecommendedProductsError(error.toString()));
    }
  }
}
