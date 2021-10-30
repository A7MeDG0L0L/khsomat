import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khsomat/Shared/constants.dart';
import 'package:khsomat/presentation/UI/login_screen.dart';

class UserInfoScreen extends StatelessWidget {
  UserInfoScreen({Key? key}) : super(key: key);

  var firstnameController = TextEditingController();
  var lastnameController = TextEditingController();
  var emailController = TextEditingController();
  var usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ملفي الشخصي'),
      ),
      body: Conditional.single(
        context: context,
        conditionBuilder: (context) =>
            firstname!.isNotEmpty &&
            lastname!.isNotEmpty &&
            email!.isNotEmpty,
        widgetBuilder: (context) {
          firstnameController.text=firstname!;
          lastnameController.text=lastname!;
          emailController.text=email!;
          usernameController.text=username!;
          return Column(
            children: [
              TextFormField(
                controller: firstnameController,
                keyboardType: TextInputType.text,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'يجب إدخال المدينة';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  label: Text(
                    'الإسم الأول',
                    style: TextStyle(fontSize: 20.sp),
                  ),
                  border: UnderlineInputBorder(),
                ),
              ),
              TextFormField(
                controller: lastnameController,
                keyboardType: TextInputType.text,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'يجب إدخال الإسم الأخير';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  label: Text(
                    'الإسم الأخير',
                    style: TextStyle(fontSize: 20.sp),
                  ),
                  border: UnderlineInputBorder(),
                ),
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
                    'إسم المستخدم',
                    style: TextStyle(fontSize: 20.sp),
                  ),
                  prefixIcon: Icon(Icons.verified_user),
                  border: UnderlineInputBorder(),
                ),
              ),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'يجب إدخال البريد الإلكتروني';
                  } else if (value.isNotEmpty) {
                    // EmailValidator.validate(value);
                    if (EmailValidator.validate(value) == false) {
                      return 'يجب إدخال بريد إلكتروني صحيح';
                    }
                  }

                  return null;
                },
                decoration: InputDecoration(
                  label: Text(
                    'البريد الإلكتروني',
                    style: TextStyle(fontSize: 20.sp),
                  ),
                  prefixIcon: Icon(Icons.email),
                  border: UnderlineInputBorder(),
                ),
              ),
            ],
          );
        },
        fallbackBuilder: (context) {
          return TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Directionality(
                    textDirection: TextDirection.rtl, child: LoginScreen()),
              ));
            },
            child: Text('سجل الدخول'),
          );
        },
      ),
    );
  }
}
