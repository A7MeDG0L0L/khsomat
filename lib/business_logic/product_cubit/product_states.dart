import 'package:khsomat/data/models/category_model.dart';
import 'package:khsomat/data/models/products_model.dart';

abstract class ProductStates{}
class ProductInitialState extends ProductStates{}
class GetProductsScreenLoadingState extends ProductStates{}
class GetProductsScreenSuccessState extends ProductStates{
 final List<Product> product;

  GetProductsScreenSuccessState(this.product);
}
class GetProductsScreenErrorState extends ProductStates{
  final error;

  GetProductsScreenErrorState(this.error);
}


class GetCategoriesForProductScreenLoadingState extends ProductStates {}
class GetCategoriesForProductScreenSuccessState extends ProductStates {
  final List<Category> category;

  GetCategoriesForProductScreenSuccessState(this.category);
}
class GetCategoriesForProductScreenErrorState extends ProductStates{
  final error;

  GetCategoriesForProductScreenErrorState(this.error);
}
class ProductSortedState extends ProductStates{}