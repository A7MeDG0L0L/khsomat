import 'package:khsomat/data/models/register_model.dart';

abstract class RegisterStates {}
class InitialState extends RegisterStates{
}
class PostRegisterStateSuccess extends RegisterStates{
final UserResponseModel userResponseModel;

  PostRegisterStateSuccess(this.userResponseModel);


}
class PostRegisterStateLoading extends RegisterStates{}
class PostRegisterStateError extends RegisterStates{
  final error;

  PostRegisterStateError(this.error);
}

class RegisterChangePasswordVisibilityState extends RegisterStates{}
