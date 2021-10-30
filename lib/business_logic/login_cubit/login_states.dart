import 'package:khsomat/data/models/customer_model.dart';
import 'package:khsomat/data/models/login_model.dart';

abstract class LoginState{}
class InitialLoginState extends LoginState{}
class LoginSuccessState extends LoginState{

  late final LoginResponseModel loginResponseModel;

  LoginSuccessState(this.loginResponseModel);

}
class LoginErrorState extends LoginState{
  final error;

  LoginErrorState(this.error);

}
class LoginLoadingState extends LoginState{

  LoginLoadingState();

}

class RegisterChangePasswordVisibilityState extends LoginState{}
class RetrieveCustomerByIDSuccessState extends LoginState{
  late final CustomerModel customerModel;
  RetrieveCustomerByIDSuccessState(this.customerModel);
}
class RetrieveCustomerByIDLoadingState extends LoginState{}
class RetrieveCustomerByIDErrorState extends LoginState{
  final error;

  RetrieveCustomerByIDErrorState(this.error);
}
