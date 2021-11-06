import 'package:khsomat/data/models/new_product_model.dart';

abstract class FavoritesStates {}

class GetNewProductsLoadingState extends FavoritesStates{}
class GetNewProductsSuccessState extends FavoritesStates{
  final List<NewProductModel> newProducts;

  GetNewProductsSuccessState(this.newProducts);
}
class GetNewProductsErrorState extends FavoritesStates{
  final error;

  GetNewProductsErrorState(this.error);
}


class FavoritesInitialState extends FavoritesStates {}
class GetFavoritesSuccessState extends FavoritesStates {}
class GetFavoritesErrorState extends FavoritesStates {
  final error;

  GetFavoritesErrorState(this.error);

}
class GetFavoritesLoadingState extends FavoritesStates {}
class ReturnNumberWishListState extends FavoritesStates {}
class ReturnNumberWishList2State extends FavoritesStates {}
class ItemInTheListState extends FavoritesStates {}

class AppCreatedDatabaseState extends FavoritesStates {}
class AppInsertedToDatabaseState extends FavoritesStates {}

class AppGetWishListDatabaseLoadingState extends FavoritesStates {}
class AppGetOrderListDatabaseLoadingState extends FavoritesStates {}
class TotalPriceState extends FavoritesStates {}

class GetWishListFromDataBaseState extends FavoritesStates{}
class GetOrderListFromDataBaseState extends FavoritesStates{}

class RemoveDataFromDatabase extends FavoritesStates{}

class DeleteWishListDataFromDatabaseState extends FavoritesStates {}
class DeleteOrderListDataFromDatabaseState extends FavoritesStates {}

class IncreaseQuantityState extends FavoritesStates{}
class DecreaseQuantityState extends FavoritesStates{}
class DeleteAllItemsFromWishlistState extends FavoritesStates{}
class DeleteAllItemsFromOrderlistState extends FavoritesStates{}
class CreatingOrderLoadingState extends FavoritesStates{}
class CreatingOrderSuccessState extends FavoritesStates{}
class CreatingOrderErrorState extends FavoritesStates{
  final error;

  CreatingOrderErrorState(this.error);

}
