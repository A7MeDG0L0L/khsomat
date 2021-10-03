import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khsomat/business_logic/favorites_cubit/favorites_cubit.dart';
import 'package:khsomat/business_logic/favorites_cubit/favorites_states.dart';
import 'package:khsomat/presentation/UI/Widgets/bottomSheetWidget.dart';
import 'package:khsomat/presentation/UI/Widgets/checkout_item.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoritesCubit(),
      child: BlocConsumer<FavoritesCubit, FavoritesStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('checkout'),
            ),
            body: SingleChildScrollView(
              child: Column(
                // mainAxisSize: MainAxisSize.max,
                children: [
                  ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return showCheckoutItem(
                          FavoritesCubit.get(context).orderList[index],
                          index,
                          context);
                    },
                    separatorBuilder: (context, index) => Divider(
                      thickness: 1,
                    ),
                    itemCount: FavoritesCubit.get(context).orderList.length,
                  ),
                  showSheet(context),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
