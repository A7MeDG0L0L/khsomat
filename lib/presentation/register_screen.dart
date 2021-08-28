import 'package:flutter/material.dart';
import 'package:khsomat/Shared/components.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isPasswordShown=true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Image(
                image: AssetImage('assets/images/logo.png'),
              ),
              Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                          prefix: Icons.email),
                      SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'يجب إدخال الباسورد';
                            }
                          },
                          label: 'كلمة الحماية',
                          prefix: Icons.lock,
                          suffix: Icons.visibility,isPassword: isPasswordShown,suffixPressed:(){
                            isPasswordShown = !isPasswordShown;
                      }),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                          width: 400,
                          height: 60,
                          child: RaisedButton(
                            onPressed: () {
                                if(formKey.currentState!.validate()){

                                }
                            },
                            child: Text(
                              'تسجيل الحساب',
                              style:
                                  TextStyle(fontFamily: 'Almarai', fontSize: 20),
                            ),
                            textColor: Colors.white,
                            color: Colors.teal,
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
