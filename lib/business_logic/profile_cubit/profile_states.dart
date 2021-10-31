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
