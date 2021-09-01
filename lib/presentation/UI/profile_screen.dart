import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:khsomat/Shared/components.dart';
import 'package:khsomat/business_logic/login_cubit/login_cubit.dart';
import 'package:khsomat/business_logic/login_cubit/login_states.dart';

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
        listener: (context, state) {

        },
        builder: (context, state) {
         // var model = LoginCubit.get(context).loginResponseModel;
          if(state is LoginSuccessState){
            var model = state.loginResponseModel;
            usernameController.text = model.data!.displayName!;
             emailController.text = model.data!.email!;
            return  Conditional.single(
              context: context,
              conditionBuilder: (context) =>model != null,
              widgetBuilder: (context) => Padding(
                padding: const EdgeInsets.all(25.0),
                child:Form(
                  key:formKey,
                  child: Column(
                    children: [
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
                      SizedBox(height: 15,),
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

                    ],
                  ),
                ),
              ),
              fallbackBuilder: (context) => Center(child: CircularProgressIndicator()),
            );
          }
          else{
            return CircularProgressIndicator();
          }

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
