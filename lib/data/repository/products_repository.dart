import 'package:khsomat/data/models/products_model.dart';
import 'package:khsomat/data/web_services/products_web_services.dart';

class ProductRepository{
     final ProductsWebServices productsWebServices;
     ProductRepository(this.productsWebServices);

     Future<List<Product>> getAllProducts() async {
       final products= await productsWebServices.getAllProducts();
       return products.map((product) => Product.fromJson(product)).toList();
     }

}