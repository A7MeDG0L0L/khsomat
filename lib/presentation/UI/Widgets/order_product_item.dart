import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khsomat/Shared/constants.dart';
import 'package:khsomat/business_logic/cart_cubit/cart_cubit.dart';
import 'package:khsomat/business_logic/favorites_cubit/favorites_cubit.dart';
import 'package:khsomat/business_logic/favorites_cubit/favorites_states.dart';
import 'package:khsomat/data/models/products_model.dart';
import 'package:share/share.dart';

import '../product_details_screen.dart';

Widget showOrderItem(
    Map model,
    index,
    context,
  //Product product,
    ) {
  dynamic convertPrice(int length) {
    if (model['saleprice'].length == length) {
      String price = model['saleprice'];
      String stringPrice = price.substring(0, length - 2);
      int parsePrice = int.parse(stringPrice);
      return parsePrice;
    }
  }
//  var counter = 1;
  // var quantity= product!.quantity;
//  print(quantity);
  // print(product);
  //   String price = model['saleprice'];
  // String stringPrice =  price.substring(0,3);
  //   int parsePrice= int.parse(stringPrice);
//   var intPrice= parsePrice.toStringAsFixed(4);
// //  print(intPrice.toStringAsFixed(5));
  //print(intPrice);
  double cardWidth = MediaQuery.of(context).size.width / 1.8;
  return Dismissible(
    key: UniqueKey(),
    onDismissed: (direction) {
      CartCubit.get(context)
          .deleteItemOrderListFromDatabase(id: model['product_id']);

    },
    child: Column(
      children: [
        GestureDetector(
          onTap: () {
            //Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductDetailsScreen(product: ,),))
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => ProductDetailsScreen(product: product),
            //     ));
         //   Navigator.pushNamed(context, productDetailsScreen, arguments: product);
            //Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductDetailsScreen(product: product),));
          },
          child: Card(
            margin: EdgeInsets.all(15),
            child: Container(
              width: double.infinity,
              height: 206.h,
              child: Stack(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    textDirection: TextDirection.rtl,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// RightSide
                      Column(
                        textDirection: TextDirection.rtl,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          /// image
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 80.h,
                              width: 100.w,
                              child: CachedNetworkImage(
                                imageUrl: '${model['image']}',
                                // height: height / 1.7,
                                height: 120.h,
                                width: cardWidth / 1.4,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),

                          Container(
                            color: Colors.black12,
                            height: 11.h,
                          ),

                          /// Rating
                          // Container(
                          //   height: 40,
                          //   child: Center(
                          //     child: Text.rich(
                          //       TextSpan(children: <InlineSpan>[
                          //         WidgetSpan(
                          //           child: Icon(
                          //             Icons.star,
                          //             size: 14,
                          //             color: Colors.yellow,
                          //           ),
                          //         ),
                          //         TextSpan(text: " "),
                          //         TextSpan(text: "4.5"
                          //           // "${product.reviewCount < 0 ? "4.0" : "4.0"}",
                          //           // style: spn,
                          //         ),
                          //       ]),
                          //     ),
                          //   ),
                          // )
                          Spacer(),
                          Column(
                            children: [
                              Text('الكمية',style: TextStyle(fontSize: 16.sp),),
                              SizedBox(
                                height: 5.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      // FavoritesCubit.get(context).quantity++;
                                      // model['quantity']++;
                                      //  FavoritesCubit.get(context)
                                      //      .increaseQuantity(index);
                                      //   Quantity

                                      //quantity++;
                                      //print(product.quantity);
                                      // model['quantity'][index]++;
                                      //  FavoritesCubit.get(context).orderList['quantity'][index];
                                      CartCubit.get(context).increaseQuantity(index);
                                      // print('increase Button Pressed With index : $index');
                                      // print(FavoritesCubit.get(context).orderList);



                                      // var quantity =  product!.quantity;
                                      // quantity++;
                                      // FavoritesCubit.get(context).emit(IncreaseQuantityState());
                                    },
                                    style: ButtonStyle(),
                                    child: Text(
                                      '+',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20.sp,
                                      ),
                                    ),
                                  ),
                                  //SizedBox(width: 20,),
                                  Text(
                                    // '$counter',
                                    //'$quantity',
                                    //  '${model['quantity'][index]}',
                                    //'$quantity',
                                    // '${model['quantity']}'
                                    '${orderList[index]['quantity']}',style: TextStyle(fontSize: 16.sp),
                                    //'${model['quantity']}',
                                  ),
                                  // SizedBox(width: 10,),
                                  TextButton(
                                    onPressed: () {
                                      // if (FavoritesCubit.get(context).quantity>1){
                                      //
                                      // }
                                      // if(model['quantity'][index]>1)
                                      //   {
                                      //     model['quantity'][index]--;
                                      //   }
                                      // FavoritesCubit.get(context)
                                      // //     .decreaseQuantity();
                                      // if(quantity > 1)
                                      // {
                                      //   quantity--;
                                      // }
                                      // print(product.quantity);
                                      CartCubit.get(context).decreaseQuantity(index);
                                      //
                                      // print('Decrease Button Pressed With index : $index');
                                      // print(FavoritesCubit.get(context).orderList);

                                      // var quantity =  product.quantity;
                                      // quantity--;
                                      // FavoritesCubit.get(context).emit(DecreaseQuantityState());
                                    },
                                    child: Text(
                                      '-',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        width: 1.w,
                        color: Colors.black12,
                      ),

                      /// Center
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: ListTile(
                                title: Text(
                                  '${model['name']}',style: TextStyle(fontSize: 16.sp),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 4,
                                  // style: sProductName,
                                ),
                                // subtitle: Text(product.type ?? ""),

                                isThreeLine: false,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                // margin: const EdgeInsets.only(bottom: 1.0),
                                // height: 30,
                                width: double.infinity,
                                padding:
                                const EdgeInsets.only(left: 10, right: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10.r),
                                    bottomRight: Radius.circular(10.r),
                                  ),
                                  color: Colors.blueAccent,
                                ),
                                child: Center(
                                  child: RichText(
                                    // overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    text: TextSpan(
                                      children: [
                                       // if (model['saleprice'].length == 4)
                                          TextSpan(
                                              text:
                                              //'${intPrice}',
                                              '${model['saleprice'] * orderList[index]['quantity']}',style: TextStyle(fontSize: 17.sp)
                                              // '${convertPrice(4)! * FavoritesCubit.get(context).orderList[index]['quantity']}'
                                            //'${model['saleprice'].substring(0, 2)*FavoritesCubit.get(context).quantity}',
                                            //'$productprice',
                                            // style: sPriceSmall,
                                          ),
                                       // if (model['saleprice'].length == 5)
                                       //    TextSpan(
                                       //        text:
                                       //        //  '${intPrice}',
                                       //        '${model['saleprice'] * FavoritesCubit.get(context).orderList[index]['quantity']}'
                                       //        // '${convertPrice(5)! *FavoritesCubit.get(context).orderList[index]['quantity']}'
                                       //      //'${model['saleprice'].substring(0, 3)*FavoritesCubit.get(context).quantity}',
                                       //      //'$productprice',
                                       //      // style: sPriceSmall,
                                       //    ),
                                       //  if (model['saleprice'].length == 6)
                                       //    TextSpan(
                                       //        text:
                                       //        '${convertPrice(6)! * FavoritesCubit.get(context).orderList[index]['quantity']}'
                                       //      //  '${model['saleprice'].substring(0, 4)*FavoritesCubit.get(context).quantity}',
                                       //      //'$productprice',
                                       //      // style: sPriceSmall,
                                       //    ),
                                       //  if (model['saleprice'].length == 7)
                                       //    TextSpan(
                                       //        text:
                                       //        '${convertPrice(7)! *FavoritesCubit.get(context).orderList[index]['quantity']}'
                                       //      //'${model['saleprice'].substring(0, 5)*FavoritesCubit.get(context).quantity}',
                                       //      //'$productprice',
                                       //      // style: sPriceSmall,
                                       //    ),
                                        TextSpan(
                                          text: ' ',
                                          // style: sSymbleWhite,
                                        ),
                                        TextSpan(
                                          text: 'ج.م ',
                                           style: TextStyle(fontSize: 12.sp),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// left side
                      Container(
                        width: 1.w,
                        color: Colors.black12,
                      ),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          /// favorite button
                          Center(
                            child: Row(
                              textDirection: TextDirection.rtl,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    //TODO: Must double tap to remove item from the list to make database initialized
                                    print('Favorite Button Pressed');
                                    // await FavoritesCubit.get(context).createDatabase();
                                    //   Future.delayed(Duration(seconds: 5));
                                    // Database database = FavoritesCubit.get(context).database;
                                    // FavoritesCubit.get(context).getDataFromDatabase(database);
                                    //print(FavoritesCubit.get(context).database);
                                    CartCubit.get(context)
                                        .deleteItemOrderListFromDatabase(
                                        id: model['id']);

                                    // FavoritesCubit.get(context).deleteFromDatabase(id: model['id']);
                                    //   favList.removeFromFav(favList.favoriteList[index]);

                                    /// or
                                    // context.read(favoriteChangeNotifierProvider).removeFromFav(favList.favoriteList[index]);
                                  },
                                  ///TODO:Make it tnawar w tatfe
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child:true? Icon(Icons.favorite_border,size: 20.w,) : Icon(
                                      Icons.favorite,
                                      color: Colors.pinkAccent[400],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 1.w,
                                  color: Colors.black26,
                                ),
                              ],
                            ),
                          ),

                          ///cart button
                          // Center(
                          //   child: Row(
                          //     textDirection: TextDirection.rtl,
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       GestureDetector(
                          //         onTap: () {
                          //           // // TODO: ADD TO CART
                          //           // // CartItem cartItem = CartItem(widget.product, quantity);
                          //           //
                          //           // var add = context
                          //           //     .read(cartChangeNotifierProvider)
                          //           //     .addToCart(wooProduct: product, pQuantity: quantity);
                          //           //
                          //           // var isExist =
                          //           //     context.read(cartChangeNotifierProvider).isExist;
                          //           // if (isExist) {
                          //           //   _scaffoldKey.currentState.showSnackBar(mShowSnackBar(
                          //           //       context,
                          //           //       "المنتج موجود مسبقا هل تريد تغير الكمية",
                          //           //       "نعم"));
                          //           // } else {
                          //           //   _scaffoldKey.currentState.showSnackBar(mShowSnackBar(
                          //           //       context, "تم إضافة المنتج بنجاح", "تم"));
                          //         },
                          //         child: Padding(
                          //           padding: const EdgeInsets.all(8.0),
                          //           child: Icon(
                          //             Icons.shopping_cart,
                          //             color: Colors.black26,
                          //           ),
                          //         ),
                          //       ),
                          //       Container(
                          //         width: 1,
                          //         color: Colors.black26,
                          //       ),
                          //     ],
                          //   ),
                          // ),

                          ///share button
                          Center(
                            child: Row(
                              textDirection: TextDirection.rtl,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    print("Share Button Pressed");
                                    // await canLaunch('${model['permalink']}') ? await launch('${model['permalink']}') : throw 'Could not launch ${model['permalink']}';
                                    Share.share(
                                        ' شاهد هذا المنتج علي خصومات دوت كوم : ${model['permalink']}  ');
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.share,
                                      color: Colors.black26,size: 20.w,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 1.w,
                                  color: Colors.black26,
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
