import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:khsomat/business_logic/favorites_cubit/favorites_cubit.dart';
import 'package:khsomat/business_logic/favorites_cubit/favorites_states.dart';
import 'package:lottie/lottie.dart';

import 'Widgets/order_product_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoritesCubit()
        ..createDatabase()
        ..getOrderListDataFromDatabase(FavoritesCubit.get(context).database),
      child: BlocConsumer<FavoritesCubit, FavoritesStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(15),
            child: Conditional.single(
              context: context,
              conditionBuilder: (context) =>
                  FavoritesCubit.get(context).orderList.isNotEmpty,
              widgetBuilder: (context) {
                return ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) => showOrderItem(
                      FavoritesCubit.get(context).orderList[index],
                      index,
                      context),
                  separatorBuilder: (context, index) => Divider(
                    thickness: 1,
                    height: 2,
                  ),
                  itemCount: FavoritesCubit.get(context).orderList.length,
                );
              },
              fallbackBuilder: (context) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/loading/empty.json'),
                  SizedBox(
                    height: 15,
                  ),
                  Text('السلة تبدو فارغه 🙄'),
                ],
              )),
            ),
          );
        },
      ),
    );
  }
}
