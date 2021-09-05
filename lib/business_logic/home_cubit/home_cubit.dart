import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khsomat/Shared/constants.dart';
import 'package:khsomat/business_logic/home_cubit/home_state.dart';
import 'package:khsomat/data/models/category_model.dart';
import 'package:khsomat/data/models/products_model.dart';
import 'package:khsomat/data/repository/products_repository.dart';
import 'package:khsomat/data/web_services/web_services.dart';
import 'package:khsomat/presentation/UI/cart_screen.dart';
import 'package:khsomat/presentation/UI/favorites_screen.dart';
import 'package:khsomat/presentation/UI/app_layout.dart';
import 'package:khsomat/presentation/UI/home_screen.dart';
import 'package:khsomat/presentation/UI/profile_screen.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit(this.productRepository) : super(InitialHomeState());

  static HomeCubit get(context) => BlocProvider.of(context);
  final ProductRepository productRepository;


  int currentIndex = 0;
  List<Widget> screens = [
    HomeScreen(),
    FavoritesScreen(),
    CartScreen(),
    ProfileScreen(),
  ];
  void navBarChanger(int index) {
    currentIndex = index;
    emit(NavBarChangeState());
    getAllProducts();
    getAllCategories();
  }

  List<Product> products = [];

  List<Product>? getAllProducts() {
    emit(GetProductsLoadingState());
    productRepository.getAllProducts().then((product) {
      products = product;
      print(products);
      emit(GetProductsSuccessState(product));
    }).catchError((error) {
      print('Cubit Error : ${error.toString()}');
      emit(GetProductsErrorState(error));
    });
    return products;
  }


 // without repository get data successfully
 //  void getProducts(){
 //    emit(GetProductsLoadingState());
 //    ProductsWebServices.dio.get('/wc/store/products').then((value) {
 //      products=value.data;
 //      print(products);
 //      emit(GetProductsSuccessState(products));
 //    }).catchError((error){
 //     print(error.toString());
 //     emit(GetProductsErrorState(error));
 //    });
 //  }

  List<Category> categories=[];

  List<Category> getAllCategories(){
    emit(GetCategoriesLoadingState());
    productRepository.getAllCategories().then((category) {
      categories=category;
      print(categories);
      emit(GetCategoriesSuccessState(category));
    }).catchError((error){
      print('Cubit Error : ${error.toString()}');
    });
    return categories;
  }
  void getProductsAndCategoriesSuccess(){
    getAllProducts();
    getAllCategories();
    emit(GetProductsAndCategoriesSuccessState(products,categories));
  }
  // void saveFavList(Product product){
  //   favListConst.add(product);
  //   print('Added This Item to List : ${product.name}');
  // }
}
