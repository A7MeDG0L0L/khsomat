import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khsomat/business_logic/register_cubit/register_states.dart';
import 'package:khsomat/data/models/register_model.dart';
import 'package:khsomat/data/web_services/web_services.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(InitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  late UserModel userModel;
  late UserResponseModel userResponseModel;



  void userRegister(
      {required String username,
      required String email,
      required String password,
      required String firstname,
      required String lastname,
      }) {
    emit(PostRegisterStateLoading());
    ///TODO: Change it with WooCommerce API Customers : '/wc/v3/customers'
    WebServices.dio.post('wp/v2/users/register', data: {
      'username': username,
      'email': email,
      'password': password,
      'firstname': firstname,
      'lastname': lastname,
    }).then((value) {
      userModel = UserModel.fromJson(value.data);
      print(userModel);
      emit(PostRegisterStateSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(PostRegisterStateError(error));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined ;

    emit(RegisterChangePasswordVisibilityState());
  }
}
