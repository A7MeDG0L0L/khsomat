import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:khsomat/business_logic/favorites_cubit/favorites_cubit.dart';
import 'package:khsomat/business_logic/favorites_cubit/favorites_states.dart';
import 'package:khsomat/presentation/UI/Widgets/fav_product_item.dart';
import 'package:lottie/lottie.dart';
import 'package:sqflite/sqflite.dart';

class FavoritesScreen extends StatelessWidget {
  // Product? product;
  // FavoritesScreen({required this.product});

  //List<Product> favList = favListConst;

  @override
  Widget build(BuildContext context) {
    //List<Product>? product;
    Database database = FavoritesCubit.get(context).database;
    //double cardWidth = MediaQuery.of(context).size.width / 1.8;
    return BlocProvider(
      create: (context) => FavoritesCubit()
        ..createDatabase()
        ..getWishListDataFromDatabase(database),
      child: BlocConsumer<FavoritesCubit, FavoritesStates>(
        listener: (context, state) {
          //product = FavoritesCubit.get(context).productList;
        },
        builder: (context, state) {
          // List favList = productList;
          return Conditional.single(
            context: context,
            conditionBuilder: (context) =>
                FavoritesCubit.get(context).wishList.isNotEmpty,
            widgetBuilder: (context) {
              return Padding(
                padding: const EdgeInsets.all(15),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      ListView.separated(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return showWishItem(
                              FavoritesCubit.get(context).wishList[index],
                              index,
                              context,
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Divider(
                              thickness: 1,
                              height: 1,
                            );
                          },
                          itemCount:
                              FavoritesCubit.get(context).wishList.length),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          width: double.infinity,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () {
                              FavoritesCubit.get(context).deleteAllItemsFromWishList();
                            },
                            child: Text(
                              'حذف جميع المنتجات المفضلة',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            fallbackBuilder: (context) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/loading/heart4.json',width: 200,height: 200),
                  // Image(
                  //   image: AssetImage('assets/images/heart.png'),
                  // ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    ' قائمة المفضلة فارغة...',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
