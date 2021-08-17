abstract class HomeStates{}
class InitialHomeState extends HomeStates{}
class NavBarChangeState extends HomeStates{
}

class GetProductsSuccessState extends HomeStates{}
class GetProductsLoadingState extends HomeStates{}
class GetProductsErrorState extends HomeStates{
  final String error;

  GetProductsErrorState(this.error);

}