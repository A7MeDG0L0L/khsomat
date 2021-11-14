import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khsomat/Shared/constants.dart';
import 'package:khsomat/business_logic/home_cubit/home_state.dart';
import 'package:khsomat/data/models/category_model.dart';
import 'package:khsomat/data/models/new_product_model.dart';
import 'package:khsomat/data/models/products_model.dart';
import 'package:khsomat/data/repository/products_repository.dart';
import 'package:khsomat/data/web_services/web_services.dart';
import 'package:khsomat/presentation/UI/cart_screen.dart';
import 'package:khsomat/presentation/UI/favorites_screen.dart';
import 'package:khsomat/presentation/UI/app_layout.dart';
import 'package:khsomat/presentation/UI/home_screen.dart';
import 'package:khsomat/presentation/UI/products_screen.dart';
import 'package:khsomat/presentation/UI/profile_screen.dart';
import 'package:sqflite/sqflite.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit(this.productRepository) : super(InitialHomeState());

  static HomeCubit get(context) => BlocProvider.of(context);
  final ProductRepository productRepository;

 // Product? product;
  int currentIndex = 0;
  List<Widget> screens = [
    HomeScreen(),
    ProductScreen(),
    //FavoritesScreen(product: product!),
    FavoritesScreen(),
    CartScreen(),
    ProfileScreen(),
  ];
  void navBarChanger(int index) {
    currentIndex = index;
    emit(NavBarChangeState());
    if(currentIndex==0){
    getAllProducts();
    getAllCategories();
    }
  }

  List<Product> products = [];

  List<Product>? getAllProducts({List<int>? productIds}) {
    emit(GetProductsLoadingState());
    productRepository.getAllProducts(productIds:productIds ).then((product) {
      products = product;
     // print(products);
      emit(GetProductsSuccessState(product));
    }).catchError((error) {
      print('Cubit Error : ${error.toString()}');
      emit(GetProductsErrorState(error));
    });
    return products;
  }

  List<Product> productsForCategory = [];

  List<Product>? getAllProductsForCategory(int id) {
    emit(GetProductsForCategoryLoadingState());
    productRepository.getAllProductsForCategory(id).then((product) {
      productsForCategory = product;
       print('Response From Cubit : ${productsForCategory.toString()}');
      emit(GetProductsForCategorySuccessState(product));
    }).catchError((error) {
      print('Cubit Error : ${error.toString()}');
      emit(GetProductsForCategoryErrorState(error));
    });
    return productsForCategory;
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
     //print(categories[1].id.toString());
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


  Future<void> createDatabase() async {
    database = await openDatabase(
      'wishlist.db',
      version: 1,
      onCreate: (database, version) {
        print('database Created Successfully !');
        database.execute(
            'CREATE TABLE wishlist (product_id INTEGER, name TEXT, image TEXT, regularprice INTEGER,saleprice INTEGER,permalink TEXT)');
        database.execute(
            'CREATE TABLE orderlist (id INTEGER PRIMARY KEY,"product_id" INTEGER, "name" TEXT, "image" TEXT, "regularprice" INTEGER,"saleprice" INTEGER,"permalink" TEXT,"quantity" INTEGER,"variation_id" INTEGER)');

        print('table Created Successfully !');
        //     .catchError((error) {
        //   print('Error While Creating Table Wishlist : ${error.toString()}');
        // });
      },
      onOpen: (database) {
        getWishListDataFromDatabase(database);
        getOrderListDataFromDatabase(database);
        // print(productList);
        print('database Opened Successfully !');
      },
    );
    // database = value;
    print(wishList);

    emit(AppCreatedDatabaseState());
  }


  void getWishListDataFromDatabase(database) async {
    //productList = [];
    wishList=[];
    emit(AppGetWishListDatabaseLoadingState());

    await database.rawQuery('SELECT * FROM wishlist').then((value) {
      value.forEach((product) {
        wishList.add(product);
        //checkItems();
        print(wishList);
      });
      emit(GetWishListFromDataBaseState());
    });
  }

  void getOrderListDataFromDatabase(database) async {
    //productList = [];
    emit(AppGetOrderListDatabaseLoadingState());

    await database.rawQuery('SELECT * FROM orderlist').then((value) {
      value.forEach((product) {
        //  orderList.add(product);
        orderList.add(Map.of(product));
        print(orderList);
      });
      emit(GetOrderListFromDataBaseState());
    });
  }

  NewProductModel? newProductModel;
  List<int> relatedProductsID=[];
  Future<void> getRelatedProductsID(int id)async {
    emit(GetRelatedProductIDLoadingState());
    WebServices.dio.get('/wc/v3/products/$id',queryParameters: {
      'consumer_key': 'ck_fa054c2eea7057ed605ce37417fe5e92fb2d428b',
      'consumer_secret': 'cs_a2bcff0feec2d96d830b08ecf93015f6de9b409e'
    },).then((value) {
      newProductModel=NewProductModel.fromJson(value.data);
      relatedProductsID=newProductModel!.upsellIds!;
      print(relatedProductsID.join(','));
      emit(GetRelatedProductIDSuccessState());

    }).catchError((error){
      print(error);
      emit(GetRelatedProductIDErrorState(error));
    });
  }
// Product? product;
  List<Product> relatedProducts=[];
  List<Product> getRelatedProducts(){
    emit(GetRelatedProductLoadingState());
    productRepository.getRelatedProducts(productIds: relatedProductsID).then((value) {
      relatedProducts=value;
      print(relatedProducts);
      emit(GetRelatedProductSuccessState());
    }).catchError((error){print(error);
    emit(GetRelatedProductErrorState(error));});
    // WebServices.dio.get('/wc/store/products',queryParameters: {
    //   'include':relatedProductsID.join(','),
    //   'consumer_key': 'ck_fa054c2eea7057ed605ce37417fe5e92fb2d428b',
    //   'consumer_secret': 'cs_a2bcff0feec2d96d830b08ecf93015f6de9b409e'
    // },).then((value) {
    //   relatedProducts=Product.fromJson(value.data) as List<Product>;
    //   print(relatedProducts);
    //   emit(GetRelatedProductSuccessState());
    //
    // }).catchError((error){
    //   print(error);
    //   emit(GetRelatedProductErrorState(error));
    // });
  return relatedProducts;
  }


}
