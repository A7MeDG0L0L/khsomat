
abstract class RegisterStates {}
class InitialState extends RegisterStates{
}
class PostRegisterStateSuccess extends RegisterStates{
 // final UserResponseModel userResponseModel;




}
class PostRegisterStateLoading extends RegisterStates{}
class PostRegisterStateError extends RegisterStates{
  final error;


 //final UserResponseModel userResponseModel;



  PostRegisterStateError(this.error);
}

class RegisterChangePasswordVisibilityState extends RegisterStates{}
