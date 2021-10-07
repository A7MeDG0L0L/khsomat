import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khsomat/business_logic/home_cubit/home_cubit.dart';
import 'package:khsomat/business_logic/home_cubit/home_state.dart';
import 'package:khsomat/data/models/category_model.dart';
import 'package:khsomat/data/models/products_model.dart';
import 'package:khsomat/data/repository/products_repository.dart';
import 'package:khsomat/data/web_services/web_services.dart';
import 'package:khsomat/presentation/UI/app_layout.dart';

class DrawerHomeScreen extends StatelessWidget {
   DrawerHomeScreen({Key? key, this.drawerController}) : super(key: key);
final drawerController ;

  late List<Product> allProducts;
  late List<Category> allCategories;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(listener: (context, state) {

    },
    builder: (context, state) {
      return Scaffold(
        appBar: AppBar(leading: Directionality(
          textDirection: TextDirection.rtl,
          child: IconButton(onPressed: (){
            drawerController.toggle();
          }, icon: Icon(Icons.menu)),
        ),),
        body:Column(children: [
          Container(
          color: Colors.red,
          height: 200,
        )],),
      );
    },);
  }
}
