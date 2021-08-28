import 'package:khsomat/data/models/category_model.dart';
import 'package:khsomat/data/models/products_model.dart';
import 'package:khsomat/data/web_services/web_services.dart';

class ProductRepository{
     final ProductsWebServices productsWebServices;
     ProductRepository(this.productsWebServices);

     Future<List<Product>> getAllProducts() async {
       final products= await productsWebServices.getAllProducts();
       return products.map((product) => Product.fromJson(product)).toList();
     }

     Future<List<Category>> getAllCategories() async {
       final categories = await productsWebServices.getAllCategories();
       return categories.map((e) => Category.fromJson(e)).toList();
     }
     }