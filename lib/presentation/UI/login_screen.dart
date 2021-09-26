import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:khsomat/Shared/components.dart';
import 'package:khsomat/Shared/constants.dart';
import 'package:khsomat/business_logic/login_cubit/login_cubit.dart';
import 'package:khsomat/business_logic/login_cubit/login_states.dart';
import 'package:khsomat/data/cache_helper/cache_helper.dart';

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
            showToast(
                text: 'تم التحقق',
                state: ToastStates.SUCCESS);
            if (state.loginResponseModel.success!) {
              print(state.loginResponseModel.message);
              print(state.loginResponseModel.data!.token);
              CacheHelper.saveData(
                key: 'token',
                value: state.loginResponseModel.data!.token,
              );
              CacheHelper.saveData(key: 'email', value: state.loginResponseModel.data!.email);
              CacheHelper.saveData(key: 'username', value: state.loginResponseModel.data!.displayName).then((value) {
                 token = state.loginResponseModel.data!.token!;
                 email = state.loginResponseModel.data!.email!;
                 username = state.loginResponseModel.data!.displayName!;
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Directionality(
                        textDirection: TextDirection.rtl,
                        child: AppLayout(),
                      ),
                    ),
                    (route) => false);
              });
            }
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
                            builder: (context) => Directionality(
                                textDirection: TextDirection.rtl,
                                child: AppLayout()),
                          ),
                        );
                      },
                      child: Text('تخطي'),
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
                                image: AssetImage('assets/images/logoo.png'),
                                height: 200,
                              ),
                            ),
                            Text(
                              'سجل الدخول إلي حسابك',
                              style: TextStyle(fontSize: 25),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'للتسوق متعة مع خصومات',
                              style: TextStyle(fontSize: 15),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            defaultFormField(
                              controller: usernameController,
                              type: TextInputType.text,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'يجب إدخال إسم المستخدم';
                                }
                                return null;
                              },
                              label: 'إسم المستخدم أو البريد الإلكتروني',
                              prefix: Icons.person,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            defaultFormField(
                              controller: passwordController,
                              type: TextInputType.visiblePassword,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'يجب إدخال كلمة الحماية';
                                }
                                return null;
                              },
                              label: 'كلمة الحماية',
                              prefix: Icons.lock,
                              suffix: LoginCubit.get(context).suffix,
                              isPassword: LoginCubit.get(context).isPassword,
                              suffixPressed: () {
                                LoginCubit.get(context)
                                    .changePasswordVisibility();
                              },
                            ),
                            SizedBox(
                              height: 60,
                            ),
                            Container(
                              width: 400,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.teal,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Conditional.single(
                                context: context,
                                conditionBuilder: (context) => state is! LoginLoadingState,
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
                                    'سجل الدخول',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                fallbackBuilder: (context) =>
                                    Center(child: CircularProgressIndicator()),
                              ),
                            ),
                            SizedBox(
                              height: 20,
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
