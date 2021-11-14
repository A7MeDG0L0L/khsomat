import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khsomat/Shared/components.dart';
import 'package:khsomat/Shared/constants.dart';
import 'package:khsomat/business_logic/product_cubit/product_cubit.dart';
import 'package:khsomat/business_logic/product_cubit/product_states.dart';
import 'package:khsomat/data/cache_helper/cache_helper.dart';
import 'package:khsomat/data/models/category_model.dart';
import 'package:khsomat/data/models/products_model.dart';
import 'package:khsomat/data/repository/products_repository.dart';
import 'package:khsomat/data/web_services/web_services.dart';
import 'package:khsomat/presentation/UI/Widgets/product_item.dart';

import 'package:flutter_paginator_ns/flutter_paginator.dart';


class ProductScreen extends StatefulWidget {
  ProductScreen({Key? key}) : super(key: key);


  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  static late List<Product> productScreen = [];

  int page=1;

  ScrollController _controller=ScrollController();
  Category? category;


@override
  void initState() {
  // ScrollController _controller=ScrollController();
  _controller = ScrollController();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit(ProductRepository(WebServices()))
        ..getProductsScreen(pageNum: 1)..getAllCategories(),
      child: BlocConsumer<ProductCubit, ProductStates>(
        listener: (context, state) {

          _scrollListener() {
            if (_controller.offset >= _controller.position.maxScrollExtent &&
                !_controller.position.outOfRange) {
              setState(()  {
                print("reach the bottom");
                /// Not G.O.A.T
              //  ProductCubit.get(context).getProductsScreen(pageNum: page++);
                print(page);
                // _controller.jumpTo(_controller.position.maxScrollExtent);
              });
            }
            if (_controller.offset <= _controller.position.minScrollExtent &&
                !_controller.position.outOfRange) {
              setState(() {
                print( "reach the top");
              });
            }

          }
          _controller.addListener(_scrollListener);

          if (state is GetProductsScreenSuccessState) {
            productScreen = state.product;
          }
        },
        builder: (context, state) {
          if(state is GetProductsScreenSuccessState)
          return SingleChildScrollView(
            controller: _controller,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                // TextButton(
                //   child: Text('Sort'),
                //   onPressed: (){
                //     // List<Map<String, dynamic>> myProducts = [
                //     //   {"name": "Shoes", "price": 100},
                //     //   {"name": "Pants", "price": 50},
                //     //   {"name": "Book", "price": 10},
                //     //   {"name": "Lamp", "price": 40},
                //     //   {"name": "Fan", "price": 200}
                //     // ];
                //     setState(() {
                //       productScreen.sort((a, b) => a.prices!.salePrice.compareTo(b.prices!.salePrice));
                //       productScreen.reversed;
                //     });
                //
                //
                //     print(productScreen);
                //     //  ProductCubit.get(context).getProductsScreen(pageNum: 1);
                //     // _controller.jumpTo(_controller.position.maxScrollExtent);
                //    // printWrapped(productScreen.toString());
                //    //  myProducts.sort([]);
                //    //  print(myProducts);
                //   },
                // ),
                // TextButton(
                //   child: Text('1'),
                //   onPressed: (){
                //     //  ProductCubit.get(context).getProductsScreen(pageNum: 1);
                //     _controller.jumpTo(_controller.position.maxScrollExtent);
                //   },
                // ),
                Container(
                  height: 150.h,
                  child: ListView.separated(
                      padding: EdgeInsets.all(9.0),
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => buildCatItem(
                          ProductCubit.get(context).categories[index], context),
                      separatorBuilder: (context, index) => Divider(height: 1.h,),
                      itemCount: ProductCubit.get(context).categories.length),
                ),
                SizedBox(
                  height: 20.h,
                ),
                GridView.count(
                  // controller: _controller,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,

                  /// TODO: Enhance this later
                  childAspectRatio: 1.w / 1.82.h,
                  crossAxisCount: 2,
                  children: List.generate(
                    // ProductCubit.get(context).products.length,
                    productScreen.length,
                        (index) => ProductItem(product: productScreen[index],
                      // product: ProductCubit.get(context).products[index],
                    ),
                  ),
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                ),
              ],
            ),
          ),


                // TextButton(
                //   child: Text('1'),
                //   onPressed: (){
                //   //  ProductCubit.get(context).getProductsScreen(pageNum: 1);
                //     _controller.jumpTo(0.0);
                //   },
                // ),

                Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      child: Text('1'),
                      onPressed: (){
                        ProductCubit.get(context).getProductsScreen(pageNum: 1,categoryNum: categoryID);
                        // _controller.jumpTo(0.0);
                      },
                    ),
                    // SizedBox(
                    //   width: 4.w,
                    // ),
                    TextButton(
                      child: Text('2'),
                      onPressed: (){
                        print(categoryID);
                        ProductCubit.get(context).getProductsScreen(pageNum: 2,categoryNum: category!.id);
                        // _controller.jumpTo(0.0);
                      },
                    ),
                    // SizedBox(
                    //   width: 4.w,
                    // ),
                    TextButton(
                      child: Text('3'),
                      onPressed: (){
                       // print(category!.id);
                        print(categoryID);

                        ProductCubit.get(context).getProductsScreen(pageNum: 3,categoryNum: categoryID);
                        // _controller.jumpTo(0.0);
                      },
                    ),
                    // SizedBox(
                    //   width: 4.w,
                    // ),
                    TextButton(
                      child: Text('4'),
                      onPressed: (){
                        print(category!.id);

                        ProductCubit.get(context).getProductsScreen(pageNum: 4,categoryNum: categoryID);
                        // _controller.jumpTo(0.0);
                      },
                    ),
                    // SizedBox(
                    //   width: 2.w,
                    // ),
                    TextButton(
                      child: Text('5'),
                      onPressed: (){
                        ProductCubit.get(context).getProductsScreen(pageNum: 5,categoryNum: categoryID);
                        // _controller.jumpTo(0.0);
                      },
                    ),
                    // SizedBox(
                    //   width: 2.w,
                    // ),
                  ],

                ),
              ],
            ),
          );
          else
            return loadingIndicator();
        },
      ),
    );
  }

  Widget buildCatItem(Category model, context) {
    return Conditional.single(
      context: context,
      conditionBuilder: (context) => model.parent == 0,
      widgetBuilder: (context) => InkWell(
        onTap: () {
          ///TODO:value didn't change after saved!

          CacheHelper.saveData(key: 'categoryID', value: model.id);
          print(categoryID);
          print(model.id);
          ProductCubit.get(context).getProductsScreen(pageNum: 1,categoryNum: model.id);
        },
        child: Container(
          height: 100.h,
          child: Column(
            children: [
              Container(
                height: 100.h,
                width: 100.w,
                // child: model.image != null
                //     ? FadeInImage.assetNetwork(
                //         placeholder: 'assets/loading/loading.gif',
                //         image: model.image!.src,
                //       )
                //     : Image.asset('assets/images/Newplaceholder2.png',fit: BoxFit.cover,),

                child: model.image != null ? CachedNetworkImage(imageUrl: model.image!.src,placeholder: (context, url) => Image.asset('assets/loading/loading.gif'),):Image.asset('assets/images/Newplaceholder2.png',fit: BoxFit.cover,),
              ),
              SizedBox(
                height: 8.h,
              ),
              Container(
                width: 100.w,
                child: Text(
                  model.name,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  textWidthBasis: TextWidthBasis.parent,
                  style: TextStyle(
                      fontFamily: 'Almarai',
                      fontSize: 12.w
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      fallbackBuilder: (context) => Text(''),
    );
  }
}
