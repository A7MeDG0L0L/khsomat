abstract class LoginState{}
class InitialLoginState extends LoginState{}
class LoginSuccessState extends LoginState{}
class LoginErrorState extends LoginState{
  final error;

  LoginErrorState(this.error);

}
class LoginLoadingState extends LoginState{}

class RegisterChangePasswordVisibilityState extends LoginState{}
