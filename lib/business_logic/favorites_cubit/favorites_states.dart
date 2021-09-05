abstract class FavoritesStates {}
class FavoritesInitialState extends FavoritesStates {}
class GetFavoritesSuccessState extends FavoritesStates {}
class GetFavoritesErrorState extends FavoritesStates {
  final error;

  GetFavoritesErrorState(this.error);

}
class GetFavoritesLoadingState extends FavoritesStates {}
