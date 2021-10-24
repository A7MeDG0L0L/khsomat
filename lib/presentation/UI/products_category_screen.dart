import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khsomat/Shared/components.dart';
import 'package:khsomat/business_logic/home_cubit/home_cubit.dart';
import 'package:khsomat/business_logic/home_cubit/home_state.dart';
import 'package:khsomat/data/models/products_model.dart';
import 'package:khsomat/data/repository/products_repository.dart';
import 'package:khsomat/data/web_services/web_services.dart';
import 'package:lottie/lottie.dart';

import 'Widgets/product_item.dart';

class ProductsForCategoryScreen extends StatelessWidget {
  final int id;
  final String name;
  late List<Product> productsCategory = [];

  ProductsForCategoryScreen({Key? key, required this.id, required this.name})
      : super(key: key);
  // final Product product;

//   ProductsForCategoryScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(ProductRepository(WebServices()))
        ..getAllProductsForCategory(id),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          // if (state is GetProductsForCategorySuccessState) {
          //   productsCategory = state.productsForCategory;
          // }
        },
        builder: (context, state) {
          if (state is GetProductsForCategorySuccessState) {
            productsCategory = state.productsForCategory;
            return builderWidgetForProductsCategory();
          } else {
            return Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(),
                body: loadingIndicator());
          }
        },
      ),
    );
  }

  Widget builderWidgetForProductsCategory() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(name,style: TextStyle(fontSize: 20.sp),),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                // Container(color: Colors.red,width: 200,height: 200,),
                GridView.count(
                  physics: BouncingScrollPhysics(),
                  mainAxisSpacing: 10.h,
                  crossAxisSpacing: 10.w,
                  childAspectRatio: 1.w / 1.8.h,
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  children: List.generate(
                    productsCategory.length,
                    (index) => ProductItem(product: productsCategory[index]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
