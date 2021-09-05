import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:khsomat/Shared/constants.dart';
import 'package:khsomat/Shared/my_colors.dart';
import 'package:khsomat/data/cache_helper/cache_helper.dart';
import 'package:khsomat/data/models/products_model.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, productDetailsScreen, arguments: product);
      },
      child: Hero(
        tag: product.id,
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Container(
                    child: product.images.isNotEmpty
                        ? FadeInImage.assetNetwork(
                            fit: BoxFit.cover,
                            image: product.images[0].src,
                            width: double.infinity,
                            height: 200.0,
                            placeholder: 'assets/loading/loading.gif',
                          )
                        : Image.asset('assets/images/placeholder.jpg'),
                  ),
                  if (product.onSale == true &&
                      product.prices.regularPrice != product.prices.salePrice)
                    Container(
                      color: Colors.red,
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.0,
                      ),
                      child: Text(
                        'DISCOUNT',
                        style: TextStyle(
                          fontSize: 8.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'Almarai',
                          fontSize: 14.0,
                          height: 1.2,
                        ),
                      ),
                      Spacer(),
                      Row(
                        children: [
                          if (product.prices.salePrice.length == 4)
                            Text(
                              product.prices.salePrice.substring(0, 2)
                              /*'${product.price.round()}'*/,
                              style: TextStyle(
                                fontFamily: 'Almarai',
                                fontSize: 20.0,
                                color: defColor,
                              ),
                            ),
                          if (product.prices.salePrice.length == 5)
                            Text(
                              product.prices.salePrice.substring(0, 3)
                              /*'${product.price.round()}'*/,
                              style: TextStyle(
                                fontFamily: 'Almarai',
                                fontSize: 20.0,
                                color: defColor,
                              ),
                            ),
                          if (product.prices.salePrice.length == 6)
                            Text(
                              product.prices.salePrice.substring(0, 4)
                              /*'${product.price.round()}'*/,
                              style: TextStyle(
                                fontFamily: 'Almarai',
                                fontSize: 20.0,
                                color: defColor,
                              ),
                            ),
                          if (product.prices.salePrice.length == 7)
                            Text(
                              product.prices.salePrice.substring(0, 5)
                              /*'${product.price.round()}'*/,
                              style: TextStyle(
                                fontFamily: 'Almarai',
                                fontSize: 20.0,
                                color: defColor,
                              ),
                            ),
                          Text(
                            'ج',
                            style: TextStyle(
                              fontFamily: 'Almarai',
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          if (product.onSale == true &&
                              product.prices.regularPrice !=
                                  product.prices.salePrice &&
                              product.prices.regularPrice.length == 4)
                            Text(
                              product.prices.regularPrice.substring(0, 2)
                              /* '${product.oldPrice.round()}'*/,
                              style: TextStyle(
                                fontFamily: 'Almarai',
                                fontSize: 18.0,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          if (product.onSale == true &&
                              product.prices.regularPrice !=
                                  product.prices.salePrice &&
                              product.prices.regularPrice.length == 5)
                            Text(
                              product.prices.regularPrice.substring(0, 3)
                              /* '${product.oldPrice.round()}'*/,
                              style: TextStyle(
                                fontFamily: 'Almarai',
                                fontSize: 18.0,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          if (product.onSale == true &&
                              product.prices.regularPrice !=
                                  product.prices.salePrice &&
                              product.prices.regularPrice.length == 6)
                            Text(
                              product.prices.regularPrice.substring(0, 4)
                              /* '${product.oldPrice.round()}'*/,
                              style: TextStyle(
                                fontFamily: 'Almarai',
                                fontSize: 18.0,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          if (product.onSale == true &&
                              product.prices.regularPrice !=
                                  product.prices.salePrice &&
                              product.prices.regularPrice.length == 7)
                            Text(
                              product.prices.regularPrice.substring(0, 5)
                              /* '${product.oldPrice.round()}'*/,
                              style: TextStyle(
                                fontFamily: 'Almarai',
                                fontSize: 18.0,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          Spacer(),
                          IconButton(
                            onPressed: () {
                              /*  ShopCubit.get(context).changeFavorites(product.id);
                                print(product.id);*/
                             favListConst.add(product);
                              CacheHelper.sharedPreferences.setString(
                                  'favList', jsonEncode(favListConst));
                              print(
                                  'Added This Item to List : ${product.name}');
                              print(favListConst);




                            },
                            icon: CircleAvatar(
                              radius: 15.0,
                              backgroundColor:
                                  /*ShopCubit
                                    .get(context)
                                    .favorites[product.id]
                                    ? defaultColor
                                    :*/
                                  Colors.grey,
                              child: Icon(
                                Icons.favorite_border,
                                size: 14.0,
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
  }
}
