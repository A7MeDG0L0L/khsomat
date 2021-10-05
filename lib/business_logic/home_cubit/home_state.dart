import 'package:khsomat/data/models/category_model.dart';
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

class GetProductsForCategorySuccessState extends HomeStates{
  final List<Product>productsForCategory;

  GetProductsForCategorySuccessState(this.productsForCategory);
}
class GetProductsForCategoryLoadingState extends HomeStates{}
class GetProductsForCategoryErrorState extends HomeStates{
  final String error;

  GetProductsForCategoryErrorState(this.error);

}


class GetCategoriesSuccessState extends HomeStates{
  final List<Category>category;

  GetCategoriesSuccessState(this.category);
}
class GetCategoriesLoadingState extends HomeStates{}
class GetCategoriesErrorState extends HomeStates{
  final String error;

  GetCategoriesErrorState(this.error);

}

class GetProductsAndCategoriesSuccessState extends HomeStates{
  final List<Category> category;
  final List<Product> products;
  GetProductsAndCategoriesSuccessState(this.products,this.category);
}