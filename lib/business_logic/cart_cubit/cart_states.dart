import 'package:khsomat/data/models/customer_model.dart';

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
 class RetrieveCustomerByIDLoadingState extends CartStates{}
 class RetrieveCustomerByIDSuccessState extends CartStates{
  final CustomerModel customerModel;

  RetrieveCustomerByIDSuccessState(this.customerModel);
 }
 class RetrieveCustomerByIDErrorState extends CartStates{
  final error;
  final CustomerModel customerModel;

  RetrieveCustomerByIDErrorState(this.error,this.customerModel);

 }