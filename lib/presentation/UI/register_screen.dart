import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khsomat/Shared/components.dart';
import 'package:khsomat/business_logic/register_cubit/register_cubit.dart';
import 'package:khsomat/business_logic/register_cubit/register_states.dart';
import 'package:khsomat/presentation/UI/app_layout.dart';
import 'package:khsomat/presentation/UI/login_screen.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();

  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var firstnameController = TextEditingController();
  var lastnameController = TextEditingController();
  // static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is PostRegisterStateSuccess) {
            // showToast(
            //   text: state.registerModelTest.message,
            //   state: ToastStates.SUCCESS,
            // );
            showToast(
                text: 'تم إنشاء الحساب بنجاح', state: ToastStates.SUCCESS);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => Directionality(
                    textDirection: TextDirection.rtl,
                    child: LoginScreen(),
                  ),
                ),
                (route) => false);
          }
          if (state is PostRegisterStateError) {
            //   showToast(
            //       text: state.registerModelTest.message,
            //       state: ToastStates.ERROR);

            showToast(
              text: 'رجاء إدخال اسم مستخدم و كلمة مرور و بريد إلكتروني آخر',
              state: ToastStates.ERROR,
            );
          }
        },
        builder: (context, state) {
          // late  var responseModel = RegisterCubit.get(context).userResponseModel;
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
                      child: Text('تخطي',style: TextStyle(fontSize: 16.sp),),
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
                              'إنشاء حساب جديد',
                              style: TextStyle(fontSize: 25.sp),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              'إكتشف معني العروض الحقيقي مع خصومات',
                              style: TextStyle(fontSize: 15.sp,color: Colors.grey.shade500),
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  width: 150.w,
                                  child: TextFormField(
                                    controller: firstnameController,
                                    keyboardType: TextInputType.text,
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'يجب إدخال إسم الأول';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      label: Text('الإسم الأول',style: TextStyle(fontSize: 20.sp),),
                                      prefixIcon: Icon(Icons.person),
                                      border: UnderlineInputBorder(),
                                    ),
                                  ),
                                ),
                                // SizedBox(
                                //   height: 20,
                                //   width: 30,
                                // ),
                                Spacer(),
                                Container(
                                  width: 150.w,
                                  child: TextFormField(
                                    controller: lastnameController,
                                    keyboardType: TextInputType.text,
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'يجب إدخال إسم الأخير';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      label: Text('الإسم الأخير'),
                                      prefixIcon: Icon(Icons.person),
                                      border: UnderlineInputBorder(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20.h,
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
                                label: Text('إسم المستخدم',style: TextStyle(fontSize: 20.sp),),
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
                            //   },
                            //   label: 'إسم المستخدم',
                            //   prefix: Icons.person,
                            // ),
                            SizedBox(
                              height: 20.h,
                            ),
                            TextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'يجب إدخال البريد الإلكتروني';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                label: Text('البريد الإلكتروني',style: TextStyle(fontSize: 20.sp),),
                                prefixIcon: Icon(Icons.email),
                                border: UnderlineInputBorder(),
                              ),
                            ),
                            // defaultFormField(
                            //   controller: emailController,
                            //   type: TextInputType.emailAddress,
                            //   validate: (String value) {
                            //     if (value.isEmpty) {
                            //       return 'يجب إدخال البريد الإلكتروني';
                            //     }
                            //     return null;
                            //   },
                            //   label: 'البريد الإلكتروني',
                            //   prefix: Icons.email,
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
                              obscureText:
                                  RegisterCubit.get(context).isPassword,
                              enabled: true,
                              decoration: InputDecoration(
                                label: Text('كلمة المرور',style: TextStyle(fontSize: 20.sp),),
                                prefixIcon: Icon(Icons.lock),
                                suffixIcon:
                                    Icon(RegisterCubit.get(context).suffix) !=
                                            null
                                        ? IconButton(
                                            onPressed: () {
                                              RegisterCubit.get(context)
                                                  .changePasswordVisibility();
                                            },
                                            icon: Icon(
                                                RegisterCubit.get(context)
                                                    .suffix),
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
                            //   },
                            //   label: 'كلمة الحماية',
                            //   prefix: Icons.lock,
                            //   suffix: RegisterCubit.get(context).suffix,
                            //   isPassword: RegisterCubit.get(context).isPassword,
                            //   suffixPressed: () {
                            //     RegisterCubit.get(context)
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
                                color: Colors.lightBlue.shade600,
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Conditional.single(
                                context: context,
                                conditionBuilder: (context) =>
                                    State is! PostRegisterStateLoading,
                                widgetBuilder: (context) => TextButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      RegisterCubit.get(context).userRegister(
                                        username: usernameController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                        firstname: firstnameController.text,
                                        lastname: lastnameController.text,
                                      );
                                    }
                                    if (emailController.text.isEmpty ||
                                        usernameController.text.isEmpty ||
                                        passwordController.text.isEmpty || firstnameController.text.isEmpty || lastnameController.text.isEmpty) {
                                      showToast(
                                          text:
                                              'يجب إدخال جميع البيانات السابقة.',
                                          state: ToastStates.ERROR);
                                    }

                                    // showToast(text: responseModel.message , state: ToastStates.SUCCESS);
                                    // print(responseModel.message);
                                  },
                                  child: Text(
                                    'إنشاء الحساب',
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
                                Text('لديك حساب بالفعل ؟',style: TextStyle(fontSize: 20.sp),),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: LoginScreen(),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text('سجل الدخول',style: TextStyle(fontSize: 20.sp),),
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
