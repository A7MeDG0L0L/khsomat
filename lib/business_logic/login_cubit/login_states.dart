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
