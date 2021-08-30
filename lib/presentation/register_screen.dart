import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:khsomat/Shared/components.dart';
import 'package:khsomat/business_logic/register_cubit/register_cubit.dart';
import 'package:khsomat/business_logic/register_cubit/register_states.dart';
import 'package:khsomat/presentation/UI/app_layout.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

   var usernameController = TextEditingController();
   var emailController = TextEditingController();
   var passwordController = TextEditingController();
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //var formKey = GlobalKey<FormState>();
  bool isPasswordShown = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          // if (state is PostRegisterStateSuccess) {
          //   showToast(
          //     text: state.userResponseModel.message,
          //     state: ToastStates.SUCCESS,
          //   );
          //   Navigator.pushAndRemoveUntil(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => Directionality(
          //           textDirection: TextDirection.rtl,
          //           child: AppLayout(),
          //         ),
          //       ),
          //       (route) => false);
          // }
          // if (state is PostRegisterStateError) {
          //   showToast(
          //       text: state.userResponseModel.message,
          //       state: ToastStates.ERROR);
          // }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Form(
                      key: formKey,
                      child: Column(
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
                          Image(
                            image: AssetImage('assets/images/logoo.png'),
                          ),
                          defaultFormField(
                            controller: usernameController,
                            type: TextInputType.text,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'يجب إدخال إسم المستخدم';
                              }
                            },
                            label: 'إسم المستخدم',
                            prefix: Icons.person,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'يجب إدخال البريد الإلكتروني';
                              }
                            },
                            label: 'البريد الإلكتروني',
                            prefix: Icons.email,),
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
                            },
                            label: 'كلمة الحماية',
                            prefix: Icons.lock,
                            suffix: Icons.visibility,
                            isPassword: isPasswordShown,
                            suffixPressed: () {
                              isPasswordShown = !isPasswordShown;
                            },),
                          SizedBox(
                            height: 60,
                          ),
                          Container(
                            width: 400,
                            height: 60,
                            color: Colors.teal,
                            child: Conditional.single(
                              context: context,
                              conditionBuilder: (context) =>
                              State is! PostRegisterStateLoading,
                              widgetBuilder: (context) => TextButton(
                                onPressed: () {
                                  if (formKey.currentState!
                                      .validate()==true) {
                                    RegisterCubit.get(context)
                                        .userRegister(
                                      username: usernameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                },
                                child: Text(
                                  'تسجيل الحساب',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              fallbackBuilder: (context) => Center(
                                  child: CircularProgressIndicator()),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
