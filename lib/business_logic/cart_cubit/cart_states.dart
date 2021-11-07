abstract class CartStates{}

class CartInitialState extends CartStates{}

class AppGetOrderListDatabaseLoadingState extends CartStates {}
class GetOrderListFromDataBaseState extends CartStates{}

class IncreaseQuantityState extends CartStates{}
class DecreaseQuantityState extends CartStates{}
class DeleteOrderListDataFromDatabaseState extends CartStates{}
class GetRelatedProductLoadingState extends CartStates{}
class GetRelatedProductSuccessState extends CartStates{}
class GetRelatedProductErrorState extends CartStates{
  final error;

  GetRelatedProductErrorState(this.error);
}
