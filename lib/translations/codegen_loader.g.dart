// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> ar = {
  "categories": "الأقسام",
  "new_products": "المنتجات الجديدة",
  "home": "الرئيسية",
  "favorites": "المفضلة",
  "cart": "السلة",
  "profile": "صفحتي",
  "my_profile": "ملفي الشخصي",
  "favorite_list": "قائمة المفضلة",
  "shopping_cart": "سلة التسوق",
  "my_orders": "طلباتي",
  "about_us": "من نحن",
  "logout": "تسجيل الخروج"
};
static const Map<String,dynamic> en = {
  "categories": "Categories",
  "new_products": "New Products",
  "home": "Home",
  "favorites": "Favorites",
  "cart": "Cart",
  "profile": "Profile",
  "my_profile": "My Profile",
  "favorite_list": "Favorite Items",
  "shopping_cart": "Shopping Cart",
  "my_orders": "My Orders",
  "about_us": "About us",
  "logout": "Logout"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"ar": ar, "en": en};
}
