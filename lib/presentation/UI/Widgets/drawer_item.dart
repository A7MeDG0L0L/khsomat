import 'package:flutter/material.dart';
import 'package:khsomat/data/models/category_model.dart';

Widget buildDrawerItem(Category model, context) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      child: Text(
        model.name,
      ),
    ),
  );
}
