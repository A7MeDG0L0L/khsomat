

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khsomat/Shared/components.dart';
import 'package:khsomat/Shared/constants.dart';
import 'package:khsomat/business_logic/home_cubit/home_cubit.dart';
import 'package:khsomat/business_logic/home_cubit/home_state.dart';
import 'package:khsomat/data/models/category_model.dart';
import 'package:khsomat/data/models/products_model.dart';
import 'package:khsomat/presentation/UI/Widgets/product_item.dart';
import 'package:khsomat/presentation/UI/products_category_screen.dart';
import 'package:khsomat/translations/locale_keys.g.dart';
import 'package:lottie/lottie.dart';
import 'package:translator/translator.dart';

class HomeScreen extends StatelessWidget {
  List<Widget> carouselItems = [
    // Image(
    //   image: NetworkImage('https://khsomat.com/wp-content/slider/1.png'),
    // ),
    // Image(
    //   image: AssetImage('assets/images/bannertest3.jpg'),
    // ),
    // Image(
    //   image: AssetImage('assets/images/slideshow1.jpg'),
    // ),
    // Image(
    //   image: AssetImage('assets/images/slideResize.jpg'),
    // ),
    // Image(
    //   image: AssetImage('assets/images/resize2.jpg'),
    // ),
    // Image(
    //   image: AssetImage('assets/images/800x600.jpg'),
    // ),
    // Image(
    //   image: AssetImage('assets/images/slide1.jpg'),
    // ),
    // Image(
    //   image: AssetImage('assets/images/bannertest.jpg'),
    // ),
    // Image(
    //   image: AssetImage('assets/images/bannertest2.jpg'),
    // ),
    // Image(
    //   image: AssetImage('assets/images/test.jpg'),
    // ),
    Image(
      image: AssetImage('assets/images/shoes arrival 800x300.jpg'),
    ),
    Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadiusDirectional.circular(40)),
      child: Image(
        image: AssetImage('assets/images/Summer and winter800x300.jpg'),
      ),
    ),
    Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadiusDirectional.circular(40)),
      child: Image(
        image: AssetImage('assets/images/800x300 weekend.jpg'),
      ),
    ),
  ];

  final translator = GoogleTranslator();



  late List<Product> allProducts;
  late List<Category> allCategories;
  late String translation;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is GetProductsSuccessState) {
          //state.products.shuffle();
          allProducts = state.products;

          allProducts.shuffle();

          return builderWidget(context);
        } else {
          return loadingIndicator();
        }
      },
    );
  }

