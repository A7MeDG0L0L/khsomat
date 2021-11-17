import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khsomat/Shared/components.dart';
import 'package:khsomat/Shared/constants.dart';
import 'package:khsomat/Shared/my_colors.dart';
import 'package:khsomat/business_logic/favorites_cubit/favorites_cubit.dart';
import 'package:khsomat/business_logic/favorites_cubit/favorites_states.dart';
import 'package:khsomat/business_logic/home_cubit/home_cubit.dart';
import 'package:khsomat/data/models/products_model.dart';
import 'package:khsomat/translations/locale_keys.g.dart';
import 'package:translator/translator.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({Key? key, required this.product}) : super(key: key);
  // final translator = GoogleTranslator();
  // late String productName;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoritesCubit, FavoritesStates>(
      listener: (context, state) {},
      builder: (context, state) {
        // translator.translate( product.name!,to: 'en').then((value) => printWrapped(value.text));
        dynamic discountedPrice() {
          dynamic discountedPrice;
          if (product.prices!.salePrice == 0 ||
              product.prices!.regularPrice == 0) {
            product.prices!.salePrice = 1;
            product.prices!.regularPrice = 1;
            discountedPrice = 100 *
                (product.prices!.regularPrice - product.prices!.salePrice) ~/
                product.prices!.regularPrice;
            return discountedPrice;
          } else
            return discountedPrice = 100 *
                (product.prices!.regularPrice - product.prices!.salePrice) ~/
                product.prices!.regularPrice;
        }

        return InkWell(
          onTap: () async {
            Navigator.pushNamed(context, productDetailsScreen,
                arguments: product);
            await HomeCubit.get(context).getRelatedProductsID(product.id!);
            // Future.delayed(Duration(seconds: 8));
            //  HomeCubit.get(context).getRelatedProducts();
          },
          child: Hero(
            tag: product.id!,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.r),
                            topRight: Radius.circular(15.r),
                          ),
                          child: product.images!.isNotEmpty
                              ? CachedNetworkImage(
                                  imageUrl: product.images![0].src!,
                                  placeholder: (context, url) => Image.asset(
                                      'assets/loading/loading2.gif'),
                                )
                              : Image.asset(
                                  'assets/images/Newplaceholder2.png',
                                  height: 200.h,
                                  fit: BoxFit.cover,
                                ),

                        // child:  product.images!.isNotEmpty
                        //       ? FadeInImage.assetNetwork(
                        //     fit: BoxFit.cover,
                        //     image: product.images![0].src!,
                        //     width: double.infinity,
                        //     height: 200.0.h,
                        //     placeholder: 'assets/loading/loading2.gif',
                        //   )
                        //       : Image.asset('assets/images/Newplaceholder2.png',height: 200.h,fit: BoxFit.cover,),
                        ),
                      ),
                      if (product.onSale == true &&
                          product.prices!.regularPrice! !=
                              product.prices!.salePrice!)
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            height: 25.h,
                            width: 40.w,
                            decoration:BoxDecoration(
                              borderRadius: BorderRadius.horizontal(right: Radius.circular(15),left: Radius.circular(15)),
                              color: Colors.orange,
                            ),
                            child: Center(
                              child: Text(
                                '${discountedPrice()}%',
                                style: TextStyle(
                                  fontSize: 12.0.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      height: 100.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: 'Almarai',
                              fontSize: 14.0.sp,
                              height: 1.2.h,
                            ),
                          ),
                          Spacer(),
                          Row(
                            children: [
                              if (product.prices!.salePrice.toString().length <
                                  4)
                                Text(
                                  '${product.prices!.salePrice}',
                                  style: TextStyle(
                                    fontFamily: 'Almarai',
                                    fontSize: 21.sp,
                                    color: defColor,
                                  ),
                                ),
                              if (product.prices!.salePrice.toString().length >=
                                  4)
                                Text(
                                  '${product.prices!.salePrice}',
                                  style: TextStyle(
                                    fontFamily: 'Almarai',
                                    fontSize: 16.sp,
                                    color: defColor,
                                  ),
                                ),
                              // if (product.prices!.salePrice!.length == 4)
                              //   Text(
                              //     product.prices!.salePrice!.substring(
                              //         0, 2) /*'${product.price.round()}'*/,
                              //     style: TextStyle(
                              //       fontFamily: 'Almarai',
                              //       fontSize: 21.0,
                              //       color: defColor,
                              //     ),
                              //   ),
                              // if (product.prices!.salePrice!.length == 5)
                              //   Container(
                              //     // color: Colors.blue,
                              //     child: Text(
                              //       product.prices!.salePrice!.substring(
                              //           0, 3) /*'${product.price.round()}'*/,
                              //       style: TextStyle(
                              //         fontFamily: 'Almarai',
                              //         fontSize: 20.0,
                              //         color: Colors.blue,
                              //       ),
                              //     ),
                              //   ),
                              // if (product.prices!.salePrice!.length == 6)
                              //   Text(
                              //     product.prices!.salePrice!.substring(
                              //         0, 4) /*'${product.price.round()}'*/,
                              //     style: TextStyle(
                              //       fontFamily: 'Almarai',
                              //       fontSize: 19.0,
                              //       color: defColor,
                              //     ),
                              //   ),
                              // if (product.prices!.salePrice!.length == 7)
                              //   Text(
                              //     product.prices!.salePrice!.substring(
                              //         0, 5) /*'${product.price.round()}'*/,
                              //     style: TextStyle(
                              //       fontFamily: 'Almarai',
                              //       fontSize: 18.0,
                              //       color: defColor,
                              //     ),
                              //   ),
                              Text(
                                LocaleKeys.egp.tr(),
                                style: TextStyle(
                                  fontFamily: 'Almarai',
                                  fontSize: 12.sp,
                                ),
                              ),
                              SizedBox(
                                width: 8.0.w,
                              ),
                              if (product.prices!.regularPrice
                                      .toString()
                                      .length <
                                  4)
                                Text(
                                  '${product.prices!.regularPrice}',
                                  style: TextStyle(
                                    fontFamily: 'Almarai',
                                    fontSize: 18.sp,
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              if (product.prices!.regularPrice
                                      .toString()
                                      .length >=
                                  4)
                                Text(
                                  '${product.prices!.regularPrice}',
                                  style: TextStyle(
                                    fontFamily: 'Almarai',
                                    fontSize: 14.sp,
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              // if (product.onSale == true &&
                              //     product.prices!.regularPrice! !=
                              //         product.prices!.salePrice! &&
                              //     product.prices!.regularPrice!.length == 4)
                              //   Text(
                              //     product.prices!.regularPrice!.substring(
                              //         0, 2) /* '${product.oldPrice.round()}'*/,
                              //     style: TextStyle(
                              //       fontFamily: 'Almarai',
                              //       fontSize: 18.0,
                              //       color: Colors.grey,
                              //       decoration: TextDecoration.lineThrough,
                              //     ),
                              //   ),
                              // if (product.onSale == true &&
                              //     product.prices!.regularPrice! !=
                              //         product.prices!.salePrice! &&
                              //     product.prices!.regularPrice!.length == 5)
                              //   Text(
                              //     product.prices!.regularPrice!.substring(
                              //         0, 3) /* '${product.oldPrice.round()}'*/,
                              //     style: TextStyle(
                              //       fontFamily: 'Almarai',
                              //       fontSize: 17.0,
                              //       color: Colors.grey,
                              //       decoration: TextDecoration.lineThrough,
                              //     ),
                              //   ),
                              // if (product.onSale == true &&
                              //     product.prices!.regularPrice! !=
                              //         product.prices!.salePrice! &&
                              //     product.prices!.regularPrice!.length == 6)
                              //   Text(
                              //     product.prices!.regularPrice!.substring(
                              //         0, 4) /* '${product.oldPrice.round()}'*/,
                              //     style: TextStyle(
                              //       fontFamily: 'Almarai',
                              //       fontSize: 16.0,
                              //       color: Colors.grey,
                              //       decoration: TextDecoration.lineThrough,
                              //     ),
                              //   ),
                              // if (product.onSale == true &&
                              //     product.prices!.regularPrice! !=
                              //         product.prices!.salePrice! &&
                              //     product.prices!.regularPrice!.length == 7)
                              //   Text(
                              //     product.prices!.regularPrice!.substring(
                              //         0, 5) /* '${product.oldPrice.round()}'*/,
                              //     style: TextStyle(
                              //       fontFamily: 'Almarai',
                              //       fontSize: 15.0,
                              //       color: Colors.grey,
                              //       decoration: TextDecoration.lineThrough,
                              //     ),
                              //   ),
                              Spacer(),
                              IconButton(
                                onPressed: () {
                                  FavoritesCubit.get(context)
                                      .insertToDatabase(
                                        // id: product.id!,
                                        productId: product.id!,
                                        text: product.name!,
                                        image: product.images![0].src!,
                                        regularprice:
                                            product.prices!.regularPrice!,
                                        saleprice: product.prices!.salePrice!,
                                        permalink: product.permalink!,
                                      )
                                      .then(
                                        (value) => showToast(
                                            text:
                                                'تم إضافة المنتج إلي قائمة المفضلة',
                                            state: ToastStates.SUCCESS),
                                      );
                                  // FavoritesCubit.get(context).checkItems();

                                  // productList.forEach((e) {
                                  //   convertedList.add(e.toJson());
                                  //   CacheHelper.sharedPreferences.setString(
                                  //       'favList', jsonEncode(convertedList));
                                  //   print(
                                  //       'Added This Item to List : ${product.name}');
                                  // });
                                  //   productList.add(product);
                                  //   CacheHelper.sharedPreferences.setString(
                                  //            'favList', jsonEncode(productList));
                                  //        print(
                                  //            'Added This Item to List : ${product.name}');

                                  //  convertedList.add(product.toJson());
                                  // // print(productList);
                                  //  print(product);
                                  // // print(jsonEncode(productList));
                                  //  CacheHelper.sharedPreferences.setString(
                                  //      'favList', jsonEncode(convertedList));
                                  //  print(
                                  //      'Added This Item to List : ${product.name}');
                                },
                                icon: CircleAvatar(
                                  radius: 14.r,
                                  backgroundColor: FavoritesCubit.get(context)
                                          .checkItemWishList(product.id)
                                      ? defColor
                                      : Colors.grey,
                                  child: Icon(
                                    Icons.favorite_border,
                                    size: 12.r,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
