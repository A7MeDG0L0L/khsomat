import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khsomat/business_logic/home_cubit/home_state.dart';
import 'package:khsomat/data/models/products_model.dart';
import 'package:khsomat/data/repository/products_repository.dart';
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
  }

 late List<Product> products = [];

  List<Product> getAllProducts() {
    emit(GetProductsLoadingState());
    productRepository.getAllProducts().then((product) {
      products = product;
      print(products);
      emit(GetProductsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetProductsErrorState(error));
    });
    return products;
  }
}
