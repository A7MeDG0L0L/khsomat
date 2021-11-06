abstract class CartStates{}

class CartInitialState extends CartStates{}

class AppGetOrderListDatabaseLoadingState extends CartStates {}
class GetOrderListFromDataBaseState extends CartStates{}

class IncreaseQuantityState extends CartStates{}
class DecreaseQuantityState extends CartStates{}
class DeleteOrderListDataFromDatabaseState extends CartStates{}
