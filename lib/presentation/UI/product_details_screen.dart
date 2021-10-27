import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:group_button/group_button.dart';
import 'package:khsomat/Shared/components.dart';
import 'package:khsomat/Shared/my_colors.dart';
import 'package:khsomat/business_logic/favorites_cubit/favorites_cubit.dart';
import 'package:khsomat/business_logic/favorites_cubit/favorites_states.dart';
import 'package:khsomat/business_logic/home_cubit/home_cubit.dart';
import 'package:khsomat/business_logic/home_cubit/home_state.dart';
import 'package:khsomat/data/models/products_model.dart';
import 'package:html/parser.dart' show parse;
import 'package:share/share.dart';

class ProductDetailsScreen extends StatelessWidget {
  Product? product;
  final CarouselController carouselController = CarouselController();

  ProductDetailsScreen({this.product});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoritesCubit, FavoritesStates>(
      listener: (context, state) {},
      builder: (context, state) {
        int? variationId;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: Text(
              product!.name ?? 'Product Name',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Almarai',
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp),
            ),
            foregroundColor: Colors.white,
          ),
          body: CustomScrollView(
            slivers: [
              //carouselProductImage(),
              // buildSliverAppBar(),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    carouselProductImages(context),

                    // carouselProductImage(),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product!.name ?? 'name',
                              style: TextStyle(
                                fontFamily: 'Almarai',
                                fontSize: 24.sp,
                              ),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  '${product!.prices!.salePrice}',
                                  style: TextStyle(
                                    fontFamily: 'Almarai',
                                    fontSize: 20.0.sp,
                                    color: defColor,
                                  ),
                                ),
                                // if (product!.prices!.salePrice!.length == 4)
                                //   Text(
                                //     product!.prices!.salePrice!.substring(
                                //         0, 2) /*'${product!.price.round()}'*/,
                                //     style: TextStyle(
                                //       fontFamily: 'Almarai',
                                //       fontSize: 20.0,
                                //       color: defColor,
                                //     ),
                                //   ),
                                // if (product!.prices!.salePrice!.length == 5)
                                //   Text(
                                //     product!.prices!.salePrice!.substring(
                                //         0, 3) /*'${product!.price.round()}'*/,
                                //     style: TextStyle(
                                //       fontFamily: 'Almarai',
                                //       fontSize: 20.0,
                                //       color: defColor,
                                //     ),
                                //   ),
                                // if (product!.prices!.salePrice!.length == 6)
                                //   Text(
                                //     product!.prices!.salePrice!.substring(
                                //         0, 4) /*'${product!.price.round()}'*/,
                                //     style: TextStyle(
                                //       fontFamily: 'Almarai',
                                //       fontSize: 20.0,
                                //       color: defColor,
                                //     ),
                                //   ),
                                // if (product!.prices!.salePrice!.length == 7)
                                //   Text(
                                //     product!.prices!.salePrice!.substring(
                                //         0, 5) /*'${product!.price.round()}'*/,
                                //     style: TextStyle(
                                //       fontFamily: 'Almarai',
                                //       fontSize: 20.0,
                                //       color: defColor,
                                //     ),
                                //   ),
                                SizedBox(
                                  width: 4.w,
                                ),
                                Text(
                                  'جنية مصري',
                                  style: TextStyle(
                                    fontFamily: 'Almarai',
                                    fontSize: 12.sp,
                                  ),
                                ),
                                SizedBox(
                                  width: 5.0.w,
                                ),
                                if (product!.onSale == true)
                                  Text(
                                    'بدلاً من',
                                    style: TextStyle(
                                      fontFamily: 'Almarai',
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                Text(
                                  '${product!.prices!.regularPrice}',
                                  style: TextStyle(
                                    fontFamily: 'Almarai',
                                    fontSize: 18.0.sp,
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                // if (product!.onSale == true &&
                                //     product!.prices!.regularPrice !=
                                //         product!.prices!.salePrice &&
                                //     product!.prices!.regularPrice!.length == 4)
                                //   Text(
                                //     product!.prices!.regularPrice!.substring(0,
                                //         2) /* '${product!.oldPrice.round()}'*/,
                                //     style: TextStyle(
                                //       fontFamily: 'Almarai',
                                //       fontSize: 18.0,
                                //       color: Colors.grey,
                                //       decoration: TextDecoration.lineThrough,
                                //     ),
                                //   ),
                                // if (product!.onSale == true &&
                                //     product!.prices!.regularPrice !=
                                //         product!.prices!.salePrice &&
                                //     product!.prices!.regularPrice!.length == 5)
                                //   Text(
                                //     product!.prices!.regularPrice!.substring(0,
                                //         3) /* '${product!.oldPrice.round()}'*/,
                                //     style: TextStyle(
                                //       fontFamily: 'Almarai',
                                //       fontSize: 18.0,
                                //       color: Colors.grey,
                                //       decoration: TextDecoration.lineThrough,
                                //     ),
                                //   ),
                                // if (product!.onSale == true &&
                                //     product!.prices!.regularPrice !=
                                //         product!.prices!.salePrice &&
                                //     product!.prices!.regularPrice!.length == 6)
                                //   Text(
                                //     product!.prices!.regularPrice!.substring(0,
                                //         4) /* '${product!.oldPrice.round()}'*/,
                                //     style: TextStyle(
                                //       fontFamily: 'Almarai',
                                //       fontSize: 18.0,
                                //       color: Colors.grey,
                                //       decoration: TextDecoration.lineThrough,
                                //     ),
                                //   ),
                                // if (product!.onSale == true &&
                                //     product!.prices!.regularPrice !=
                                //         product!.prices!.salePrice &&
                                //     product!.prices!.regularPrice!.length == 7)
                                //   Text(
                                //     product!.prices!.regularPrice!.substring(0,
                                //         5) /* '${product!.oldPrice.round()}'*/,
                                //     style: TextStyle(
                                //       fontFamily: 'Almarai',
                                //       fontSize: 18.0,
                                //       color: Colors.grey,
                                //       decoration: TextDecoration.lineThrough,
                                //     ),
                                //   ),
                                Spacer(),
                                CircleAvatar(
                                  radius: 20.r,
                                  backgroundColor: Colors.grey[600],
                                  child: IconButton(
                                    onPressed: () {
                                      Share.share(
                                          ' شاهد هذا المنتج علي خصومات دوت كوم :${product!.permalink!}  ');
                                    },
                                    icon: Icon(
                                      Icons.share,
                                      color: Colors.amber,
                                      size: 18.w,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            // if (product!.type == "variable")
                            //   //   Container(
                            //   //     width: double.infinity,
                            //   //     height: 50.h,
                            //   //     child: ListView.separated(
                            //   //         scrollDirection: Axis.horizontal,
                            //   //         physics: BouncingScrollPhysics(),
                            //   //         shrinkWrap: true,
                            //   //         itemBuilder: (context, index) =>
                            //   //             OutlinedButton(
                            //   //               onPressed: () {},
                            //   //               child: Text(
                            //   //                 product!.attributes![0]['terms']
                            //   //                     [index]['name'],
                            //   //                 style: TextStyle(fontSize: 16.sp),
                            //   //               ),
                            //   //             ),
                            //   //         separatorBuilder: (context, index) =>
                            //   //             SizedBox(
                            //   //               width: 5.w,
                            //   //             ),
                            //   //         itemCount: product!
                            //   //             .attributes![0]['terms'].length),
                            //   //   ),
                            //   // SizedBox(
                            //   //   height: 20.h,
                            //   // ),
                            //   // if (product!.type == "variable" &&
                            //   //     product!.attributes!.length == 2)
                            //   // Container(
                            //   //   width: double.infinity,
                            //   //   height: 50.h,
                            //   //   child: ListView.separated(
                            //   //       scrollDirection: Axis.horizontal,
                            //   //       physics: BouncingScrollPhysics(),
                            //   //       shrinkWrap: true,
                            //   //       itemBuilder: (context, index) =>
                            //   //       OutlinedButton(
                            //   //             onPressed: () {},
                            //   //             child: Text(product!.attributes![1]
                            //   //                 ['terms'][index]['name'],style: TextStyle(fontSize: 16.sp),),
                            //   //           ),
                            //   //       separatorBuilder: (context, index) =>
                            //   //           SizedBox(
                            //   //             width: 5.w,
                            //   //           ),
                            //   //       itemCount: product!
                            //   //           .attributes![1]['terms'].length),
                            //   // ),
                              if (product!.type == "variable")
                                GroupButton(
                                  isRadio: true,
                                  buttons: List.generate(
                                      product!.variations!.length, (index) {

                                        if(product!.variations![index]
                                        ['attributes'].length >=2){
                                    return Uri.decodeFull(
                                        product!.variations![index]
                                                ['attributes'][0]['value'] +'-'+
                                            ( product!.variations![index]
                                            ['attributes'][1]['value'])??'Null');
                                        }
                                        else
                                        return Uri.decodeFull(
                                            product!.variations![index]
                                            ['attributes'][0]['value']??'Null');
                                  }),
                                  onSelected: (index, isSelected) {
                                    print('$index button is selected');
                                    print(product!.variations![index]['id']);
                                    variationId=product!.variations![index]['id'];
                                    return variationId;
                                  },
                                  borderRadius: BorderRadius.circular(20),
                                ),
                            // Text(Uri.decodeFull(product!.variations![0]['attributes'][0]['value'])+product!.variations![0]['attributes'][1]['value']),

                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                              'وصف المنتج',
                              style: TextStyle(
                                  fontFamily: 'Almarai', fontSize: 18.sp),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                color: Colors.grey.shade300,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: parseHtmlDescription(),
                              ),
                            ),
                            // Text(product!.variations![0]['attributes'][0]['value']),
                            //parseHtmlEnhancement('&percnt;&#100;&#56;&percnt;&#97;&#55;&percnt;&#100;&#56;&percnt;&#98;&#50;&percnt;&#100;&#56;&percnt;&#98;&#49;&percnt;&#100;&#57;&percnt;&#56;&#50;&#45;&percnt;&#100;&#56;&percnt;&#98;&#97;&percnt;&#100;&#56;&percnt;&#97;&#55;&percnt;&#100;&#57;&percnt;&#56;&#53;&percnt;&#100;&#57;&percnt;&#56;&#50;'),
                            //Text(jsonDecode(product!.variations![0]['attributes'][0]['value'])),
                            //Text(urlDecode()),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            height: 65.h,
                            decoration: BoxDecoration(
                              color: defColor,
                              borderRadius: BorderRadius.circular(50.r),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_shopping_cart_outlined,
                                  color: Colors.white,
                                ),
                                TextButton(
                                  onPressed: () {
                                    if (FavoritesCubit.get(context)
                                            .checkItem(product!.id) ==
                                        true) {
                                      showToast(
                                          text: 'المنتج موجود بالفعل في السلة',
                                          state: ToastStates.WARNING);
                                    } else {
                                      FavoritesCubit.get(context)
                                          .insertToOrderListDatabase(
                                        // id: product!.id!,
                                        productName: product!.name!,
                                        image: product!.images![0].src!,
                                        regularprice:
                                            product!.prices!.regularPrice!,
                                        saleprice: product!.prices!.salePrice!,
                                        permalink: product!.permalink!,
                                        quantity: 1,
                                        productId: product!.id!,
                                        variationId: variationId??0,
                                      );
                                      showToast(
                                          text: 'تم إضافة المنتج إلي السلة',
                                          state: ToastStates.SUCCESS);
                                    }
                                  },
                                  style: ButtonStyle(
                                    overlayColor:
                                        MaterialStateProperty.all(Colors.black),
                                  ),
                                  child: Text(
                                    'إضافة إلي السلة',
                                    style: TextStyle(
                                        fontFamily: 'Almarai',
                                        color: Colors.white,
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 400.h,
      pinned: true,
      stretch: true,
      backgroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        background: Hero(
          tag: product!.id!,
          child: Image.network(
            product!.images![0].src!,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget parseHtmlDescription() {
    var document = parse(product!.description);
    String parsedString = parse(document.body!.text).documentElement!.text;
    print(parsedString);
    return Text(
      parsedString,
      style: TextStyle(fontFamily: 'Almarai', fontSize: 15.sp),
    );
  }

  Widget parseHtmlEnhancement(var html) {
    var document = parse(html);
    String parsedString = parse(document.body!.text).documentElement!.text;
    print(parsedString);
    return Text(
      parsedString,
      style: TextStyle(fontFamily: 'Almarai', fontSize: 15.sp),
    );
  }

  String urlDecode() {
    var uri = product!.variations![1]['attributes'][0]['value'] +
        product!.variations![1]['attributes'][1]['value'];
    // var encoded = Uri.encodeFull(uri);
    // assert(encoded == 'http://example.org/api?foo=some%20message');

    var decoded = Uri.decodeFull(uri);
    // assert(uri == decoded);
    return decoded;
  }
  // Widget carouselProductImage() {
  //   return CarouselSlider(
  //     items: [
  //       if(product!.images.length >= 1)
  //       Image(image: NetworkImage(product!.images[0].src),),
  //       if(product!.images.length >= 2)
  //       Image(image: NetworkImage(product!.images[1].src),),
  //       if(product!.images.length >= 3)
  //       Image(image: NetworkImage(product!.images[2].src),),
  //       if(product!.images.length >= 4 )
  //         Image(image: NetworkImage(product!.images[3].src),),
  //       if(product!.images.length >= 5 )
  //         Image(image: NetworkImage(product!.images[4].src),),
  //       if(product!.images.length >= 6 )
  //         Image(image: NetworkImage(product!.images[5].src),),
  //       if(product!.images.length >= 7 )
  //         Image(image: NetworkImage(product!.images[6].src),),
  //       if(product!.images.length >= 8 )
  //         Image(image: NetworkImage(product!.images[7].src),),
  //       if(product!.images.length >= 9 )
  //         Image(image: NetworkImage(product!.images[8].src),),
  //       if(product!.images.length >= 10 )
  //         Image(image: NetworkImage(product!.images[9].src),),
  //     ],
  //     options: CarouselOptions(
  //       height: 250.0,
  //       initialPage: 0,
  //       viewportFraction: 1.0,
  //       enableInfiniteScroll: true,
  //       reverse: false,
  //       autoPlay: true,
  //       autoPlayInterval: Duration(seconds: 3),
  //       autoPlayAnimationDuration: Duration(seconds: 1),
  //       autoPlayCurve: Curves.fastOutSlowIn,
  //       scrollDirection: Axis.horizontal,
  //     ),
  //   );
  // }

  Widget carouselProductImages(context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 400.h,
      child: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            child: CarouselSlider.builder(
                itemCount: product!.images!.length,
                carouselController: carouselController,
                itemBuilder: (context, index, realIndex) =>
                    Image.network(product!.images![index].src!),
                options: CarouselOptions(
                  initialPage: 0,
                  autoPlay: false,
                  height: 400.h,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
                  reverse: false,
                  pageSnapping: true,
                  viewportFraction: 1.0,
                  pauseAutoPlayOnTouch: true,
                  enlargeCenterPage: true,
                )),
          ),
          Positioned(
            top: 150.0.h,
            child: IconButton(
              onPressed: () {
                carouselController.nextPage();
              },
              icon: Icon(Icons.arrow_back_ios),
            ),
          ),
          Positioned(
            top: 150.0.h,
            left: MediaQuery.of(context).size.width / 333,
            child: IconButton(
              onPressed: () {
                carouselController.previousPage();
              },
              icon: Icon(Icons.arrow_forward_ios),
            ),
          ),
        ],
      ),
    );
  }

  // Widget calculateDiscountPer(){
  //
  //  var discount = 100*(product!.prices.regularPrice - product!.prices.salePrice) /  product!.prices.regularPrice;
  //   return Text();
  // }
}
