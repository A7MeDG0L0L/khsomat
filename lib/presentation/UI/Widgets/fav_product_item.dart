import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khsomat/Shared/constants.dart';
import 'package:khsomat/business_logic/favorites_cubit/favorites_cubit.dart';
import 'package:khsomat/data/models/products_model.dart';
import 'package:khsomat/presentation/UI/product_details_screen.dart';
import 'package:share/share.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';

// class FavoritesItem extends StatelessWidget {
//   const FavoritesItem({Key? key,required this.product}) : super(key: key);
//
// final Product product;
//
//   get model => null;
//   @override
//   Widget build(BuildContext context) {
//     double cardWidth = MediaQuery.of(context).size.width / 1.8;
//     return Column(
//       children: [
//         GestureDetector(
//           onTap: () {
//             Navigator.pushNamed(context, productDetailsScreen, arguments: product);
//             //Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductDetailsScreen(product: product),));
//             // Navigator.of(context).push(
//             //   MaterialPageRoute(
//             //     builder: (_) => ProductsScreen(product: product),
//             //   ),
//             // );
//           },
//           child: Card(
//             margin: EdgeInsets.all(15),
//             child: Container(
//               width: double.infinity,
//               height: 150,
//               child: Stack(
//                 // mainAxisAlignment: MainAxisAlignment.center,
//                 // crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Row(
//                     textDirection: TextDirection.rtl,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       /// RightSide
//                       Column(
//                         textDirection: TextDirection.rtl,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           /// image
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Container(
//                               height: 50,
//                               width: 80,
//                               child: CachedNetworkImage(
//                                 imageUrl: '${model['image']}',
//                                 // height: height / 1.7,
//                                 height: 120,
//                                 width: cardWidth / 1.4,
//                                 fit: BoxFit.contain,
//                               ),
//                             ),
//                           ),
//
//                           Container(
//                             color: Colors.black12,
//                             height: 11,
//                           ),
//
//                           /// Rating
//                           Container(
//                             height: 40,
//                             child: Center(
//                               child: Text.rich(
//                                 TextSpan(children: <InlineSpan>[
//                                   WidgetSpan(
//                                     child: Icon(
//                                       Icons.star,
//                                       size: 14,
//                                       color: Colors.yellow,
//                                     ),
//                                   ),
//                                   TextSpan(text: " "),
//                                   TextSpan(text: "4.5"
//                                     // "${product.reviewCount < 0 ? "4.0" : "4.0"}",
//                                     // style: spn,
//                                   ),
//                                 ]),
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                       Container(
//                         width: 1,
//                         color: Colors.black12,
//                       ),
//
//                       /// Center
//                       Expanded(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             Expanded(
//                               child: Directionality(
//                                 textDirection: TextDirection.rtl,
//                                 child: ListTile(
//                                   title: Text(
//                                     '${model['title']}',
//                                     overflow: TextOverflow.ellipsis,
//                                     maxLines: 4,
//                                     // style: sProductName,
//                                   ),
//                                   // subtitle: Text(product.type ?? ""),
//
//                                   isThreeLine: false,
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Container(
//                                 // margin: const EdgeInsets.only(bottom: 1.0),
//                                 // height: 30,
//                                 width: double.infinity,
//                                 padding:
//                                 const EdgeInsets.only(left: 10, right: 10),
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.only(
//                                       bottomLeft: Radius.circular(10),
//                                       bottomRight: Radius.circular(10)),
//                                   color: Colors.blueAccent,
//                                 ),
//                                 child: Center(
//                                   child: RichText(
//                                     // overflow: TextOverflow.ellipsis,
//                                       maxLines: 2,
//                                       text: TextSpan(children: [
//                                         TextSpan(
//                                           text: 'ج.م ',
//                                           // style: sSymbleWhite,
//                                         ),
//                                         TextSpan(
//                                           text: '${model['saleprice']}',
//                                           //'$productprice',
//                                           // style: sPriceSmall,
//                                         )
//                                       ])),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//
//                       /// left side
//                       Container(
//                         width: 1,
//                         color: Colors.black12,
//                       ),
//
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Center(
//                             child: Row(
//                               textDirection: TextDirection.rtl,
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 GestureDetector(
//                                   onTap: () async {
//                                     //   favList.removeFromFav(favList.favoriteList[index]);
//
//                                     /// or
//                                     // context.read(favoriteChangeNotifierProvider).removeFromFav(favList.favoriteList[index]);
//                                   },
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Icon(
//                                       Icons.favorite,
//                                       color: Colors.pinkAccent[400],
//                                     ),
//                                   ),
//                                 ),
//                                 Container(
//                                   width: 1,
//                                   color: Colors.black26,
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Center(
//                             child: Row(
//                               textDirection: TextDirection.rtl,
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 GestureDetector(
//                                   onTap: () {
//                                     // // TODO: ADD TO CART
//                                     // // CartItem cartItem = CartItem(widget.product, quantity);
//                                     //
//                                     // var add = context
//                                     //     .read(cartChangeNotifierProvider)
//                                     //     .addToCart(wooProduct: product, pQuantity: quantity);
//                                     //
//                                     // var isExist =
//                                     //     context.read(cartChangeNotifierProvider).isExist;
//                                     // if (isExist) {
//                                     //   _scaffoldKey.currentState.showSnackBar(mShowSnackBar(
//                                     //       context,
//                                     //       "المنتج موجود مسبقا هل تريد تغير الكمية",
//                                     //       "نعم"));
//                                     // } else {
//                                     //   _scaffoldKey.currentState.showSnackBar(mShowSnackBar(
//                                     //       context, "تم إضافة المنتج بنجاح", "تم"));
//                                   },
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Icon(
//                                       Icons.shopping_cart,
//                                       color: Colors.black26,
//                                     ),
//                                   ),
//                                 ),
//                                 Container(
//                                   width: 1,
//                                   color: Colors.black26,
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Center(
//                             child: Row(
//                               textDirection: TextDirection.rtl,
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 GestureDetector(
//                                   onTap: () async {
//                                     print("Pressed");
//
//                                     // await launchShare(context, "s");
//                                   },
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Icon(
//                                       Icons.share,
//                                       color: Colors.black26,
//                                     ),
//                                   ),
//                                 ),
//                                 Container(
//                                   width: 1,
//                                   color: Colors.black26,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

Widget showWishItem(
  Map model,
  index,
  context,
  // Product? product,
) {
  double cardWidth = MediaQuery.of(context).size.width / 1.8;

  return Dismissible(
    key: UniqueKey(),
    onDismissed: (direction) {
      FavoritesCubit.get(context)
          .deleteItemWishListFromDatabase(id: model['product_id']);
    },
    child: Column(
      children: [
        GestureDetector(
          onTap: () {
            /*Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsScreen(product: product!),
                ));*/
            //Navigator.pushNamed(context, productDetailsScreen, arguments: product);
            //Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductDetailsScreen(product: product),));
          },
          child: Card(
            margin: EdgeInsets.all(15),
            child: Container(
              width: double.infinity,
              height: 150,
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
                              height: 80,
                              width: 100,
                              child: CachedNetworkImage(
                                imageUrl: '${model['image']}',
                                // height: height / 1.7,
                                height: 120,
                                width: cardWidth / 1.4,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),

                          Container(
                            color: Colors.black12,
                            height: 11,
                          ),

                          /// Rating
                          Container(
                            height: 40,
                            child: Center(
                              child: Text.rich(
                                TextSpan(children: <InlineSpan>[
                                  WidgetSpan(
                                    child: Icon(
                                      Icons.star,
                                      size: 14,
                                      color: Colors.yellow,
                                    ),
                                  ),
                                  TextSpan(text: " "),
                                  TextSpan(text: "4.5"
                                      // "${product.reviewCount < 0 ? "4.0" : "4.0"}",
                                      // style: spn,
                                      ),
                                ]),
                              ),
                            ),
                          )
                        ],
                      ),
                      Container(
                        width: 1,
                        color: Colors.black12,
                      ),

                      /// Center
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: ListTile(
                                  title: Text(
                                    '${model['name']}',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 4,
                                    // style: sProductName,
                                  ),
                                  // subtitle: Text(product.type ?? ""),

                                  isThreeLine: false,
                                ),
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
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                  color: Colors.blueAccent,
                                ),
                                child: Center(
                                  child: RichText(
                                    // overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    text: TextSpan(
                                      children: [
                                        if (model['saleprice'].length == 4)
                                          TextSpan(
                                            text:
                                                '${model['saleprice'].substring(0, 2)}',
                                            //'$productprice',
                                            // style: sPriceSmall,
                                          ),
                                        if (model['saleprice'].length == 5)
                                          TextSpan(
                                            text:
                                                '${model['saleprice'].substring(0, 3)}',
                                            //'$productprice',
                                            // style: sPriceSmall,
                                          ),
                                        if (model['saleprice'].length == 6)
                                          TextSpan(
                                            text:
                                                '${model['saleprice'].substring(0, 4)}',
                                            //'$productprice',
                                            // style: sPriceSmall,
                                          ),
                                        if (model['saleprice'].length == 7)
                                          TextSpan(
                                            text:
                                                '${model['saleprice'].substring(0, 5)}',
                                            //'$productprice',
                                            // style: sPriceSmall,
                                          ),
                                        TextSpan(
                                          text: ' ',
                                          // style: sSymbleWhite,
                                        ),
                                        TextSpan(
                                          text: 'ج.م ',
                                          // style: sSymbleWhite,
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
                        width: 1,
                        color: Colors.black12,
                      ),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                                    print(FavoritesCubit.get(context).database);
                                    FavoritesCubit.get(context)
                                        .deleteItemWishListFromDatabase(
                                            id: model['product_id']);

                                    // FavoritesCubit.get(context).deleteFromDatabase(id: model['id']);
                                    //   favList.removeFromFav(favList.favoriteList[index]);

                                    /// or
                                    // context.read(favoriteChangeNotifierProvider).removeFromFav(favList.favoriteList[index]);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.favorite,
                                      color: Colors.pinkAccent[400],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 1,
                                  color: Colors.black26,
                                ),
                              ],
                            ),
                          ),

                          ///cart button
                          Center(
                            child: Row(
                              textDirection: TextDirection.rtl,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    // // TODO: ADD TO CART
                                    FavoritesCubit.get(context)
                                        .insertToOrderListDatabase(
                                      // id: model['id'],
                                      productId: model['product_id'],
                                      productName: model['name'],
                                      image: model['image'],
                                      regularprice: model['regularprice'],
                                      saleprice: model['saleprice'],
                                      permalink: model['permalink'],
                                      quantity: 1,
                                    );
                                    // // CartItem cartItem = CartItem(widget.product, quantity);
                                    //
                                    // var add = context
                                    //     .read(cartChangeNotifierProvider)
                                    //     .addToCart(wooProduct: product, pQuantity: quantity);
                                    //
                                    // var isExist =
                                    //     context.read(cartChangeNotifierProvider).isExist;
                                    // if (isExist) {
                                    //   _scaffoldKey.currentState.showSnackBar(mShowSnackBar(
                                    //       context,
                                    //       "المنتج موجود مسبقا هل تريد تغير الكمية",
                                    //       "نعم"));
                                    // } else {
                                    //   _scaffoldKey.currentState.showSnackBar(mShowSnackBar(
                                    //       context, "تم إضافة المنتج بنجاح", "تم"));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.shopping_cart,
                                      color: Colors.black26,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 1,
                                  color: Colors.black26,
                                ),
                              ],
                            ),
                          ),

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
                                      color: Colors.black26,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 1,
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
