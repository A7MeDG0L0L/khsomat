import 'package:khsomat/data/models/customer_model.dart';
import 'package:khsomat/data/models/order_model.dart';

abstract class ProfileStates {}
class ProfileInitialState extends ProfileStates {}
class RetrieveCustomerOrdersLoadingState extends ProfileStates {}
class RetrieveCustomerOrdersSuccessState extends ProfileStates {
  final List<OrderModel>orders;

  RetrieveCustomerOrdersSuccessState(this.orders);
}
class RetrieveCustomerOrdersErrorState extends ProfileStates {
  final error;

  RetrieveCustomerOrdersErrorState(this.error);
}

class UpdateProfileLoadingState extends ProfileStates{}
class UpdateProfileSuccessState extends ProfileStates{}
class UpdateProfileErrorState extends ProfileStates{
  final error;

  UpdateProfileErrorState(this.error);
}
class RetrieveCustomerByIDLoadingState extends ProfileStates{}
class RetrieveCustomerByIDSuccessState extends ProfileStates{
 final CustomerModel customerModel2;

  RetrieveCustomerByIDSuccessState(this.customerModel2);
}
class RetrieveCustomerByIDErrorState extends ProfileStates{
  final error;
  final CustomerModel customerModel2;


  RetrieveCustomerByIDErrorState(this.error,this.customerModel2);
}
