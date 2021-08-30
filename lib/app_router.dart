import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khsomat/Shared/constants.dart';
import 'package:khsomat/data/models/products_model.dart';
import 'package:khsomat/presentation/UI/app_layout.dart';
import 'package:khsomat/presentation/UI/login_screen.dart';
import 'package:khsomat/presentation/UI/product_details_screen.dart';
import 'package:khsomat/presentation/register_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeLayout:
        return MaterialPageRoute(
          builder: (context) => Directionality(
            textDirection: TextDirection.rtl,
            child: AppLayout(),
          ),
        );
      case productDetailsScreen:
        final product = settings.arguments as Product;
        return MaterialPageRoute(
          builder: (context) => Directionality(
            textDirection: TextDirection.rtl,
            child: ProductDetailsScreen(
              product: product,
            ),
          ),
        );
      case registerScreen:
        return MaterialPageRoute(
          builder: (context) => Directionality(
            textDirection: TextDirection.rtl,
            child: RegisterScreen(),
          ),
        );
      case loginScreen:
        return MaterialPageRoute(
          builder: (context) => Directionality(
            textDirection: TextDirection.rtl,
            child: LoginScreen(),
          ),
        );
    }
  }
}
