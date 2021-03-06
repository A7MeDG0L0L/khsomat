import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khsomat/data/models/category_model.dart';
import 'package:khsomat/presentation/UI/products_category_screen.dart';

Widget buildDrawerItem(Category model, context) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductsForCategoryScreen(id: model.id, name: model.name),
            ));
      },
      child: Container(
       // decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              Text(
                '${model.name}',
                style: TextStyle(color: Colors.black,fontSize: 15.sp,overflow: TextOverflow.ellipsis),
                overflow: TextOverflow.ellipsis,
                textScaleFactor: 1.w,
                maxLines: 1,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  '(${model.count})',
                  style: TextStyle(color: Colors.grey,fontSize: 12.sp,overflow: TextOverflow.ellipsis),
                  overflow: TextOverflow.ellipsis,
                  textScaleFactor: 1.w,
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