//Conditional.single(context: context,
//         conditionBuilder: (context) => HomeCubit.get(context).products== null ,
//         widgetBuilder: (context) => builderWidget(context),
//         fallbackBuilder: (context) => Center(
//           child: Container(
//               height: 150,
//               width: 200,
//               child: Lottie.asset('assets/loading/loading.json')),
//         ),);

  Widget builderWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: carouselItems,
              options: CarouselOptions(
                height: 150.h,
                scrollPhysics: BouncingScrollPhysics(),
                enlargeCenterPage: true,
                // pageSnapping: false,
                //aspectRatio: 1/2,
                initialPage: 0,
                viewportFraction: 1.0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Text(
              LocaleKeys.categories.tr(),
              style: TextStyle(
                fontFamily: 'Almarai',
                fontSize: 20.sp,
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Container(
              height: 150.h,
              child: ListView.separated(
                  padding: EdgeInsets.all(9.0),
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => buildCatItem(
                      HomeCubit.get(context).categories[index], context),
                  separatorBuilder: (context, index) => myDivider(),
                  itemCount: HomeCubit.get(context).categories.length),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              LocaleKeys.new_products.tr(),
              style: TextStyle(
                fontFamily: 'Almarai',
                fontSize: 20.sp,
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            LayoutBuilder(builder: (context, constraints) {
              print(MediaQuery.of(context).size.aspectRatio);
              print(MediaQuery.of(context).size.height.toInt());
              print(MediaQuery.of(context).size.width.toInt());
              return GridView.count(
                physics: BouncingScrollPhysics(),
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,

                /// TODO: Enhance this later
                childAspectRatio: 1.w/1.82.h,
                crossAxisCount: 2,
                shrinkWrap: true,
                children: List.generate(
                  allProducts.length-76,
                  (index) => ProductItem(product: allProducts[index]),

                  // here wasn't route to product details Screen

                  /* buildGridProduct(allProducts[index],context),*/
                ),
              );
            }),
            InkWell(onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductsForCategoryScreen(id: 142, name: 'ملابس اطفال'),));
            },child: Image(image: AssetImage('assets/images/kids.jpg'),)),
            SizedBox(
              height: 15.h,
            ),
            LayoutBuilder(builder: (context, constraints) {
              // print(MediaQuery.of(context).size.aspectRatio);
              // print(MediaQuery.of(context).size.height.toInt());
              // print(MediaQuery.of(context).size.width.toInt());
              return GridView.count(
                physics: BouncingScrollPhysics(),
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,

                /// TODO: Enhance this later
                childAspectRatio: 1.w/1.82.h,
                crossAxisCount: 2,
                shrinkWrap: true,
                children: List.generate(
                  allProducts.length-76,
                      (index) => ProductItem(product: allProducts[index+24]),

                  // here wasn't route to product details Screen

                  /* buildGridProduct(allProducts[index],context),*/
                ),
              );
            }),

            InkWell(onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductsForCategoryScreen(id: 3195, name: 'راجعين المدارس'),));
            },child: Image(image: AssetImage('assets/images/ack to school.jpg'),)),
            SizedBox(
              height: 15.h,
            ),
            LayoutBuilder(builder: (context, constraints) {
              // print(MediaQuery.of(context).size.aspectRatio);
              // print(MediaQuery.of(context).size.height.toInt());
              // print(MediaQuery.of(context).size.width.toInt());
              return GridView.count(
                physics: BouncingScrollPhysics(),
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,

                /// TODO: Enhance this later
                childAspectRatio: 1.w/1.82.h,
                crossAxisCount: 2,
                shrinkWrap: true,
                children: List.generate(
                  allProducts.length-76,
                      (index) => ProductItem(product: allProducts[index+48]),

                  // here wasn't route to product details Screen

                  /* buildGridProduct(allProducts[index],context),*/
                ),
              );
            }),
            InkWell(onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductsForCategoryScreen(id: 165, name: 'موبايلات'),));
            },child: Image(image: AssetImage('assets/images/mobiles.jpg'),)),
            SizedBox(
              height: 15.h,
            ),
            LayoutBuilder(builder: (context, constraints) {
              // print(MediaQuery.of(context).size.aspectRatio);
              // print(MediaQuery.of(context).size.height.toInt());
              // print(MediaQuery.of(context).size.width.toInt());
              return GridView.count(
                physics: BouncingScrollPhysics(),
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,

                /// TODO: Enhance this later
                childAspectRatio: 1.w/1.82.h,
                crossAxisCount: 2,
                shrinkWrap: true,
                children: List.generate(
                  allProducts.length-76,
                      (index) => ProductItem(product: allProducts[index+72]),

                  // here wasn't route to product details Screen

                  /* buildGridProduct(allProducts[index],context),*/
                ),
              );
            }),
            InkWell(onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductsForCategoryScreen(id: 175, name: 'ساعات و نظارات'),));
            },child: Image(image: AssetImage('assets/images/sunglasses.jpg'),)),
            SizedBox(
              height: 15.h,
            ),
            LayoutBuilder(builder: (context, constraints) {
              // print(MediaQuery.of(context).size.aspectRatio);
              // print(MediaQuery.of(context).size.height.toInt());
              // print(MediaQuery.of(context).size.width.toInt());
              return GridView.count(
                physics: BouncingScrollPhysics(),
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,

                /// TODO: Enhance this later
                childAspectRatio: 1.w/1.82.h,
                crossAxisCount: 2,
                shrinkWrap: true,
                children: List.generate(
                  allProducts.length-76,
                      (index) => ProductItem(product: allProducts[index+75]),

                  // here wasn't route to product details Screen

                  /* buildGridProduct(allProducts[index],context),*/
                ),
              );
            }),
            InkWell(onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductsForCategoryScreen(id: 126, name: 'خصومات ماركت'),));
            },child: Image(image: AssetImage('assets/images/market.jpg'),)),

            // Text(
            //   'الأقسام',
            //   style: TextStyle(
            //     fontFamily: 'Almarai',
            //     fontSize: 20.sp,
            //   ),
            // ),
            // SizedBox(
            //   height: 15.h,
            // ),
            // GridView.count(
            //   physics: BouncingScrollPhysics(),
            //   mainAxisSpacing: 10.w,
            //   crossAxisSpacing: 10.h,
            //   childAspectRatio: 1 / 1,
            //   crossAxisCount: 3,
            //   shrinkWrap: true,
            //   children: List.generate(
            //     15,
            //     (index) => buildLargeCatItem(),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget buildCatItem(Category model, context) {
    return Conditional.single(
      context: context,
      conditionBuilder: (context) => model.parent == 0,
      widgetBuilder: (context) => InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductsForCategoryScreen(
                  id: model.id,
                  name: model.name,
                ),
              ));
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

  Widget myDivider() {
    return SizedBox(
      width: 1.w,
    );
  }

  // Widget buildGridProduct(Product model,context) => InkWell(
  //       onTap: () {
  //         Navigator.pushNamed(context, productDetailsScreen, arguments: allProducts  );
  //
  //       },
  //       child: Hero(
  //         tag: model.id,
  //         child: Container(
  //           color: Colors.white,
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Stack(
  //                 alignment: AlignmentDirectional.bottomStart,
  //                 children: [
  //                   Container(
  //                     child: model.images.isNotEmpty
  //                         ? FadeInImage.assetNetwork(
  //                             fit: BoxFit.cover,
  //                             image: model.images[0].src,
  //                             width: double.infinity,
  //                             height: 200.0,
  //                             placeholder: 'assets/loading/loading.gif',
  //                           )
  //                         : Image.asset('assets/images/placeholder.jpg'),
  //                   ),
  //                   if (model.onSale == true &&
  //                       model.prices.regularPrice != model.prices.salePrice)
  //                     Container(
  //                       color: Colors.red,
  //                       padding: EdgeInsets.symmetric(
  //                         horizontal: 5.0,
  //                       ),
  //                       child: Text(
  //                         'DISCOUNT',
  //                         style: TextStyle(
  //                           fontSize: 8.0,
  //                           color: Colors.white,
  //                         ),
  //                       ),
  //                     ),
  //                 ],
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.all(12.0),
  //                 child: Container(
  //                   height: 100,
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Text(
  //                         model.name,
  //                         maxLines: 2,
  //                         overflow: TextOverflow.ellipsis,
  //                         style: TextStyle(
  //                           fontFamily: 'Almarai',
  //                           fontSize: 14.0,
  //                           height: 1.2,
  //                         ),
  //                       ),
  //                       Spacer(),
  //                       Row(
  //                         children: [
  //                           if (model.prices.salePrice.length == 4)
  //                             Text(
  //                               model.prices.salePrice.substring(0, 2)
  //                               /*'${model.price.round()}'*/,
  //                               style: TextStyle(
  //                                 fontFamily: 'Almarai',
  //                                 fontSize: 20.0,
  //                                 color: defColor,
  //                               ),
  //                             ),
  //                           if (model.prices.salePrice.length == 5)
  //                             Text(
  //                               model.prices.salePrice.substring(0, 3)
  //                               /*'${model.price.round()}'*/,
  //                               style: TextStyle(
  //                                 fontFamily: 'Almarai',
  //                                 fontSize: 20.0,
  //                                 color: defColor,
  //                               ),
  //                             ),
  //                           if (model.prices.salePrice.length == 6)
  //                             Text(
  //                               model.prices.salePrice.substring(0, 4)
  //                               /*'${model.price.round()}'*/,
  //                               style: TextStyle(
  //                                 fontFamily: 'Almarai',
  //                                 fontSize: 20.0,
  //                                 color: defColor,
  //                               ),
  //                             ),
  //                           if (model.prices.salePrice.length == 7)
  //                             Text(
  //                               model.prices.salePrice.substring(0, 5)
  //                               /*'${model.price.round()}'*/,
  //                               style: TextStyle(
  //                                 fontFamily: 'Almarai',
  //                                 fontSize: 20.0,
  //                                 color: defColor,
  //                               ),
  //                             ),
  //                           Text(
  //                             'ج',
  //                             style: TextStyle(
  //                               fontFamily: 'Almarai',
  //                               fontSize: 12,
  //                             ),
  //                           ),
  //                           SizedBox(
  //                             width: 10.0,
  //                           ),
  //                           if (model.onSale == true &&
  //                               model.prices.regularPrice !=
  //                                   model.prices.salePrice &&
  //                               model.prices.regularPrice.length == 4)
  //                             Text(
  //                               model.prices.regularPrice.substring(0, 2)
  //                               /* '${model.oldPrice.round()}'*/,
  //                               style: TextStyle(
  //                                 fontFamily: 'Almarai',
  //                                 fontSize: 18.0,
  //                                 color: Colors.grey,
  //                                 decoration: TextDecoration.lineThrough,
  //                               ),
  //                             ),
  //                           if (model.onSale == true &&
  //                               model.prices.regularPrice !=
  //                                   model.prices.salePrice &&
  //                               model.prices.regularPrice.length == 5)
  //                             Text(
  //                               model.prices.regularPrice.substring(0, 3)
  //                               /* '${model.oldPrice.round()}'*/,
  //                               style: TextStyle(
  //                                 fontFamily: 'Almarai',
  //                                 fontSize: 18.0,
  //                                 color: Colors.grey,
  //                                 decoration: TextDecoration.lineThrough,
  //                               ),
  //                             ),
  //                           if (model.onSale == true &&
  //                               model.prices.regularPrice !=
  //                                   model.prices.salePrice &&
  //                               model.prices.regularPrice.length == 6)
  //                             Text(
  //                               model.prices.regularPrice.substring(0, 4)
  //                               /* '${model.oldPrice.round()}'*/,
  //                               style: TextStyle(
  //                                 fontFamily: 'Almarai',
  //                                 fontSize: 18.0,
  //                                 color: Colors.grey,
  //                                 decoration: TextDecoration.lineThrough,
  //                               ),
  //                             ),
  //                           if (model.onSale == true &&
  //                               model.prices.regularPrice !=
  //                                   model.prices.salePrice &&
  //                               model.prices.regularPrice.length == 7)
  //                             Text(
  //                               model.prices.regularPrice.substring(0, 5)
  //                               /* '${model.oldPrice.round()}'*/,
  //                               style: TextStyle(
  //                                 fontFamily: 'Almarai',
  //                                 fontSize: 18.0,
  //                                 color: Colors.grey,
  //                                 decoration: TextDecoration.lineThrough,
  //                               ),
  //                             ),
  //                           Spacer(),
  //                           IconButton(
  //                             onPressed: () {
  //                               /*  ShopCubit.get(context).changeFavorites(model.id);
  //                               print(model.id);*/
  //                             },
  //                             icon: CircleAvatar(
  //                               radius: 15.0,
  //                               backgroundColor:
  //                                   /*ShopCubit
  //                                   .get(context)
  //                                   .favorites[model.id]
  //                                   ? defaultColor
  //                                   :*/
  //                                   Colors.grey,
  //                               child: Icon(
  //                                 Icons.favorite_border,
  //                                 size: 14.0,
  //                                 color: Colors.white,
  //                               ),
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     );

  Widget buildLargeCatItem() {
    return InkWell(
      onTap: () {},
      child: Container(
        color: Colors.white,
        child: Image(
          image: AssetImage('assets/images/placeholder.jpg'),
        ),
      ),
    );
  }
}
