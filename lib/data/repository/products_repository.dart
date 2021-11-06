import 'package:khsomat/data/models/category_model.dart';
import 'package:khsomat/data/models/new_product_model.dart';
import 'package:khsomat/data/models/order_model.dart';
import 'package:khsomat/data/models/products_model.dart';
import 'package:khsomat/data/models/register_model.dart';
import 'package:khsomat/data/web_services/web_services.dart';

class ProductRepository{
     final WebServices productsWebServices;
     ProductRepository(this.productsWebServices);

     Future<List<Product>> getAllProducts({List<int>? productIds}) async {
       final products= await productsWebServices.getAllProducts(productIds: productIds);
       return products.map((product) => Product.fromJson(product)).toList();
     }
     Future<List<Product>> getAllProductsForCategory(int id) async {
       final products= await productsWebServices.getAllProductsForCategory(id);
       return products.map((product) => Product.fromJson(product)).toList();
     }

     Future<List<Product>> getAllSearchProducts(String searchText) async{
       final searchProducts = await productsWebServices.getAllSearchProducts(searchText);
       return searchProducts.map((searchProduct) => Product.fromJson(searchProduct)).toList();
     }

     Future<List<Category>> getAllCategories() async {
       final categories = await productsWebServices.getAllCategories();
       return categories.map((e) => Category.fromJson(e)).toList();
     }
     Future<List<OrderModel>> retrieveCustomerOrders() async {
       final orders= await productsWebServices.retrieveCustomerOrders();
       return orders.map((e) => OrderModel.fromJson(e)).toList();
     }

       // Future<UserModel> postRegisterUser({
     //   required String username,
     //   required String email,
     //   required String password,
     // }) async {
     //   final register = await productsWebServices.postRegisterUser(username: username, email: email, password: password);
     //   return register;
     // }
     }