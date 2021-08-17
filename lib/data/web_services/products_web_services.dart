import 'package:dio/dio.dart';

class ProductsWebServices {
  static late Dio dio;

  ProductsWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: 'https://khsomat.com/wp-json/',
      receiveDataWhenStatusError: true,
      connectTimeout: 2 * 1000,
      receiveTimeout: 2 * 1000,
    );

    dio = Dio(options);
  }

  Future<List<dynamic>> getAllProducts() async {
    try {
      Response response = await dio.get('/wc/store/products');
      print(response.data.toString());
      return response.data;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
