import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:khsomat/Shared/components.dart';
import 'package:khsomat/Shared/constants.dart';
import 'package:khsomat/business_logic/login_cubit/login_cubit.dart';
import 'package:khsomat/business_logic/login_cubit/login_states.dart';

import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var usernameController = TextEditingController();
  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {},
        builder: (context, state) {
          // var model = LoginCubit.get(context).loginResponseModel;
          return Conditional.single(
            context: context,
            conditionBuilder: (context) =>
            username!=null&&email!=null,
                // username!.isNotEmpty && email!.isNotEmpty,
            widgetBuilder: (context) {
              usernameController.text = username!;
              emailController.text = email!;

              return Padding(
                padding: const EdgeInsets.all(25.0),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/avatar.png', height: 200),
                        defaultFormField(
                            controller: usernameController,
                            type: TextInputType.text,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'يجب إدخال إسم المستخدم';
                              }
                            },
                            label: 'إسم المستخدم',
                            prefix: Icons.person),
                        SizedBox(
                          height: 15,
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
                            prefix: Icons.person),
                        SizedBox(
                          height: 100,
                        ),
                        Container(
                          height: 70,
                          width: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.amber),
                          child: TextButton(
                            onPressed: () {
                              signOut(context);
                            },
                            child: Text(
                              'تسجيل الخروج',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            fallbackBuilder: (context) =>
                Center(child: TextButton(
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
                  child: Text('سجل الدخول الآن'),
                ),),
          );

          // usernameController.text = model!.data!.displayName!;
          // emailController.text = model.data!.email!;

          // return  Conditional.single(
          //   context: context,
          //   conditionBuilder: (context) =>model != null,
          //   widgetBuilder: (context) => Padding(
          //     padding: const EdgeInsets.all(25.0),
          //     child:Form(
          //       key:formKey,
          //       child: Column(
          //         children: [
          //           defaultFormField(
          //               controller: usernameController,
          //               type: TextInputType.text,
          //               validate: (String value) {
          //                 if (value.isEmpty) {
          //                   return 'يجب إدخال إسم المستخدم';
          //                 }
          //               },
          //               label: 'إسم المستخدم',
          //               prefix: Icons.person),
          //           SizedBox(height: 15,),
          //           defaultFormField(
          //               controller: emailController,
          //               type: TextInputType.emailAddress,
          //               validate: (String value) {
          //                 if (value.isEmpty) {
          //                   return 'يجب إدخال البريد الإلكتروني';
          //                 }
          //               },
          //               label: 'البريد الإلكتروني',
          //               prefix: Icons.person),
          //
          //         ],
          //       ),
          //     ),
          //   ),
          //   fallbackBuilder: (context) => Center(child: CircularProgressIndicator()),
          // );
        },
      ),
    );
  }
}
