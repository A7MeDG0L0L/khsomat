import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:khsomat/business_logic/favorites_cubit/favorites_cubit.dart';
import 'package:khsomat/business_logic/favorites_cubit/favorites_states.dart';
import 'package:khsomat/data/models/products_model.dart';
import 'package:share/share.dart';

Widget showCheckoutItem(
    Map model,
   // index,
    context,
    { Product? product}
    ) {
  dynamic convertPrice(int length) {
    if (model['saleprice'].length == length) {
      String price = model['saleprice'];
      String stringPrice = price.substring(0, length - 2);
      int parsePrice = int.parse(stringPrice);
      return parsePrice;
    }
  }

  double cardWidth = MediaQuery.of(context).size.width / 1.8;
  ///TODO: Enhance This Widget
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: Row(
      children: [
        Text(model['name']),
        SizedBox(width: 10,),
        Text("${model['saleprice'].toString().substring(0,4)}"),
        SizedBox(width: 5,),
        Text('x'),
        SizedBox(width: 5,),
        Text("${model['quantity']}"),
        SizedBox(width: 10,),
        Text('${model['saleprice']*model['quantity']}'),
      ],
    ),
  );
}