import 'package:khsomat/data/models/products_model.dart';

abstract class HomeStates{}
class InitialHomeState extends HomeStates{}
class NavBarChangeState extends HomeStates{
}

class GetProductsSuccessState extends HomeStates{
  final List<Product>products;

  GetProductsSuccessState(this.products);
}
class GetProductsLoadingState extends HomeStates{}
class GetProductsErrorState extends HomeStates{
  final String error;

  GetProductsErrorState(this.error);

}