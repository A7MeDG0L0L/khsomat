abstract class FavoritesStates {}
class FavoritesInitialState extends FavoritesStates {}
class GetFavoritesSuccessState extends FavoritesStates {}
class GetFavoritesErrorState extends FavoritesStates {
  final error;

  GetFavoritesErrorState(this.error);

}
class GetFavoritesLoadingState extends FavoritesStates {}

class AppCreatedDatabaseState extends FavoritesStates {}
class AppInsertedToDatabaseState extends FavoritesStates {}

class AppGetWishListDatabaseLoadingState extends FavoritesStates {}
class AppGetOrderListDatabaseLoadingState extends FavoritesStates {}

class GetWishListFromDataBaseState extends FavoritesStates{}
class GetOrderListFromDataBaseState extends FavoritesStates{}

class RemoveDataFromDatabase extends FavoritesStates{}

class DeleteWishListDataFromDatabaseState extends FavoritesStates {}
class DeleteOrderListDataFromDatabaseState extends FavoritesStates {}

class IncreaseQuantityState extends FavoritesStates{}
class DecreaseQuantityState extends FavoritesStates{}
