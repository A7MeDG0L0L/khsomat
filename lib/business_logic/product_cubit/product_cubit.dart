import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khsomat/business_logic/product_cubit/product_states.dart';
import 'package:khsomat/data/models/category_model.dart';
import 'package:khsomat/data/models/products_model.dart';
import 'package:khsomat/data/repository/products_repository.dart';

class ProductCubit extends Cubit<ProductStates>{
  ProductCubit(this.productRepository):super(ProductInitialState());
  static ProductCubit get(context) => BlocProvider.of(context);
 final ProductRepository productRepository;

List<Product> products=[];

List<Product> getProductsScreen({int pageNum=1,int? categoryNum}){
  emit(GetProductsScreenLoadingState());
  productRepository.getProductForProductScreen(pageNum: pageNum,categoryNum: categoryNum).then((value) {
    if(products.isNotEmpty){
      print(products);
      products.addAll(value);
    }else
      products=value;
    emit(GetProductsScreenSuccessState(value));

  }).catchError((error){
    print('Cubit Error : ${error.toString()}');
    emit(GetProductsScreenErrorState(error));
  });
  return products;
}

void sortProducts(){
  products.sort((a, b) => a.prices!.salePrice.compareTo(b.prices!.salePrice));
  emit(ProductSortedState());
}

  List<Category> categories=[];

  List<Category> getAllCategories(){
    emit(GetCategoriesForProductScreenLoadingState());
    productRepository.getAllCategories().then((category) {
      categories=category;
      //print(categories[1].id.toString());
      emit(GetCategoriesForProductScreenSuccessState(category));
    }).catchError((error){
      print('Cubit Error : ${error.toString()}');
      emit(GetCategoriesForProductScreenErrorState(error));
    });
    return categories;
  }

}