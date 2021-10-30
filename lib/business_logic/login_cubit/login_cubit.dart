import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khsomat/business_logic/login_cubit/login_states.dart';
import 'package:khsomat/data/models/customer_model.dart';
import 'package:khsomat/data/models/login_model.dart';
import 'package:khsomat/data/web_services/web_services.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(InitialLoginState());
  static LoginCubit get(context) => BlocProvider.of(context);

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  LoginResponseModel? loginResponseModel;

  void userLogin({
    required String username,
    required String password,
  }) {
    emit(LoginLoadingState());
    WebServices.dio.post('jwt-auth/v1/token', data: {
      'username': username,
      'password': password,
    }).then((value) {
      loginResponseModel = LoginResponseModel.fromJson(value.data);
      emit(LoginSuccessState(loginResponseModel!));
    }).catchError((error) {
      print(error.toString());
      emit(LoginErrorState(error));
    });
  }
CustomerModel? customerModel;
  void retrieveCustomer(int id) {
    emit(RetrieveCustomerByIDLoadingState());
    WebServices.dio.get(
      'wc/v3/customers/$id',
      queryParameters: {
        'Content-Type': "application/json",
        'consumer_key': 'ck_fa054c2eea7057ed605ce37417fe5e92fb2d428b',
        'consumer_secret': 'cs_a2bcff0feec2d96d830b08ecf93015f6de9b409e'
      },
    ).then((value) {
      customerModel=CustomerModel.fromJson(value.data);
      print(value.data);
      print(value.statusCode);

      emit(RetrieveCustomerByIDSuccessState(customerModel!));
    }).catchError((error) {
      print(error.toString());
      emit(RetrieveCustomerByIDErrorState(error));
    });
  }

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(RegisterChangePasswordVisibilityState());
  }
}
