import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khsomat/data/cache_helper/cache_helper.dart';
import 'package:khsomat/data/models/products_model.dart';
import 'package:khsomat/presentation/UI/login_screen.dart';

const homeLayout = '/';
const productDetailsScreen = '/product_details_screen';
const favoritesScreen = '/product_details_screen';
const registerScreen = '/register_screen';
const loginScreen = '/login_screen';
String? token = CacheHelper.getData(key: 'token');
String? email = CacheHelper.getData(key: 'email');
String? username = CacheHelper.getData(key: 'username');
String? firstname = CacheHelper.getData(key: 'firstname');
String? lastname = CacheHelper.getData(key: 'lastname');
String? phone = CacheHelper.getData(key: 'phone');
String? city = CacheHelper.getData(key: 'city');
String? address = CacheHelper.getData(key: 'address');
int? total = CacheHelper.getData(key: 'total');
int? id = CacheHelper.getData(key: 'userID');


dynamic convertPrice(int length,Map model) {
  if (model['saleprice'].length == length) {
    String price = model['saleprice'];
    String stringPrice = price.substring(0, length - 2);
    int parsePrice = int.parse(stringPrice);
    return parsePrice;
  }
}
//String? stringFavList = CacheHelper.sharedPreferences.getString('favList');
// List<Map<String,dynamic>> stringFavList = [
//   {
//     "id": 49421,
//     "name": "زيت شعر كيان kayan لإطاله الشعر 200 مللي",
//     "parent": 0,
//     "type": "simple",
//     "variation": "",
//     "permalink": "https://khsomat.com/product/%d8%b2%d9%8a%d8%aa-%d8%b4%d8%b9%d8%b1-%d9%83%d9%8a%d8%a7%d9%86-kayan-%d9%84%d8%a5%d8%b7%d8%a7%d9%84%d9%87-%d8%a7%d9%84%d8%b4%d8%b9%d8%b1-200-%d9%85%d9%84%d9%84%d9%8a/",
//     "sku": "",
//     "short_description": "<div class=\"o9v6fnle cxmmr5t8 oygrvhab hcukyx3x c1et5uql ii04i59q\">\n<div dir=\"auto\">( لون العبوه أحمر ) لإطاله الشعر 200 مللي</div>\n</div>\n<div class=\"o9v6fnle cxmmr5t8 oygrvhab hcukyx3x c1et5uql ii04i59q\">\n<div dir=\"auto\">&#8211; بيثقل الشعر الخفيف ويطوله من واحد سم الى 2 سم كل عشره ايام .</div>\n</div>\n<div class=\"o9v6fnle cxmmr5t8 oygrvhab hcukyx3x c1et5uql ii04i59q\">\n<div dir=\"auto\">-غنى جدأ بزيت حبه البركة اللى بيعمل على إطاله الشعر وتتقيل فتله الشعر من الجذور الى الأطراف ..</div>\n</div>\n<div class=\"o9v6fnle cxmmr5t8 oygrvhab hcukyx3x c1et5uql ii04i59q\">\n<div dir=\"auto\">&#8211; آمن علي الأطفال من عمر سنة</div>\n<div dir=\"auto\">&#8211; و لا يحتوي على أى مواد كيمائية</div>\n<div dir=\"auto\">&#8211; و ليس له اثار جانبية</div>\n</div>",
//     "description": "<div class=\"o9v6fnle cxmmr5t8 oygrvhab hcukyx3x c1et5uql ii04i59q\">\n<div dir=\"auto\">( لون العبوه أحمر ) لإطاله الشعر 200 مللي</div>\n</div>\n<div class=\"o9v6fnle cxmmr5t8 oygrvhab hcukyx3x c1et5uql ii04i59q\">\n<div dir=\"auto\">&#8211; بيثقل الشعر الخفيف ويطوله من واحد سم الى 2 سم كل عشره ايام .</div>\n</div>\n<div class=\"o9v6fnle cxmmr5t8 oygrvhab hcukyx3x c1et5uql ii04i59q\">\n<div dir=\"auto\">-غنى جدأ بزيت حبه البركة اللى بيعمل على إطاله الشعر وتتقيل فتله الشعر من الجذور الى الأطراف ..</div>\n</div>\n<div class=\"o9v6fnle cxmmr5t8 oygrvhab hcukyx3x c1et5uql ii04i59q\">\n<div dir=\"auto\">&#8211; آمن علي الأطفال من عمر سنة</div>\n<div dir=\"auto\">&#8211; و لا يحتوي على أى مواد كيمائية</div>\n<div dir=\"auto\">&#8211; و ليس له اثار جانبية</div>\n</div>",
//     "on_sale": true,
//     "prices": {
//       "price": "7500",
//       "regular_price": "10000",
//       "sale_price": "7500",
//       "price_range": null,
//       "currency_code": "EGP",
//       "currency_symbol": "EGP",
//       "currency_minor_unit": 2,
//       "currency_decimal_separator": ".",
//       "currency_thousand_separator": ",",
//       "currency_prefix": "EGP ",
//       "currency_suffix": ""
//     },
//     "price_html": "<del aria-hidden=\"true\"><span class=\"woocommerce-Price-amount amount\"><span class=\"woocommerce-Price-currencySymbol\">EGP</span>&nbsp;100.00</span></del> <ins><span class=\"woocommerce-Price-amount amount\"><span class=\"woocommerce-Price-currencySymbol\">EGP</span>&nbsp;75.00</span></ins>",
//     "average_rating": "0",
//     "review_count": 0,
//     "images": [
//       {
//         "id": 49422,
//         "src": "https://khsomat.com/wp-content/uploads/2021/08/gfgfgfg.jpg",
//         "thumbnail": "https://khsomat.com/wp-content/uploads/2021/08/gfgfgfg-283x283.jpg",
//         "srcset": "https://khsomat.com/wp-content/uploads/2021/08/gfgfgfg.jpg 500w, https://khsomat.com/wp-content/uploads/2021/08/gfgfgfg-300x300.jpg 300w, https://khsomat.com/wp-content/uploads/2021/08/gfgfgfg-150x150.jpg 150w, https://khsomat.com/wp-content/uploads/2021/08/gfgfgfg-283x283.jpg 283w, https://khsomat.com/wp-content/uploads/2021/08/gfgfgfg-100x100.jpg 100w",
//         "sizes": "(max-width: 500px) 100vw, 500px",
//         "name": "gfgfgfg",
//         "alt": "زيت لاطاله الشعر"
//       },
//       {
//         "id": 49423,
//         "src": "https://khsomat.com/wp-content/uploads/2021/08/130734714_207407050855691_4963428878614217309_n.jpg",
//         "thumbnail": "https://khsomat.com/wp-content/uploads/2021/08/130734714_207407050855691_4963428878614217309_n-283x283.jpg",
//         "srcset": "https://khsomat.com/wp-content/uploads/2021/08/130734714_207407050855691_4963428878614217309_n.jpg 500w, https://khsomat.com/wp-content/uploads/2021/08/130734714_207407050855691_4963428878614217309_n-300x300.jpg 300w, https://khsomat.com/wp-content/uploads/2021/08/130734714_207407050855691_4963428878614217309_n-150x150.jpg 150w, https://khsomat.com/wp-content/uploads/2021/08/130734714_207407050855691_4963428878614217309_n-283x283.jpg 283w, https://khsomat.com/wp-content/uploads/2021/08/130734714_207407050855691_4963428878614217309_n-100x100.jpg 100w",
//         "sizes": "(max-width: 500px) 100vw, 500px",
//         "name": "130734714_207407050855691_4963428878614217309_n",
//         "alt": ""
//       }
//     ],
//     "categories": [
//       {
//         "id": 910,
//         "name": "اجهزه ومستحضرات العنايه بالشعر",
//         "slug": "%d8%a7%d8%ac%d9%87%d8%b2%d9%87-%d9%88%d9%85%d8%b3%d8%aa%d8%ad%d8%b6%d8%b1%d8%a7%d8%aa-%d8%a7%d9%84%d8%b9%d9%86%d8%a7%d9%8a%d9%87-%d8%a8%d8%a7%d9%84%d8%b4%d8%b9%d8%b1",
//         "link": "https://khsomat.com/product-category/%d8%a7%d9%84%d8%b5%d8%ad%d9%87-%d9%88%d8%a7%d9%84%d8%ac%d9%85%d8%a7%d9%84/%d8%a7%d8%ac%d9%87%d8%b2%d9%87-%d9%88%d9%85%d8%b3%d8%aa%d8%ad%d8%b6%d8%b1%d8%a7%d8%aa-%d8%a7%d9%84%d8%b9%d9%86%d8%a7%d9%8a%d9%87-%d8%a8%d8%a7%d9%84%d8%b4%d8%b9%d8%b1/"
//       }
//     ],
//     "tags": [],
//     "attributes": [],
//     "variations": [],
//     "has_options": false,
//     "is_purchasable": true,
//     "is_in_stock": true,
//     "is_on_backorder": false,
//     "low_stock_remaining": null,
//     "sold_individually": false,
//     "quantity_limit": 99,
//     "add_to_cart": {
//       "text": "إضافة إلى السلة",
//       "description": "إضافة &#8220;زيت شعر كيان kayan لإطاله الشعر 200 مللي&#8221; إلى سلة مشترياتك",
//       "url": "?add-to-cart=49421"
//     }
//   },
//   {
//     "id": 49381,
//     "name": "زيت شعر كيان kayan للفرد 200 مللي",
//     "parent": 0,
//     "type": "simple",
//     "variation": "",
//     "permalink": "https://khsomat.com/product/%d8%b2%d9%8a%d8%aa-%d8%b4%d8%b9%d8%b1-%d9%83%d9%8a%d8%a7%d9%86-%d9%84%d9%84%d9%81%d8%b1%d8%af-200-%d9%85%d9%84%d9%84%d9%8a/",
//     "sku": "",
//     "short_description": "<div class=\"o9v6fnle cxmmr5t8 oygrvhab hcukyx3x c1et5uql ii04i59q\">\n<div dir=\"auto\">زيت كيان ( العبوة الزرقاء ) 200 مللي</div>\n</div>\n<div class=\"o9v6fnle cxmmr5t8 oygrvhab hcukyx3x c1et5uql ii04i59q\">\n<div dir=\"auto\">&#8211; بيفرد الشعر المجعد فرد طبيعي تدريجي</div>\n</div>\n<div class=\"o9v6fnle cxmmr5t8 oygrvhab hcukyx3x c1et5uql ii04i59q\">\n<div dir=\"auto\">&#8211; بيمنع الهيشان و التقصف</div>\n</div>\n<div class=\"o9v6fnle cxmmr5t8 oygrvhab hcukyx3x c1et5uql ii04i59q\">\n<div dir=\"auto\">&#8211; آمن علي الاطفال من عمر سنه</div>\n<div dir=\"auto\">&#8211; و لا يحتوي علي اي مواد كيمائيه</div>\n<div dir=\"auto\">&#8211; و ليس له اثار جانبيه</div>\n</div>",
//     "description": "<p>هذه التركيبه الفريده من الزيوت الطبيعيه والفيتامينات تتغلعل الي بصيلات الشعر فتساعد علي تغذيه الشعر وتقويه وتمنحه لمعان ونعومه وتضفي عليه ملمسا كالحرير</p>\n<p>زي<span style=\"font-size: 1rem\">ت كيان ( العبوة الزرقاء ) 200 مللي</span></p>\n<div class=\"o9v6fnle cxmmr5t8 oygrvhab hcukyx3x c1et5uql ii04i59q\">\n<div dir=\"auto\">تقدري تعتبريه بديل صحي للبروتين و الكيرياتين</div>\n</div>\n<div class=\"o9v6fnle cxmmr5t8 oygrvhab hcukyx3x c1et5uql ii04i59q\">\n<div dir=\"auto\">&#8211; بيفرد الشعر المجعد فرد طبيعي تدريجي</div>\n</div>\n<div class=\"o9v6fnle cxmmr5t8 oygrvhab hcukyx3x c1et5uql ii04i59q\">\n<div dir=\"auto\">&#8211; بيمنع الهيشان و التقصف</div>\n</div>\n<div class=\"o9v6fnle cxmmr5t8 oygrvhab hcukyx3x c1et5uql ii04i59q\">\n<div dir=\"auto\">&#8211; آمن علي الاطفال من عمر سنه</div>\n<div dir=\"auto\">&#8211; و لا يحتوي علي اي مواد كيمائيه</div>\n<div dir=\"auto\">&#8211; و ليس له اثار جانبيه</div>\n</div>\n<div class=\"o9v6fnle cxmmr5t8 oygrvhab hcukyx3x c1et5uql ii04i59q\"></div>",
//     "on_sale": true,
//     "prices": {
//       "price": "7500",
//       "regular_price": "9000",
//       "sale_price": "7500",
//       "price_range": null,
//       "currency_code": "EGP",
//       "currency_symbol": "EGP",
//       "currency_minor_unit": 2,
//       "currency_decimal_separator": ".",
//       "currency_thousand_separator": ",",
//       "currency_prefix": "EGP ",
//       "currency_suffix": ""
//     },
//     "price_html": "<del aria-hidden=\"true\"><span class=\"woocommerce-Price-amount amount\"><span class=\"woocommerce-Price-currencySymbol\">EGP</span>&nbsp;90.00</span></del> <ins><span class=\"woocommerce-Price-amount amount\"><span class=\"woocommerce-Price-currencySymbol\">EGP</span>&nbsp;75.00</span></ins>",
//     "average_rating": "0",
//     "review_count": 0,
//     "images": [
//       {
//         "id": 49391,
//         "src": "https://khsomat.com/wp-content/uploads/2021/08/ghgfghfdgifdghg.jpg",
//         "thumbnail": "https://khsomat.com/wp-content/uploads/2021/08/ghgfghfdgifdghg-283x283.jpg",
//         "srcset": "https://khsomat.com/wp-content/uploads/2021/08/ghgfghfdgifdghg.jpg 500w, https://khsomat.com/wp-content/uploads/2021/08/ghgfghfdgifdghg-300x300.jpg 300w, https://khsomat.com/wp-content/uploads/2021/08/ghgfghfdgifdghg-150x150.jpg 150w, https://khsomat.com/wp-content/uploads/2021/08/ghgfghfdgifdghg-283x283.jpg 283w, https://khsomat.com/wp-content/uploads/2021/08/ghgfghfdgifdghg-100x100.jpg 100w",
//         "sizes": "(max-width: 500px) 100vw, 500px",
//         "name": "ghgfghfdgifdghg",
//         "alt": "زيت شعر للفرد"
//       },
//       {
//         "id": 49393,
//         "src": "https://khsomat.com/wp-content/uploads/2021/08/130752994_207417164188013_779802689910812778_n.jpg",
//         "thumbnail": "https://khsomat.com/wp-content/uploads/2021/08/130752994_207417164188013_779802689910812778_n-283x283.jpg",
//         "srcset": "https://khsomat.com/wp-content/uploads/2021/08/130752994_207417164188013_779802689910812778_n.jpg 500w, https://khsomat.com/wp-content/uploads/2021/08/130752994_207417164188013_779802689910812778_n-300x300.jpg 300w, https://khsomat.com/wp-content/uploads/2021/08/130752994_207417164188013_779802689910812778_n-150x150.jpg 150w, https://khsomat.com/wp-content/uploads/2021/08/130752994_207417164188013_779802689910812778_n-283x283.jpg 283w, https://khsomat.com/wp-content/uploads/2021/08/130752994_207417164188013_779802689910812778_n-100x100.jpg 100w",
//         "sizes": "(max-width: 500px) 100vw, 500px",
//         "name": "130752994_207417164188013_779802689910812778_n",
//         "alt": ""
//       }
//     ],
//     "categories": [
//       {
//         "id": 910,
//         "name": "اجهزه ومستحضرات العنايه بالشعر",
//         "slug": "%d8%a7%d8%ac%d9%87%d8%b2%d9%87-%d9%88%d9%85%d8%b3%d8%aa%d8%ad%d8%b6%d8%b1%d8%a7%d8%aa-%d8%a7%d9%84%d8%b9%d9%86%d8%a7%d9%8a%d9%87-%d8%a8%d8%a7%d9%84%d8%b4%d8%b9%d8%b1",
//         "link": "https://khsomat.com/product-category/%d8%a7%d9%84%d8%b5%d8%ad%d9%87-%d9%88%d8%a7%d9%84%d8%ac%d9%85%d8%a7%d9%84/%d8%a7%d8%ac%d9%87%d8%b2%d9%87-%d9%88%d9%85%d8%b3%d8%aa%d8%ad%d8%b6%d8%b1%d8%a7%d8%aa-%d8%a7%d9%84%d8%b9%d9%86%d8%a7%d9%8a%d9%87-%d8%a8%d8%a7%d9%84%d8%b4%d8%b9%d8%b1/"
//       }
//     ],
//     "tags": [],
//     "attributes": [],
//     "variations": [],
//     "has_options": false,
//     "is_purchasable": true,
//     "is_in_stock": true,
//     "is_on_backorder": false,
//     "low_stock_remaining": null,
//     "sold_individually": false,
//     "quantity_limit": 99,
//     "add_to_cart": {
//       "text": "إضافة إلى السلة",
//       "description": "إضافة &#8220;زيت شعر كيان kayan للفرد 200 مللي&#8221; إلى سلة مشترياتك",
//       "url": "?add-to-cart=49381"
//     }
//   },
//   {
//     "id": 49375,
//     "name": "زيت شعر كيان kayan المعالج 200 مللي",
//     "parent": 0,
//     "type": "simple",
//     "variation": "",
//     "permalink": "https://khsomat.com/product/%d8%b2%d9%8a%d8%aa-%d8%b4%d8%b9%d8%b1-%d9%83%d9%8a%d8%a7%d9%86-%d8%a7%d9%84%d9%85%d8%b9%d8%a7%d9%84%d8%ac-200-%d9%85%d9%84%d9%84%d9%8a/",
//     "sku": "",
//     "short_description": "<p>هذه التركيبه الفريده من الزيوت الطبيعيه والفيتامينات تتغلعل الي بصيلات الشعر فتساعد علي تغذيه الشعر وتقويه وتمنحه لمعان ونعومه وتضفي عليه ملمسا كالحرير</p>",
//     "description": "<div class=\"o9v6fnle cxmmr5t8 oygrvhab hcukyx3x c1et5uql ii04i59q\">\n<div dir=\"auto\">زيت الشعر كيان</div>\n</div>\n<div class=\"o9v6fnle cxmmr5t8 oygrvhab hcukyx3x c1et5uql ii04i59q\">\n<div dir=\"auto\">المعالج ( لون العبوه اسود )</div>\n</div>\n<div class=\"o9v6fnle cxmmr5t8 oygrvhab hcukyx3x c1et5uql ii04i59q\">\n<div dir=\"auto\">بيعالج الصلع الغير وراثي و الثعلبه ..</div>\n</div>\n<div class=\"o9v6fnle cxmmr5t8 oygrvhab hcukyx3x c1et5uql ii04i59q\">\n<div dir=\"auto\">غني جدا ب زيت الثوم الطبيعي ١٠٠% الذي يعمل كمضاد حيوي لفروه الراس .</div>\n</div>\n<div class=\"o9v6fnle cxmmr5t8 oygrvhab hcukyx3x c1et5uql ii04i59q\">\n<div dir=\"auto\">يعمل علي :</div>\n<div dir=\"auto\">&#8211; تعزيز البصيلات الميته و نموها بشكل ملحوظ و سريع ..</div>\n<div dir=\"auto\">&#8211; يعمل علي تقويه بصيلات الشعر</div>\n</div>\n<div class=\"o9v6fnle cxmmr5t8 oygrvhab hcukyx3x c1et5uql ii04i59q\">\n<div dir=\"auto\">&#8211; مكونه من افضل الزيوت الطبيعيه</div>\n<div dir=\"auto\">&#8211; امنه تماماً على الاطفال من عمر سنه</div>\n<div dir=\"auto\">&#8211; آمن جدا في فتره الحمل والرضاعه</div>\n<div dir=\"auto\">&#8211; يمنع تقصف الشعر تماماً</div>\n<div dir=\"auto\">&#8211; ولا يوجد له اي اثار جانبيه</div>\n<div dir=\"auto\">&#8211; ولا يوجد به اي مواد كيمائيه</div>\n</div>",
//     "on_sale": true,
//     "prices": {
//       "price": "7500",
//       "regular_price": "9000",
//       "sale_price": "7500",
//       "price_range": null,
//       "currency_code": "EGP",
//       "currency_symbol": "EGP",
//       "currency_minor_unit": 2,
//       "currency_decimal_separator": ".",
//       "currency_thousand_separator": ",",
//       "currency_prefix": "EGP ",
//       "currency_suffix": ""
//     },
//     "price_html": "<del aria-hidden=\"true\"><span class=\"woocommerce-Price-amount amount\"><span class=\"woocommerce-Price-currencySymbol\">EGP</span>&nbsp;90.00</span></del> <ins><span class=\"woocommerce-Price-amount amount\"><span class=\"woocommerce-Price-currencySymbol\">EGP</span>&nbsp;75.00</span></ins>",
//     "average_rating": "0",
//     "review_count": 0,
//     "images": [
//       {
//         "id": 49376,
//         "src": "https://khsomat.com/wp-content/uploads/2021/08/117402915_126906048930580_1113955695059985526_n.jpg",
//         "thumbnail": "https://khsomat.com/wp-content/uploads/2021/08/117402915_126906048930580_1113955695059985526_n-283x283.jpg",
//         "srcset": "https://khsomat.com/wp-content/uploads/2021/08/117402915_126906048930580_1113955695059985526_n.jpg 500w, https://khsomat.com/wp-content/uploads/2021/08/117402915_126906048930580_1113955695059985526_n-300x300.jpg 300w, https://khsomat.com/wp-content/uploads/2021/08/117402915_126906048930580_1113955695059985526_n-150x150.jpg 150w, https://khsomat.com/wp-content/uploads/2021/08/117402915_126906048930580_1113955695059985526_n-283x283.jpg 283w, https://khsomat.com/wp-content/uploads/2021/08/117402915_126906048930580_1113955695059985526_n-100x100.jpg 100w",
//         "sizes": "(max-width: 500px) 100vw, 500px",
//         "name": "117402915_126906048930580_1113955695059985526_n",
//         "alt": "زيت كيان المعالج"
//       },
//       {
//         "id": 49380,
//         "src": "https://khsomat.com/wp-content/uploads/2021/08/130268426_207413864188343_7754835803590913678_n.jpg",
//         "thumbnail": "https://khsomat.com/wp-content/uploads/2021/08/130268426_207413864188343_7754835803590913678_n-283x283.jpg",
//         "srcset": "https://khsomat.com/wp-content/uploads/2021/08/130268426_207413864188343_7754835803590913678_n.jpg 843w, https://khsomat.com/wp-content/uploads/2021/08/130268426_207413864188343_7754835803590913678_n-300x300.jpg 300w, https://khsomat.com/wp-content/uploads/2021/08/130268426_207413864188343_7754835803590913678_n-150x150.jpg 150w, https://khsomat.com/wp-content/uploads/2021/08/130268426_207413864188343_7754835803590913678_n-768x768.jpg 768w, https://khsomat.com/wp-content/uploads/2021/08/130268426_207413864188343_7754835803590913678_n-283x283.jpg 283w, https://khsomat.com/wp-content/uploads/2021/08/130268426_207413864188343_7754835803590913678_n-100x100.jpg 100w",
//         "sizes": "(max-width: 843px) 100vw, 843px",
//         "name": "130268426_207413864188343_7754835803590913678_n",
//         "alt": ""
//       }
//     ],
//     "categories": [
//       {
//         "id": 910,
//         "name": "اجهزه ومستحضرات العنايه بالشعر",
//         "slug": "%d8%a7%d8%ac%d9%87%d8%b2%d9%87-%d9%88%d9%85%d8%b3%d8%aa%d8%ad%d8%b6%d8%b1%d8%a7%d8%aa-%d8%a7%d9%84%d8%b9%d9%86%d8%a7%d9%8a%d9%87-%d8%a8%d8%a7%d9%84%d8%b4%d8%b9%d8%b1",
//         "link": "https://khsomat.com/product-category/%d8%a7%d9%84%d8%b5%d8%ad%d9%87-%d9%88%d8%a7%d9%84%d8%ac%d9%85%d8%a7%d9%84/%d8%a7%d8%ac%d9%87%d8%b2%d9%87-%d9%88%d9%85%d8%b3%d8%aa%d8%ad%d8%b6%d8%b1%d8%a7%d8%aa-%d8%a7%d9%84%d8%b9%d9%86%d8%a7%d9%8a%d9%87-%d8%a8%d8%a7%d9%84%d8%b4%d8%b9%d8%b1/"
//       }
//     ],
//     "tags": [],
//     "attributes": [],
//     "variations": [],
//     "has_options": false,
//     "is_purchasable": true,
//     "is_in_stock": true,
//     "is_on_backorder": false,
//     "low_stock_remaining": null,
//     "sold_individually": false,
//     "quantity_limit": 99,
//     "add_to_cart": {
//       "text": "إضافة إلى السلة",
//       "description": "إضافة &#8220;زيت شعر كيان kayan المعالج 200 مللي&#8221; إلى سلة مشترياتك",
//       "url": "?add-to-cart=49375"
//     }
//   },
//   {
//     "id": 49309,
//     "name": "منبه Alarm بشكل الايموجي Emoji",
//     "parent": 0,
//     "type": "simple",
//     "variation": "",
//     "permalink": "https://khsomat.com/product/%d9%85%d9%86%d8%a8%d9%87-%d8%a7%d9%84%d8%a7%d9%8a%d9%85%d9%88%d8%ac%d9%8a/",
//     "sku": "",
//     "short_description": "<h3>منبه الايموجي</h3>\n<h3>منتج ممتاز للكبار وينفع كهدية لطيفة للأطفال</h3>\n<p>المنبه يستيقظ في حالة القيام بهزه هزة بسيطة ويستيقظ عند النقر والخبط بجانبه بدون لمسه يسهل استخدام وظبط المنبه ويمكن إيقافه او اعطائه غفوة فقط عن طريق هزه هزة بسيطة واذا واجهت اي صعوبة في الاستخدام متاح لدينا فريق خدمة عملاء علي مدار اليوم</p>\n<h5></h5>",
//     "description": "<h3><strong>مميزات فريدة من نوعها : </strong></h3>\n<p>المنبه يمكنه قياس درجة حرارة الغرفة بالإضافه لامكانية اضاءة الغرفة في الظلام بواسطة اضواءه</p>\n<h3><strong>حساس جدا : </strong></h3>\n<p>المنبه يستيقظ في حالة القيام بهزه هزة بسيطة ويستيقظ عند النقر والخبط بجانبه بدون لمسه</p>\n<h3><strong>كيوت جدا : </strong></h3>\n<p>المنبه يقوم بتعبيرات ايموجي حسب الوضع ويعطي شكلا جماليا ولمسة فنية لغرفتك</p>\n<h3><strong>نغمات موسيقية متعددة :</strong></h3>\n<p>المنبه يتميز بتعدد نغماته الموسيقية مع امكانية اختيار مستوي الصوت لكل نغمة</p>\n<h3><strong>شاشة ديجيتال عالية الجودة :</strong></h3>\n<p>شاشة المنبه ديجتيتال عالية الجودة يمكن رؤيتها ومعرفة الساعه من اي زاوية رؤية ممكنة</p>\n<h3><strong>خامات راقية وبطارية متينة :</strong></h3>\n<p>خامات المنبة ممتازة واقل ما يقال عنها “راقية” وبطاريته تدوم لاسبوع او أكثر بعد شحنة واحدة فقط</p>\n<h3><strong>سهولة في الإستخدام :</strong></h3>\n<p>يسهل استخدام وظبط المنبه ويمكن إيقافه او اعطائه غفوة فقط عن طريق هزه هزة بسيطة واذا واجهت اي صعوبة في الاستخدام متاح لدينا فريق خدمة عملاء علي مدار اليوم كامل فقط لخدمتك</p>",
//     "on_sale": true,
//     "prices": {
//       "price": "38000",
//       "regular_price": "45000",
//       "sale_price": "38000",
//       "price_range": null,
//       "currency_code": "EGP",
//       "currency_symbol": "EGP",
//       "currency_minor_unit": 2,
//       "currency_decimal_separator": ".",
//       "currency_thousand_separator": ",",
//       "currency_prefix": "EGP ",
//       "currency_suffix": ""
//     },
//     "price_html": "<del aria-hidden=\"true\"><span class=\"woocommerce-Price-amount amount\"><span class=\"woocommerce-Price-currencySymbol\">EGP</span>&nbsp;450.00</span></del> <ins><span class=\"woocommerce-Price-amount amount\"><span class=\"woocommerce-Price-currencySymbol\">EGP</span>&nbsp;380.00</span></ins>",
//     "average_rating": "0",
//     "review_count": 0,
//     "images": [
//       {
//         "id": 49310,
//         "src": "https://khsomat.com/wp-content/uploads/2021/08/1.png",
//         "thumbnail": "https://khsomat.com/wp-content/uploads/2021/08/1-283x283.png",
//         "srcset": "https://khsomat.com/wp-content/uploads/2021/08/1.png 500w, https://khsomat.com/wp-content/uploads/2021/08/1-300x300.png 300w, https://khsomat.com/wp-content/uploads/2021/08/1-150x150.png 150w, https://khsomat.com/wp-content/uploads/2021/08/1-283x283.png 283w, https://khsomat.com/wp-content/uploads/2021/08/1-100x100.png 100w",
//         "sizes": "(max-width: 500px) 100vw, 500px",
//         "name": "1",
//         "alt": "المنبه الايموجي"
//       },
//       {
//         "id": 49311,
//         "src": "https://khsomat.com/wp-content/uploads/2021/08/2.png",
//         "thumbnail": "https://khsomat.com/wp-content/uploads/2021/08/2-283x283.png",
//         "srcset": "https://khsomat.com/wp-content/uploads/2021/08/2.png 500w, https://khsomat.com/wp-content/uploads/2021/08/2-300x300.png 300w, https://khsomat.com/wp-content/uploads/2021/08/2-150x150.png 150w, https://khsomat.com/wp-content/uploads/2021/08/2-283x283.png 283w, https://khsomat.com/wp-content/uploads/2021/08/2-100x100.png 100w",
//         "sizes": "(max-width: 500px) 100vw, 500px",
//         "name": "2",
//         "alt": ""
//       },
//       {
//         "id": 49312,
//         "src": "https://khsomat.com/wp-content/uploads/2021/08/3.png",
//         "thumbnail": "https://khsomat.com/wp-content/uploads/2021/08/3-283x283.png",
//         "srcset": "https://khsomat.com/wp-content/uploads/2021/08/3.png 500w, https://khsomat.com/wp-content/uploads/2021/08/3-300x300.png 300w, https://khsomat.com/wp-content/uploads/2021/08/3-150x150.png 150w, https://khsomat.com/wp-content/uploads/2021/08/3-283x283.png 283w, https://khsomat.com/wp-content/uploads/2021/08/3-100x100.png 100w",
//         "sizes": "(max-width: 500px) 100vw, 500px",
//         "name": "3",
//         "alt": ""
//       },
//       {
//         "id": 49313,
//         "src": "https://khsomat.com/wp-content/uploads/2021/08/4.png",
//         "thumbnail": "https://khsomat.com/wp-content/uploads/2021/08/4-283x283.png",
//         "srcset": "https://khsomat.com/wp-content/uploads/2021/08/4.png 500w, https://khsomat.com/wp-content/uploads/2021/08/4-300x300.png 300w, https://khsomat.com/wp-content/uploads/2021/08/4-150x150.png 150w, https://khsomat.com/wp-content/uploads/2021/08/4-283x283.png 283w, https://khsomat.com/wp-content/uploads/2021/08/4-100x100.png 100w",
//         "sizes": "(max-width: 500px) 100vw, 500px",
//         "name": "4",
//         "alt": ""
//       }
//     ],
//     "categories": [
//       {
//         "id": 888,
//         "name": "عروض السناجل",
//         "slug": "%d8%b9%d8%b1%d9%88%d8%b6-%d8%a7%d9%84%d8%b3%d9%86%d8%a7%d8%ac%d9%84",
//         "link": "https://khsomat.com/product-category/%d8%b9%d8%b1%d9%88%d8%b6-%d8%a7%d9%84%d8%b3%d9%86%d8%a7%d8%ac%d9%84/"
//       }
//     ],
//     "tags": [],
//     "attributes": [],
//     "variations": [],
//     "has_options": false,
//     "is_purchasable": true,
//     "is_in_stock": true,
//     "is_on_backorder": false,
//     "low_stock_remaining": null,
//     "sold_individually": false,
//     "quantity_limit": 99,
//     "add_to_cart": {
//       "text": "إضافة إلى السلة",
//       "description": "إضافة &#8220;منبه Alarm بشكل الايموجي Emoji&#8221; إلى سلة مشترياتك",
//       "url": "?add-to-cart=49309"
//     }
//   },
//   {
//     "id": 49299,
//     "name": "طقم شيكو الاصلي للعنايه الشخصيه بالاطفال",
//     "parent": 0,
//     "type": "simple",
//     "variation": "",
//     "permalink": "https://khsomat.com/product/%d9%85%d8%b4%d8%a7%d9%8a%d9%87-%d8%a7%d8%b7%d9%81%d8%a7%d9%84-%d9%84%d8%aa%d8%b9%d9%84%d9%8a%d9%85-%d8%a7%d9%84%d9%85%d8%b4%d9%8a-%d9%88%d8%a7%d9%84%d8%aa%d8%ad%d9%83%d9%85-%d9%81%d9%8a-%d8%ad%d8%b1/",
//     "sku": "",
//     "short_description": "",
//     "description": "<p>طقم شيكو الاصلي للعنايه الشخصيه بالاطفال</p>",
//     "on_sale": true,
//     "prices": {
//       "price": "7500",
//       "regular_price": "15000",
//       "sale_price": "7500",
//       "price_range": null,
//       "currency_code": "EGP",
//       "currency_symbol": "EGP",
//       "currency_minor_unit": 2,
//       "currency_decimal_separator": ".",
//       "currency_thousand_separator": ",",
//       "currency_prefix": "EGP ",
//       "currency_suffix": ""
//     },
//     "price_html": "<del aria-hidden=\"true\"><span class=\"woocommerce-Price-amount amount\"><span class=\"woocommerce-Price-currencySymbol\">EGP</span>&nbsp;150.00</span></del> <ins><span class=\"woocommerce-Price-amount amount\"><span class=\"woocommerce-Price-currencySymbol\">EGP</span>&nbsp;75.00</span></ins>",
//     "average_rating": "0",
//     "review_count": 0,
//     "images": [
//       {
//         "id": 49300,
//         "src": "https://khsomat.com/wp-content/uploads/2021/08/7-48.jpg",
//         "thumbnail": "https://khsomat.com/wp-content/uploads/2021/08/7-48-283x283.jpg",
//         "srcset": "https://khsomat.com/wp-content/uploads/2021/08/7-48.jpg 500w, https://khsomat.com/wp-content/uploads/2021/08/7-48-300x300.jpg 300w, https://khsomat.com/wp-content/uploads/2021/08/7-48-150x150.jpg 150w, https://khsomat.com/wp-content/uploads/2021/08/7-48-283x283.jpg 283w, https://khsomat.com/wp-content/uploads/2021/08/7-48-100x100.jpg 100w",
//         "sizes": "(max-width: 500px) 100vw, 500px",
//         "name": "7",
//         "alt": ""
//       },
//       {
//         "id": 49301,
//         "src": "https://khsomat.com/wp-content/uploads/2021/08/6-55.jpg",
//         "thumbnail": "https://khsomat.com/wp-content/uploads/2021/08/6-55-283x283.jpg",
//         "srcset": "https://khsomat.com/wp-content/uploads/2021/08/6-55.jpg 500w, https://khsomat.com/wp-content/uploads/2021/08/6-55-300x300.jpg 300w, https://khsomat.com/wp-content/uploads/2021/08/6-55-150x150.jpg 150w, https://khsomat.com/wp-content/uploads/2021/08/6-55-283x283.jpg 283w, https://khsomat.com/wp-content/uploads/2021/08/6-55-100x100.jpg 100w",
//         "sizes": "(max-width: 500px) 100vw, 500px",
//         "name": "6",
//         "alt": ""
//       },
//       {
//         "id": 49302,
//         "src": "https://khsomat.com/wp-content/uploads/2021/08/8-45.jpg",
//         "thumbnail": "https://khsomat.com/wp-content/uploads/2021/08/8-45-283x283.jpg",
//         "srcset": "https://khsomat.com/wp-content/uploads/2021/08/8-45.jpg 500w, https://khsomat.com/wp-content/uploads/2021/08/8-45-300x300.jpg 300w, https://khsomat.com/wp-content/uploads/2021/08/8-45-150x150.jpg 150w, https://khsomat.com/wp-content/uploads/2021/08/8-45-283x283.jpg 283w, https://khsomat.com/wp-content/uploads/2021/08/8-45-100x100.jpg 100w",
//         "sizes": "(max-width: 500px) 100vw, 500px",
//         "name": "8",
//         "alt": ""
//       }
//     ],
//     "categories": [
//       {
//         "id": 136,
//         "name": "مستلزمات أطفال",
//         "slug": "%d9%85%d8%b3%d8%aa%d9%84%d8%b2%d9%85%d8%a7%d8%aa-%d8%a3%d8%b7%d9%81%d8%a7%d9%84",
//         "link": "https://khsomat.com/product-category/%d9%85%d8%b3%d8%aa%d9%84%d8%b2%d9%85%d8%a7%d8%aa-%d8%a3%d8%b7%d9%81%d8%a7%d9%84/"
//       }
//     ],
//     "tags": [],
//     "attributes": [],
//     "variations": [],
//     "has_options": false,
//     "is_purchasable": true,
//     "is_in_stock": true,
//     "is_on_backorder": false,
//     "low_stock_remaining": null,
//     "sold_individually": true,
//     "quantity_limit": 1,
//     "add_to_cart": {
//       "text": "إضافة إلى السلة",
//       "description": "إضافة &#8220;طقم شيكو الاصلي للعنايه الشخصيه بالاطفال&#8221; إلى سلة مشترياتك",
//       "url": "?add-to-cart=49299"
//     }
//   },
//   {
//     "id": 49296,
//     "name": "الكوره النطاطه الاصليه",
//     "parent": 0,
//     "type": "simple",
//     "variation": "",
//     "permalink": "https://khsomat.com/product/%d8%a7%d9%84%d9%83%d9%88%d8%b1%d9%87-%d8%a7%d9%84%d9%86%d8%b7%d8%a7%d8%b7%d9%87-%d8%a7%d9%84%d8%a7%d8%b5%d9%84%d9%8a%d9%87/",
//     "sku": "",
//     "short_description": "<p>الكوره النطاطه الاصليه</p>",
//     "description": "<p>قادوس الفضاء النطاطي ذو الوجه ذو النمط القديم الذي يمكن التعرف عليه على الفور هو التصميم المحسّن حديثًا والجودة العالية للأطفال البالغين والأطفال في الهواء الطلق لعبة حديقة الفضاء واثب القفز والكرة المرتدة الممتعة. هذا المنتج سهل الاستخدام ، ببساطة اجعل شخصًا بالغًا ينفخ المنتج على الكرة ويمسكه بمقابض سهلة الإمساك. يأتي هذا المنتج بتصميم ملفت للنظر ويوفر طريقة ممتعة لممارسة الرياضة دون أن تدرك ذلك. ثم يمكنك أن ترى إلى أي مدى يمكنك القفز أو السرعة التي يمكنك بها السباق ضد أصدقائك. يمكن تفريغ هذا المنتج بسهولة للتخزين عندما لا يكون قيد الاستخدام. سيخرج هذا المنتج الأطفال إلى الخارج ويشجعهم على الاستمتاع مع أصدقائهم بالخارج والبقاء نشيطين وصحيين. إنه أيضًا رمز من السبعينيات ، يتذكره كل طفل تقريبًا في ذلك الوقت باعتزاز. ليس أقل جاذبية الآن ، فقد عاد القادوس المطاطي الكبير والوجه المجنون لإسعاد جيل آخر من الأطفال.تستخدم حتي ٤٥ كجممعها منفاخ</p>",
//     "on_sale": true,
//     "prices": {
//       "price": "13000",
//       "regular_price": "21000",
//       "sale_price": "13000",
//       "price_range": null,
//       "currency_code": "EGP",
//       "currency_symbol": "EGP",
//       "currency_minor_unit": 2,
//       "currency_decimal_separator": ".",
//       "currency_thousand_separator": ",",
//       "currency_prefix": "EGP ",
//       "currency_suffix": ""
//     },
//     "price_html": "<del aria-hidden=\"true\"><span class=\"woocommerce-Price-amount amount\"><span class=\"woocommerce-Price-currencySymbol\">EGP</span>&nbsp;210.00</span></del> <ins><span class=\"woocommerce-Price-amount amount\"><span class=\"woocommerce-Price-currencySymbol\">EGP</span>&nbsp;130.00</span></ins>",
//     "average_rating": "0",
//     "review_count": 0,
//     "images": [
//       {
//         "id": 49297,
//         "src": "https://khsomat.com/wp-content/uploads/2021/08/13-16.jpg",
//         "thumbnail": "https://khsomat.com/wp-content/uploads/2021/08/13-16-283x283.jpg",
//         "srcset": "https://khsomat.com/wp-content/uploads/2021/08/13-16.jpg 500w, https://khsomat.com/wp-content/uploads/2021/08/13-16-300x300.jpg 300w, https://khsomat.com/wp-content/uploads/2021/08/13-16-150x150.jpg 150w, https://khsomat.com/wp-content/uploads/2021/08/13-16-283x283.jpg 283w, https://khsomat.com/wp-content/uploads/2021/08/13-16-100x100.jpg 100w",
//         "sizes": "(max-width: 500px) 100vw, 500px",
//         "name": "13",
//         "alt": ""
//       },
//       {
//         "id": 49298,
//         "src": "https://khsomat.com/wp-content/uploads/2021/08/12-13.jpg",
//         "thumbnail": "https://khsomat.com/wp-content/uploads/2021/08/12-13-283x283.jpg",
//         "srcset": "https://khsomat.com/wp-content/uploads/2021/08/12-13.jpg 500w, https://khsomat.com/wp-content/uploads/2021/08/12-13-300x300.jpg 300w, https://khsomat.com/wp-content/uploads/2021/08/12-13-150x150.jpg 150w, https://khsomat.com/wp-content/uploads/2021/08/12-13-283x283.jpg 283w, https://khsomat.com/wp-content/uploads/2021/08/12-13-100x100.jpg 100w",
//         "sizes": "(max-width: 500px) 100vw, 500px",
//         "name": "12",
//         "alt": ""
//       },
//       {
//         "id": 49303,
//         "src": "https://khsomat.com/wp-content/uploads/2021/08/9-31.jpg",
//         "thumbnail": "https://khsomat.com/wp-content/uploads/2021/08/9-31-283x283.jpg",
//         "srcset": "https://khsomat.com/wp-content/uploads/2021/08/9-31.jpg 500w, https://khsomat.com/wp-content/uploads/2021/08/9-31-300x300.jpg 300w, https://khsomat.com/wp-content/uploads/2021/08/9-31-150x150.jpg 150w, https://khsomat.com/wp-content/uploads/2021/08/9-31-283x283.jpg 283w, https://khsomat.com/wp-content/uploads/2021/08/9-31-100x100.jpg 100w",
//         "sizes": "(max-width: 500px) 100vw, 500px",
//         "name": "9",
//         "alt": ""
//       },
//       {
//         "id": 49304,
//         "src": "https://khsomat.com/wp-content/uploads/2021/08/10-28.jpg",
//         "thumbnail": "https://khsomat.com/wp-content/uploads/2021/08/10-28-283x283.jpg",
//         "srcset": "https://khsomat.com/wp-content/uploads/2021/08/10-28.jpg 500w, https://khsomat.com/wp-content/uploads/2021/08/10-28-300x300.jpg 300w, https://khsomat.com/wp-content/uploads/2021/08/10-28-150x150.jpg 150w, https://khsomat.com/wp-content/uploads/2021/08/10-28-283x283.jpg 283w, https://khsomat.com/wp-content/uploads/2021/08/10-28-100x100.jpg 100w",
//         "sizes": "(max-width: 500px) 100vw, 500px",
//         "name": "10",
//         "alt": ""
//       },
//       {
//         "id": 49305,
//         "src": "https://khsomat.com/wp-content/uploads/2021/08/11-21.jpg",
//         "thumbnail": "https://khsomat.com/wp-content/uploads/2021/08/11-21-283x283.jpg",
//         "srcset": "https://khsomat.com/wp-content/uploads/2021/08/11-21.jpg 500w, https://khsomat.com/wp-content/uploads/2021/08/11-21-300x300.jpg 300w, https://khsomat.com/wp-content/uploads/2021/08/11-21-150x150.jpg 150w, https://khsomat.com/wp-content/uploads/2021/08/11-21-283x283.jpg 283w, https://khsomat.com/wp-content/uploads/2021/08/11-21-100x100.jpg 100w",
//         "sizes": "(max-width: 500px) 100vw, 500px",
//         "name": "11",
//         "alt": ""
//       }
//     ],
//     "categories": [
//       {
//         "id": 136,
//         "name": "مستلزمات أطفال",
//         "slug": "%d9%85%d8%b3%d8%aa%d9%84%d8%b2%d9%85%d8%a7%d8%aa-%d8%a3%d8%b7%d9%81%d8%a7%d9%84",
//         "link": "https://khsomat.com/product-category/%d9%85%d8%b3%d8%aa%d9%84%d8%b2%d9%85%d8%a7%d8%aa-%d8%a3%d8%b7%d9%81%d8%a7%d9%84/"
//       }
//     ],
//     "tags": [],
//     "attributes": [],
//     "variations": [],
//     "has_options": false,
//     "is_purchasable": true,
//     "is_in_stock": true,
//     "is_on_backorder": false,
//     "low_stock_remaining": null,
//     "sold_individually": true,
//     "quantity_limit": 1,
//     "add_to_cart": {
//       "text": "إضافة إلى السلة",
//       "description": "إضافة &#8220;الكوره النطاطه الاصليه&#8221; إلى سلة مشترياتك",
//       "url": "?add-to-cart=49296"
//     }
//   },
//   {
//     "id": 49294,
//     "name": "تابليت Tap  اطفال للرسم 12 بوصه",
//     "parent": 0,
//     "type": "simple",
//     "variation": "",
//     "permalink": "https://khsomat.com/product/%d8%aa%d8%a7%d8%a8-%d8%a7%d8%b7%d9%81%d8%a7%d9%84-12-%d8%a8%d9%88%d8%b5%d9%87/",
//     "sku": "",
//     "short_description": "<p>تاب Tap  اطفال للرسم 12 بوصه</p>",
//     "description": "<ul>\n<li> LCD</li>\n<li>شاشة 12 بوصة</li>\n<li>لتعليم</li>\n<li>الكتابة</li>\n<li>الرسم</li>\n<li>خط اليد</li>\n<li>التابلت اللوحي مع القلم</li>\n<li>يصلح للمدرسة والعمل</li>\n</ul>",
//     "on_sale": true,
//     "prices": {
//       "price": "12000",
//       "regular_price": "20000",
//       "sale_price": "12000",
//       "price_range": null,
//       "currency_code": "EGP",
//       "currency_symbol": "EGP",
//       "currency_minor_unit": 2,
//       "currency_decimal_separator": ".",
//       "currency_thousand_separator": ",",
//       "currency_prefix": "EGP ",
//       "currency_suffix": ""
//     },
//     "price_html": "<del aria-hidden=\"true\"><span class=\"woocommerce-Price-amount amount\"><span class=\"woocommerce-Price-currencySymbol\">EGP</span>&nbsp;200.00</span></del> <ins><span class=\"woocommerce-Price-amount amount\"><span class=\"woocommerce-Price-currencySymbol\">EGP</span>&nbsp;120.00</span></ins>",
//     "average_rating": "0",
//     "review_count": 0,
//     "images": [
//       {
//         "id": 49295,
//         "src": "https://khsomat.com/wp-content/uploads/2021/08/1-82.jpg",
//         "thumbnail": "https://khsomat.com/wp-content/uploads/2021/08/1-82-283x283.jpg",
//         "srcset": "https://khsomat.com/wp-content/uploads/2021/08/1-82.jpg 500w, https://khsomat.com/wp-content/uploads/2021/08/1-82-300x300.jpg 300w, https://khsomat.com/wp-content/uploads/2021/08/1-82-150x150.jpg 150w, https://khsomat.com/wp-content/uploads/2021/08/1-82-283x283.jpg 283w, https://khsomat.com/wp-content/uploads/2021/08/1-82-100x100.jpg 100w",
//         "sizes": "(max-width: 500px) 100vw, 500px",
//         "name": "1",
//         "alt": ""
//       }
//     ],
//     "categories": [
//       {
//         "id": 943,
//         "name": "مستلزمات المطبخ",
//         "slug": "%d9%85%d8%b3%d8%aa%d9%84%d8%b2%d9%85%d8%a7%d8%aa-%d8%a7%d9%84%d9%85%d8%b7%d8%a8%d8%ae",
//         "link": "https://khsomat.com/product-category/%d8%a7%d9%84%d9%85%d9%86%d8%b2%d9%84-%d9%88%d8%a7%d9%84%d9%85%d8%b7%d8%a8%d8%ae/%d9%85%d8%b3%d8%aa%d9%84%d8%b2%d9%85%d8%a7%d8%aa-%d8%a7%d9%84%d9%85%d8%b7%d8%a8%d8%ae/"
//       },
//       {
//         "id": 136,
//         "name": "مستلزمات أطفال",
//         "slug": "%d9%85%d8%b3%d8%aa%d9%84%d8%b2%d9%85%d8%a7%d8%aa-%d8%a3%d8%b7%d9%81%d8%a7%d9%84",
//         "link": "https://khsomat.com/product-category/%d9%85%d8%b3%d8%aa%d9%84%d8%b2%d9%85%d8%a7%d8%aa-%d8%a3%d8%b7%d9%81%d8%a7%d9%84/"
//       }
//     ],
//     "tags": [],
//     "attributes": [],
//     "variations": [],
//     "has_options": false,
//     "is_purchasable": true,
//     "is_in_stock": true,
//     "is_on_backorder": false,
//     "low_stock_remaining": null,
//     "sold_individually": true,
//     "quantity_limit": 1,
//     "add_to_cart": {
//       "text": "إضافة إلى السلة",
//       "description": "إضافة &#8220;تابليت Tap  اطفال للرسم 12 بوصه&#8221; إلى سلة مشترياتك",
//       "url": "?add-to-cart=49294"
//     }
//   },
//   {
//     "id": 49291,
//     "name": "سبوره اطفال Hello Kitty",
//     "parent": 0,
//     "type": "simple",
//     "variation": "",
//     "permalink": "https://khsomat.com/product/%d8%b3%d8%a7%d8%a8%d9%88%d8%b1%d9%87-hello-kitty/",
//     "sku": "",
//     "short_description": "<p>سابوره Hello Kitty</p>",
//     "description": "<p>سابوره Hello Kitty</p>",
//     "on_sale": true,
//     "prices": {
//       "price": "9000",
//       "regular_price": "15000",
//       "sale_price": "9000",
//       "price_range": null,
//       "currency_code": "EGP",
//       "currency_symbol": "EGP",
//       "currency_minor_unit": 2,
//       "currency_decimal_separator": ".",
//       "currency_thousand_separator": ",",
//       "currency_prefix": "EGP ",
//       "currency_suffix": ""
//     },
//     "price_html": "<del aria-hidden=\"true\"><span class=\"woocommerce-Price-amount amount\"><span class=\"woocommerce-Price-currencySymbol\">EGP</span>&nbsp;150.00</span></del> <ins><span class=\"woocommerce-Price-amount amount\"><span class=\"woocommerce-Price-currencySymbol\">EGP</span>&nbsp;90.00</span></ins>",
//     "average_rating": "0",
//     "review_count": 0,
//     "images": [
//       {
//         "id": 49292,
//         "src": "https://khsomat.com/wp-content/uploads/2021/08/19-5.jpg",
//         "thumbnail": "https://khsomat.com/wp-content/uploads/2021/08/19-5-283x283.jpg",
//         "srcset": "https://khsomat.com/wp-content/uploads/2021/08/19-5.jpg 500w, https://khsomat.com/wp-content/uploads/2021/08/19-5-300x300.jpg 300w, https://khsomat.com/wp-content/uploads/2021/08/19-5-150x150.jpg 150w, https://khsomat.com/wp-content/uploads/2021/08/19-5-283x283.jpg 283w, https://khsomat.com/wp-content/uploads/2021/08/19-5-100x100.jpg 100w",
//         "sizes": "(max-width: 500px) 100vw, 500px",
//         "name": "19",
//         "alt": ""
//       },
//       {
//         "id": 49293,
//         "src": "https://khsomat.com/wp-content/uploads/2021/08/18-7.jpg",
//         "thumbnail": "https://khsomat.com/wp-content/uploads/2021/08/18-7-283x283.jpg",
//         "srcset": "https://khsomat.com/wp-content/uploads/2021/08/18-7.jpg 500w, https://khsomat.com/wp-content/uploads/2021/08/18-7-300x300.jpg 300w, https://khsomat.com/wp-content/uploads/2021/08/18-7-150x150.jpg 150w, https://khsomat.com/wp-content/uploads/2021/08/18-7-283x283.jpg 283w, https://khsomat.com/wp-content/uploads/2021/08/18-7-100x100.jpg 100w",
//         "sizes": "(max-width: 500px) 100vw, 500px",
//         "name": "18",
//         "alt": ""
//       }
//     ],
//     "categories": [
//       {
//         "id": 136,
//         "name": "مستلزمات أطفال",
//         "slug": "%d9%85%d8%b3%d8%aa%d9%84%d8%b2%d9%85%d8%a7%d8%aa-%d8%a3%d8%b7%d9%81%d8%a7%d9%84",
//         "link": "https://khsomat.com/product-category/%d9%85%d8%b3%d8%aa%d9%84%d8%b2%d9%85%d8%a7%d8%aa-%d8%a3%d8%b7%d9%81%d8%a7%d9%84/"
//       }
//     ],
//     "tags": [],
//     "attributes": [],
//     "variations": [],
//     "has_options": false,
//     "is_purchasable": true,
//     "is_in_stock": true,
//     "is_on_backorder": false,
//     "low_stock_remaining": null,
//     "sold_individually": true,
//     "quantity_limit": 1,
//     "add_to_cart": {
//       "text": "إضافة إلى السلة",
//       "description": "إضافة &#8220;سبوره اطفال Hello Kitty&#8221; إلى سلة مشترياتك",
//       "url": "?add-to-cart=49291"
//     }
//   },
//   {
//     "id": 49287,
//     "name": "وناسه دبدوب Pooh BaBy",
//     "parent": 0,
//     "type": "simple",
//     "variation": "",
//     "permalink": "https://khsomat.com/product/%d9%88%d9%86%d8%a7%d8%b3%d9%87-%d8%af%d8%a8%d8%af%d9%88%d8%a8-pooh-baby/",
//     "sku": "",
//     "short_description": "<p>وناسه دبدوب Pooh BaBy</p>",
//     "description": "<p>وناسه دبدوب Pooh BaBy</p>",
//     "on_sale": true,
//     "prices": {
//       "price": "25000",
//       "regular_price": "32000",
//       "sale_price": "25000",
//       "price_range": null,
//       "currency_code": "EGP",
//       "currency_symbol": "EGP",
//       "currency_minor_unit": 2,
//       "currency_decimal_separator": ".",
//       "currency_thousand_separator": ",",
//       "currency_prefix": "EGP ",
//       "currency_suffix": ""
//     },
//     "price_html": "<del aria-hidden=\"true\"><span class=\"woocommerce-Price-amount amount\"><span class=\"woocommerce-Price-currencySymbol\">EGP</span>&nbsp;320.00</span></del> <ins><span class=\"woocommerce-Price-amount amount\"><span class=\"woocommerce-Price-currencySymbol\">EGP</span>&nbsp;250.00</span></ins>",
//     "average_rating": "0",
//     "review_count": 0,
//     "images": [
//       {
//         "id": 49289,
//         "src": "https://khsomat.com/wp-content/uploads/2021/08/16-8.jpg",
//         "thumbnail": "https://khsomat.com/wp-content/uploads/2021/08/16-8-283x283.jpg",
//         "srcset": "https://khsomat.com/wp-content/uploads/2021/08/16-8.jpg 500w, https://khsomat.com/wp-content/uploads/2021/08/16-8-300x300.jpg 300w, https://khsomat.com/wp-content/uploads/2021/08/16-8-150x150.jpg 150w, https://khsomat.com/wp-content/uploads/2021/08/16-8-283x283.jpg 283w, https://khsomat.com/wp-content/uploads/2021/08/16-8-100x100.jpg 100w",
//         "sizes": "(max-width: 500px) 100vw, 500px",
//         "name": "16",
//         "alt": ""
//       },
//       {
//         "id": 49290,
//         "src": "https://khsomat.com/wp-content/uploads/2021/08/17-6.jpg",
//         "thumbnail": "https://khsomat.com/wp-content/uploads/2021/08/17-6-283x283.jpg",
//         "srcset": "https://khsomat.com/wp-content/uploads/2021/08/17-6.jpg 500w, https://khsomat.com/wp-content/uploads/2021/08/17-6-300x300.jpg 300w, https://khsomat.com/wp-content/uploads/2021/08/17-6-150x150.jpg 150w, https://khsomat.com/wp-content/uploads/2021/08/17-6-283x283.jpg 283w, https://khsomat.com/wp-content/uploads/2021/08/17-6-100x100.jpg 100w",
//         "sizes": "(max-width: 500px) 100vw, 500px",
//         "name": "17",
//         "alt": ""
//       }
//     ],
//     "categories": [
//       {
//         "id": 156,
//         "name": "العاب اطفال",
//         "slug": "%d8%a7%d9%84%d8%b9%d8%a7%d8%a8-%d8%a7%d8%b7%d9%81%d8%a7%d9%84",
//         "link": "https://khsomat.com/product-category/%d9%85%d8%b3%d8%aa%d9%84%d8%b2%d9%85%d8%a7%d8%aa-%d8%a3%d8%b7%d9%81%d8%a7%d9%84/%d8%a7%d9%84%d8%b9%d8%a7%d8%a8-%d8%a7%d8%b7%d9%81%d8%a7%d9%84/"
//       }
//     ],
//     "tags": [],
//     "attributes": [],
//     "variations": [],
//     "has_options": false,
//     "is_purchasable": true,
//     "is_in_stock": true,
//     "is_on_backorder": false,
//     "low_stock_remaining": null,
//     "sold_individually": true,
//     "quantity_limit": 1,
//     "add_to_cart": {
//       "text": "إضافة إلى السلة",
//       "description": "إضافة &#8220;وناسه دبدوب Pooh BaBy&#8221; إلى سلة مشترياتك",
//       "url": "?add-to-cart=49287"
//     }
//   },
//   {
//     "id": 49245,
//     "name": "بنطلون وايد ليج جينز خامة مستوردة تقفيل مصرى",
//     "parent": 0,
//     "type": "variable",
//     "variation": "",
//     "permalink": "https://khsomat.com/product/%d8%a8%d9%86%d8%b7%d9%84%d9%88%d9%86-%d8%a8%d9%88%d9%89-%d9%81%d8%b1%d9%8a%d9%86%d8%af-%d8%ac%d9%8a%d9%86%d8%b2-%d8%ae%d8%a7%d9%85%d8%a9-%d9%85%d8%b3%d8%aa%d9%88%d8%b1%d8%af%d8%a9-%d8%aa%d9%82%d9%81-2/",
//     "sku": "",
//     "short_description": "<p> بنطلون بوى فريند جينز خامة مستوردة تقفيل مصرى </p>",
//     "description": "<p> بنطلون وايد ليج جينز خامة مستوردة تقفيل مصرى </p>",
//     "on_sale": true,
//     "prices": {
//       "price": "23500",
//       "regular_price": "27000",
//       "sale_price": "23500",
//       "price_range": null,
//       "currency_code": "EGP",
//       "currency_symbol": "EGP",
//       "currency_minor_unit": 2,
//       "currency_decimal_separator": ".",
//       "currency_thousand_separator": ",",
//       "currency_prefix": "EGP ",
//       "currency_suffix": ""
//     },
//     "price_html": "<del aria-hidden=\"true\"><span class=\"woocommerce-Price-amount amount\"><span class=\"woocommerce-Price-currencySymbol\">EGP</span>&nbsp;270.00</span></del> <ins><span class=\"woocommerce-Price-amount amount\"><span class=\"woocommerce-Price-currencySymbol\">EGP</span>&nbsp;235.00</span></ins>",
//     "average_rating": "0",
//     "review_count": 0,
//     "images": [
//       {
//         "id": 49262,
//         "src": "https://khsomat.com/wp-content/uploads/2021/08/photo_2021-08-17_20-10-05.jpg",
//         "thumbnail": "https://khsomat.com/wp-content/uploads/2021/08/photo_2021-08-17_20-10-05-283x284.jpg",
//         "srcset": "https://khsomat.com/wp-content/uploads/2021/08/photo_2021-08-17_20-10-05.jpg 720w, https://khsomat.com/wp-content/uploads/2021/08/photo_2021-08-17_20-10-05-300x300.jpg 300w, https://khsomat.com/wp-content/uploads/2021/08/photo_2021-08-17_20-10-05-150x150.jpg 150w, https://khsomat.com/wp-content/uploads/2021/08/photo_2021-08-17_20-10-05-283x284.jpg 283w, https://khsomat.com/wp-content/uploads/2021/08/photo_2021-08-17_20-10-05-100x100.jpg 100w",
//         "sizes": "(max-width: 720px) 100vw, 720px",
//         "name": "photo_2021-08-17_20-10-05",
//         "alt": ""
//       }
//     ],
//     "categories": [
//       {
//         "id": 894,
//         "name": "ملابس كاجوال نسائي",
//         "slug": "%d9%85%d9%84%d8%a7%d8%a8%d8%b3-%d9%83%d8%a7%d8%ac%d9%88%d8%a7%d9%84-%d8%a3%d8%b2%d9%8a%d8%a7%d8%a1-%d9%86%d8%b3%d8%a7%d8%a6%d9%8a",
//         "link": "https://khsomat.com/product-category/%d8%a3%d8%b2%d9%8a%d8%a7%d8%a1-%d9%86%d8%b3%d8%a7%d8%a6%d9%8a/%d9%85%d9%84%d8%a7%d8%a8%d8%b3-%d9%83%d8%a7%d8%ac%d9%88%d8%a7%d9%84-%d8%a3%d8%b2%d9%8a%d8%a7%d8%a1-%d9%86%d8%b3%d8%a7%d8%a6%d9%8a/"
//       }
//     ],
//     "tags": [],
//     "attributes": [
//       {
//         "id": 2,
//         "name": "Size",
//         "taxonomy": "pa_size",
//         "has_variations": true,
//         "terms": [
//           {
//             "id": 217,
//             "name": "28",
//             "slug": "28"
//           },
//           {
//             "id": 29,
//             "name": "30",
//             "slug": "30"
//           },
//           {
//             "id": 30,
//             "name": "32",
//             "slug": "32"
//           },
//           {
//             "id": 31,
//             "name": "34",
//             "slug": "34"
//           },
//           {
//             "id": 233,
//             "name": "36",
//             "slug": "36"
//           },
//           {
//             "id": 234,
//             "name": "38",
//             "slug": "38"
//           }
//         ]
//       }
//     ],
//     "variations": [
//       {
//         "id": 49263,
//         "attributes": [
//           {
//             "name": "Size",
//             "value": "28"
//           }
//         ]
//       },
//       {
//         "id": 49264,
//         "attributes": [
//           {
//             "name": "Size",
//             "value": "30"
//           }
//         ]
//       },
//       {
//         "id": 49265,
//         "attributes": [
//           {
//             "name": "Size",
//             "value": "32"
//           }
//         ]
//       },
//       {
//         "id": 49266,
//         "attributes": [
//           {
//             "name": "Size",
//             "value": "34"
//           }
//         ]
//       },
//       {
//         "id": 49267,
//         "attributes": [
//           {
//             "name": "Size",
//             "value": "36"
//           }
//         ]
//       },
//       {
//         "id": 49268,
//         "attributes": [
//           {
//             "name": "Size",
//             "value": "38"
//           }
//         ]
//       }
//     ],
//     "has_options": true,
//     "is_purchasable": true,
//     "is_in_stock": true,
//     "is_on_backorder": false,
//     "low_stock_remaining": null,
//     "sold_individually": false,
//     "quantity_limit": 99,
//     "add_to_cart": {
//       "text": "تحديد أحد الخيارات",
//       "description": "تحديد الخيارات لـ &#8220;بنطلون وايد ليج جينز خامة مستوردة تقفيل مصرى&#8221;",
//       "url": "https://khsomat.com/product/%d8%a8%d9%86%d8%b7%d9%84%d9%88%d9%86-%d8%a8%d9%88%d9%89-%d9%81%d8%b1%d9%8a%d9%86%d8%af-%d8%ac%d9%8a%d9%86%d8%b2-%d8%ae%d8%a7%d9%85%d8%a9-%d9%85%d8%b3%d8%aa%d9%88%d8%b1%d8%af%d8%a9-%d8%aa%d9%82%d9%81-2/"
//     }
//   }
// ];



//
// Future<bool> result =  CacheHelper.sharedPreferences.setString('favList', jsonEncode(stringFavList));
//
// String? userPref =CacheHelper.sharedPreferences.getString('favList');

// List<dynamic> favListConst = jsonDecode(stringFavList!)  ;


// List<Map<String,dynamic>> convertedList= CacheHelper.sharedPreferences.getString('favList') as List<Map<String, dynamic>>;

//List<dynamic> productList = jsonDecode(stringFavList!);



void signOut(context) {
  CacheHelper.removeData(
    key: 'token',
  );
  CacheHelper.removeData(
    key: 'userID',
  );
  CacheHelper.removeData(key: 'email');
  CacheHelper.removeData(key: 'username').then((value) {
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


void printWrapped(text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}
