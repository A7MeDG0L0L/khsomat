import 'package:flutter/material.dart';
import 'package:khsomat/data/models/category_model.dart';

Widget buildDrawerItem(Category model, context) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      child: Row(
        children: [
          Text(
            model.name,
          ),
          SizedBox(width: 20,),
          ///TODO: Remove model.id before end
          Text(
            '${model.id}',
          ),
        ],
      ),
    ),
  );
}
