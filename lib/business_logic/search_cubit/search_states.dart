import 'package:khsomat/data/models/products_model.dart';

abstract class SearchStates {}

class SearchInitialState extends SearchStates {}

class SearchLoadingState extends SearchStates {}

class SearchSuccessState extends SearchStates {

  final List<Product> searchProduct;

  SearchSuccessState(this.searchProduct);
}

class SearchErrorState extends SearchStates {
  final error;

  SearchErrorState(this.error);

}