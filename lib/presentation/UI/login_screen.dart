import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khsomat/Shared/components.dart';
import 'package:khsomat/Shared/constants.dart';
import 'package:khsomat/business_logic/login_cubit/login_cubit.dart';
import 'package:khsomat/business_logic/login_cubit/login_states.dart';
import 'package:khsomat/data/cache_helper/cache_helper.dart';
import 'package:khsomat/presentation/UI/register_screen.dart';
import 'package:khsomat/translations/locale_keys.g.dart';

import 'app_layout.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            showToast(text: state.loginResponseModel.message!, state: ToastStates.SUCCESS);
            if (state.loginResponseModel.success!) {
              print(state.loginResponseModel.message);
              print(state.loginResponseModel.data!.token);

              CacheHelper.saveData(
                key: 'token',
                value: state.loginResponseModel.data!.token,
              );
              CacheHelper.saveData(key: 'userID', value: state.loginResponseModel.data!.id!);

              CacheHelper.saveData(
                  key: 'email', value: state.loginResponseModel.data!.email);
              CacheHelper.saveData(
                      key: 'username',
                      value: state.loginResponseModel.data!.displayName)
                  .then((value) {
                token = state.loginResponseModel.data!.token!;
                email = state.loginResponseModel.data!.email!;
                username = state.loginResponseModel.data!.displayName!;
                id = state.loginResponseModel.data!.id;
              });
            }
            LoginCubit.get(context).retrieveCustomer(state.loginResponseModel.data!.id!);



          }
          if(state is RetrieveCustomerByIDSuccessState){
            CacheHelper.saveData(
              key: 'email',
              value: state.customerModel.email,
            );
            CacheHelper.saveData(
              key: 'username',
              value: state.customerModel.username,
            );

            CacheHelper.saveData(
              key: 'firstname',
              value: state.customerModel.firstName,
            );
            CacheHelper.saveData(
              key: 'lastname',
              value: state.customerModel.lastName,
            );
            CacheHelper.saveData(
              key: 'city',
              value: state.customerModel.billing!.city,
            );
            CacheHelper.saveData(
              key: 'address',
              value: state.customerModel.billing!.address1,
            );
            CacheHelper.saveData(
              key: 'phone',
              value: state.customerModel.billing!.phone,
            ).then((value) {
              phone=state.customerModel.billing!.phone;
              firstname=state.customerModel.firstName;
              print(phone);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AppLayout(),
                  ),
                      (route) => false);
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AppLayout(),
                          ),
                        );
                      },
                      child: Text(
                        LocaleKeys.skip.tr(),
                        style: TextStyle(fontSize: 15.sp),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Image(
                                image:
                                    AssetImage('assets/images/150x150 Png.png'),
                                height: 200.h,
                                width: 250.w,
                              ),
                            ),
                            Text(
                              LocaleKeys.sign_in_to_your_account.tr(),
                              style: TextStyle(fontSize: 25.sp),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                             LocaleKeys.shopping_pleasure_with_khsomat.tr(),
                              style: TextStyle(fontSize: 15.sp),
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            TextFormField(
                              controller: usernameController,
                              keyboardType: TextInputType.text,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'يجب إدخال إسم المستخدم';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                label: Text(
                                  LocaleKeys.username_or_email.tr(),
                                  style: TextStyle(fontSize: 20.sp),
                                ),
                                prefixIcon: Icon(Icons.person),
                                border: UnderlineInputBorder(),
                              ),
                            ),
                            // defaultFormField(
                            //   controller: usernameController,
                            //   type: TextInputType.text,
                            //   validate: (String value) {
                            //     if (value.isEmpty) {
                            //       return 'يجب إدخال إسم المستخدم';
                            //     }
                            //     return null;
                            //   },
                            //   label: 'إسم المستخدم أو البريد الإلكتروني',
                            //   prefix: Icons.person,
                            // ),
                            SizedBox(
                              height: 20.h,
                            ),
                            TextFormField(
                              controller: passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'يجب إدخال كلمة المرور';
                                }
                                return null;
                              },
                              obscureText: LoginCubit.get(context).isPassword,
                              enabled: true,
                              decoration: InputDecoration(
                                label: Text(
                                  LocaleKeys.password.tr(),
                                  style: TextStyle(fontSize: 20.sp),
                                ),
                                prefixIcon: Icon(Icons.lock),
                                suffixIcon:
                                    Icon(LoginCubit.get(context).suffix) != null
                                        ? IconButton(
                                            onPressed: () {
                                              LoginCubit.get(context)
                                                  .changePasswordVisibility();
                                            },
                                            icon: Icon(
                                                LoginCubit.get(context).suffix),
                                          )
                                        : null,
                                border: UnderlineInputBorder(),
                              ),
                            ),
                            // defaultFormField(
                            //   controller: passwordController,
                            //   type: TextInputType.visiblePassword,
                            //   validate: (String value) {
                            //     if (value.isEmpty) {
                            //       return 'يجب إدخال كلمة الحماية';
                            //     }
                            //     return null;
                            //   },
                            //   label: 'كلمة الحماية',
                            //   prefix: Icons.lock,
                            //   suffix: LoginCubit.get(context).suffix,
                            //   isPassword: LoginCubit.get(context).isPassword,
                            //   suffixPressed: () {
                            //     LoginCubit.get(context)
                            //         .changePasswordVisibility();
                            //   },
                            // ),
                            SizedBox(
                              height: 60.h,
                            ),
                            Container(
                              width: 400.w,
                              height: 60.h,
                              decoration: BoxDecoration(
                                color: Colors.lightBlueAccent.shade400,
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Conditional.single(
                                context: context,
                                conditionBuilder: (context) =>
                                    state is! LoginLoadingState,
                                // State is! PostRegisterStateLoading,
                                widgetBuilder: (context) => TextButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      LoginCubit.get(context).userLogin(
                                        username: usernameController.text,
                                        password: passwordController.text,
                                      );
                                    }
                                    if (usernameController.text.isEmpty ||
                                        passwordController.text.isEmpty) {
                                      showToast(
                                          text:
                                              'يجب إدخال جميع البيانات السابقة.',
                                          state: ToastStates.ERROR);
                                    }
                                  },
                                  child: Text(
                                    LocaleKeys.sign_in.tr(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                ),
                                fallbackBuilder: (context) => Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                 LocaleKeys.dont_have_an_account.tr(),
                                  style: TextStyle(fontSize: 18.sp),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => RegisterScreen(),
                                        ));
                                  },
                                  child: Text(
                                    LocaleKeys.create_account_now.tr(),
                                    style: TextStyle(fontSize: 15.sp),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
