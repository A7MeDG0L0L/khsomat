import 'package:khsomat/data/models/category_model.dart';
import 'package:khsomat/data/models/products_model.dart';
import 'package:khsomat/data/models/register_model.dart';
import 'package:khsomat/data/web_services/web_services.dart';

class ProductRepository{
     final WebServices productsWebServices;
     ProductRepository(this.productsWebServices);

     Future<List<Product>> getAllProducts() async {
       final products= await productsWebServices.getAllProducts();
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

     // Future<UserModel> postRegisterUser({
     //   required String username,
     //   required String email,
     //   required String password,
     // }) async {
     //   final register = await productsWebServices.postRegisterUser(username: username, email: email, password: password);
     //   return register;
     // }
     }