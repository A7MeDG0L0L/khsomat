import 'package:dio/dio.dart';
import 'package:khsomat/Shared/constants.dart';
import 'package:khsomat/data/models/products_model.dart';
import 'package:khsomat/data/models/register_model.dart';
import 'package:translator/translator.dart';

class WebServices {
  static late Dio dio;
  final translator= GoogleTranslator();

  WebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: 'https://khsomat.net/wp-json/',
      receiveDataWhenStatusError: true,
      // connectTimeout: 2 * 1000,
      // receiveTimeout: 2 * 1000,
    );

    dio = Dio(options);
  }

  // Future<dynamic> postRegisterUser({
  //   required String username,
  //   required String email,
  //   required String password,
  // }) async {
  //   try {
  //     Response response = await dio.post(
  //       'wp/v2/users/register',
  //       queryParameters: {
  //         'username': username,
  //         'email': email,
  //         'password': password
  //       },
  //     );
  //     print('Response from Web Service : ${response.data.toString()}');
  //     return response.data;
  //   } catch (e) {
  //     print(' Web Service : ${e.toString()}');
  //     return {};
  //   }
  // }

  Future<List<dynamic>> getAllProducts({List<int>? productIds}) async {
    try {
      Response response = await dio.get('wc/store/products', queryParameters: {
        'per_page': 100,
        // 'include':productIds!.join(",").toString(),
        'consumer_key': 'ck_fa054c2eea7057ed605ce37417fe5e92fb2d428b',
        'consumer_secret': 'cs_a2bcff0feec2d96d830b08ecf93015f6de9b409e'
      });
      // print('Response from Web Service : ${response.data.toString()}');
     // await translator.translate(response.data, to: 'en').then((value) => print(value));


      return response.data;
    } catch (e) {
      print('Product Web Service : ${e.toString()}');
      return [];
    }
  }
  Future<List<dynamic>> getProductForProductScreen({ int pageNum=1,int? categoryNum})async{
    try{
      Response response = await dio.get('wc/store/products',queryParameters: {
        'per_page':25,
        'page':pageNum,
        'category':categoryNum,
        'consumer_key': 'ck_fa054c2eea7057ed605ce37417fe5e92fb2d428b',
        'consumer_secret': 'cs_a2bcff0feec2d96d830b08ecf93015f6de9b409e'
      });
      return response.data;

    }catch(e){
      print('Product Web Service:${e.toString()}');
      return[];

    }
  }
  Future<List<dynamic>> getRelatedProducts({List<int>? productIds}) async {
    try {
      Response response = await dio.get('wc/store/products', queryParameters: {
        'per_page': 100,
         'include':productIds!.join(",").toString(),
        'consumer_key': 'ck_fa054c2eea7057ed605ce37417fe5e92fb2d428b',
        'consumer_secret': 'cs_a2bcff0feec2d96d830b08ecf93015f6de9b409e'
      });
       print('Response from Web Service : ${response.data.toString()}');
      return response.data;
    } catch (e) {
      print('Product Web Service : ${e.toString()}');
      return [];
    }
  }

  Future<List<dynamic>> retrieveCustomerOrders() async {
    try {
      print(id);
      Response response = await dio.get('wc/v3/orders', queryParameters: {
        'customer': id,
        'Content-Type': "application/json",
        'consumer_key': 'ck_fa054c2eea7057ed605ce37417fe5e92fb2d428b',
        'consumer_secret': 'cs_a2bcff0feec2d96d830b08ecf93015f6de9b409e'
      });
      print(id);
      print('Response from Web Service : ${response.data.toString()}');
      return response.data;
    } catch (e) {
      print('Product Web Service : ${e.toString()}');
      return [];
    }
  }

  Future<List<dynamic>> getAllProductsForCategory(int id) async {
    try {
      Response response = await dio.get('wc/store/products', queryParameters: {
        'per_page': 100,
        'category': id,
      });
      print('Response from Web Service : ${response.data.toString()}');
      return response.data;
    } catch (e) {
      print('Product Web Service : ${e.toString()}');
      return [];
    }
  }

  Future<List<dynamic>> getAllCategories() async {
    try {
      Response response =
          await dio.get('wc/store/products/categories', queryParameters: {
        'per_page': 100,
        'orderby': 'slug',
      });
      //  print('Response from Web Service : ${response.data.toString()}');
      return response.data;
    } catch (e) {
      print(' Web Service : ${e.toString()}');
      return [];
    }
  }

  Future<List<dynamic>> getAllSearchProducts(String searchText) async {
    try {
      Response response = await dio.get('wc/store/products', queryParameters: {
        'per_page': 100,
        'search': searchText,
      });
      print('Response from Web Service : ${response.data.toString()}');
      return response.data;
    } catch (e) {
      print('Product Web Service : ${e.toString()}');
      return [];
    }
  }
}
