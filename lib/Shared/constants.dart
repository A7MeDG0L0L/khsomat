import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khsomat/data/cache_helper/cache_helper.dart';
import 'package:khsomat/presentation/UI/login_screen.dart';
import 'package:khsomat/presentation/UI/product_details_screen.dart';

const homeLayout = '/';
const productDetailsScreen = '/product_details_screen';
const registerScreen = '/register_screen';
const loginScreen = '/login_screen';
String? token = CacheHelper.getData(key: 'token');

void signOut(context) {
  CacheHelper.removeData(
    key: 'token',
  ).then((value) {
    if (value) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => Directionality(
                textDirection: TextDirection.rtl, child: LoginScreen()),
          ),
          (route) => false);
    }
  });
}
