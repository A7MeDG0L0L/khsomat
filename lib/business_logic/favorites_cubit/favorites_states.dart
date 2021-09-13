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

class AppGetDatabaseLoadingState extends FavoritesStates {}

class GetFromDataBaseState extends FavoritesStates{}

class RemoveDataFromDatabase extends FavoritesStates{}

class DeleteDataFromDatabaseState extends FavoritesStates {}
