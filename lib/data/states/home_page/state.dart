import 'package:shopping_app/data/models/product.dart';

class HomePageState {
  const HomePageState();
  List<Object?> get props => [];
}

class HomePageInitial extends HomePageState {}

class GetRecommendedProductsInitial extends HomePageState {}

class GetRecommendedProductsLoading extends HomePageState {}

class GetRecommendedProductsError extends HomePageState {
  final String message;

  const GetRecommendedProductsError(this.message);

  @override
  List<Object?> get props => [message];
}

class GetRecommendedProductsSuccess extends HomePageState {
  final List<Product?> products;

  const GetRecommendedProductsSuccess(this.products);

  @override
  List<Object?> get props => [products];
}

class GetLatestProductsInitial extends HomePageState {}

class GetLatestProductsLoading extends HomePageState {}

class GetLatestProductsError extends HomePageState {
  final String message;

  const GetLatestProductsError(this.message);

  @override
  List<Object?> get props => [message];
}

class GetLatestProductsSuccess extends HomePageState {
  final List<Product?> products;

  const GetLatestProductsSuccess(this.products);

  @override
  List<Object?> get props => [products];
}
