import 'package:dio/dio.dart';
import 'package:khsomat/data/models/products_model.dart';
import 'package:khsomat/data/models/register_model.dart';

class ProductsWebServices {
  static late Dio dio;

  ProductsWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: 'https://khsomat.com/wp-json/',
      receiveDataWhenStatusError: true,
      // connectTimeout: 2 * 1000,
      // receiveTimeout: 2 * 1000,
    );

    dio = Dio(options);
  }

  UserModel? userModel;
  Future<dynamic> postRegisterUser({required String username,required String email,required String password})async{
    try{
      Response response = await dio.post('wp/v2/users/register',queryParameters:{'username':username,'email':email, 'password':password},);
      print('Response from Web Service : ${response.data.toString()}');
      return response.data;
    }catch(e){
      print(' Web Service : ${e.toString()}');
      return {};

    }
  }

   Future<List<dynamic>> getAllProducts() async {
    try {
      Response response = await dio.get('wc/store/products', queryParameters: {
        'per_page': 100,
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
      Response response = await dio.get(
          'wc/store/products/categories', queryParameters: {'per_page': 100,});
      print('Response from Web Service : ${response.data.toString()}');
      return response.data;
    } catch (e) {
      print(' Web Service : ${e.toString()}');
      return [];
    }
  }

  }

