import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:khsomat/Shared/constants.dart';
import 'package:khsomat/business_logic/favorites_cubit/favorites_cubit.dart';
import 'package:khsomat/business_logic/favorites_cubit/favorites_states.dart';
import 'package:khsomat/data/models/products_model.dart';

class FavoritesScreen extends StatelessWidget {
  FavoritesScreen({Key? key}) : super(key: key);

  //List<Product> favList = favListConst;

  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width / 1.8;
    return BlocProvider(
      create: (context) => FavoritesCubit() ,
      child: BlocConsumer<FavoritesCubit, FavoritesStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          List<Product> favList = favListConst;
          return Conditional.single(
            context: context,
            conditionBuilder: (context) => favList.isNotEmpty ,
            widgetBuilder: (context) {
              return  SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: 0.0),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {

                          // var product = favList[index];
                          //
                          // final width = MediaQuery.of(context).size.width;
                          // var productImage = '';
                          // var productprice = product.prices.regularPrice;
                          //
                          // var hasImage = product.images.length > 0;
                          // if (hasImage) {
                          //   productImage = product.images[0].src;
                          // } else {
                          //   productImage =
                          //   'https://complianz.io/wp-content/uploads/2019/03/placeholder-300x202.jpg';
                          // }
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // Navigator.of(context).push(
                                  //   MaterialPageRoute(
                                  //     builder: (_) => ProductsScreen(product: product),
                                  //   ),
                                  // );
                                },
                                child: Card(
                                  margin: EdgeInsets.all(10),
                                  child: Container(
                                    width: 150,
                                    height: 150,
                                    child: Stack(
                                      // mainAxisAlignment: MainAxisAlignment.center,
                                      // crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          textDirection: TextDirection.rtl,
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            /// RightSide
                                            Column(
                                              textDirection: TextDirection.rtl,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: [
                                                /// image
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    height: 50,
                                                    width: 80,
                                                    child: CachedNetworkImage(
                                                      imageUrl: 'assets/images/test2.jpg',
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
                                                        TextSpan(
                                                          text:"4.5"
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
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                                children: [
                                                  Expanded(
                                                    child: Directionality(
                                                      textDirection: TextDirection.rtl,
                                                      child: ListTile(
                                                        title: Text('منبة بشكل ايموجي',
                                                          // product.name,
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
                                                      padding: const EdgeInsets.only(
                                                          left: 10, right: 10),
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.only(
                                                            bottomLeft:
                                                            Radius.circular(10),
                                                            bottomRight:
                                                            Radius.circular(10)),
                                                        color: Colors.blueAccent,
                                                      ),
                                                      child: Center(
                                                        child: RichText(
                                                          // overflow: TextOverflow.ellipsis,
                                                            maxLines: 2,
                                                            text: TextSpan(children: [
                                                              TextSpan(
                                                                text: 'ر.س ',
                                                                // style: sSymbleWhite,
                                                              ),
                                                              TextSpan(
                                                                text:'380',
                                                                //'$productprice',
                                                                // style: sPriceSmall,
                                                              )
                                                            ])),
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
                                                Center(
                                                  child: Row(
                                                    textDirection: TextDirection.rtl,
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () async {
                                                          //   favList.removeFromFav(favList.favoriteList[index]);

                                                          /// or
                                                          // context.read(favoriteChangeNotifierProvider).removeFromFav(favList.favoriteList[index]);
                                                        },
                                                        child: Padding(
                                                          padding:
                                                          const EdgeInsets.all(8.0),
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
                                                Center(
                                                  child: Row(
                                                    textDirection: TextDirection.rtl,
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          // // TODO: ADD TO CART
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
                                                          padding:
                                                          const EdgeInsets.all(8.0),
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
                                                Center(
                                                  child: Row(
                                                    textDirection: TextDirection.rtl,
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () async {
                                                          print("Pressed");

                                                          // await launchShare(context, "s");
                                                        },
                                                        child: Padding(
                                                          padding:
                                                          const EdgeInsets.all(8.0),
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
                          );
                        },
                        separatorBuilder: (context, index) => Divider(
                          thickness: 20,
                        ),
                        itemCount: 20),
                  ],
                ),
              );
            },
            fallbackBuilder: (context) => Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
