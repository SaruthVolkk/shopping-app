abstract class HomePageEvent {
  const HomePageEvent();
  List<Object> get props => [];
}

class GetRecommendedProducts extends HomePageEvent {
  const GetRecommendedProducts();
  @override
  List<Object> get props => [];
}

class GetLatestProducts extends HomePageEvent {
  const GetLatestProducts();
  @override
  List<Object> get props => [];
}
