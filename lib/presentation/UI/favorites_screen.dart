import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:khsomat/Shared/constants.dart';
import 'package:khsomat/business_logic/favorites_cubit/favorites_cubit.dart';
import 'package:khsomat/business_logic/favorites_cubit/favorites_states.dart';
import 'package:khsomat/data/models/products_model.dart';
import 'package:khsomat/presentation/UI/Widgets/fav_product_item.dart';

class FavoritesScreen extends StatelessWidget {
  FavoritesScreen({Key? key}) : super(key: key);

  //List<Product> favList = favListConst;

  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width / 1.8;
    return BlocProvider(
      create: (context) => FavoritesCubit()..createDatabase(),
      child: BlocConsumer<FavoritesCubit, FavoritesStates>(
        listener: (context, state) {},
        builder: (context, state) {
          // List favList = productList;
          return Conditional.single(
            context: context,
            conditionBuilder: (context) =>
                FavoritesCubit.get(context).productList.isNotEmpty,
            widgetBuilder: (context) {
              return Padding(
                padding: const EdgeInsets.all(15),
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return showFav(FavoritesCubit.get(context).productList[index], index, context);
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        thickness: 4,
                      );
                    },
                    itemCount: FavoritesCubit.get(context).productList.length),
              );
            },
            fallbackBuilder: (context) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('assets/images/heart.png'),
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
