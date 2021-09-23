import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:khsomat/Shared/components.dart';
import 'package:khsomat/business_logic/favorites_cubit/favorites_cubit.dart';
import 'package:khsomat/business_logic/favorites_cubit/favorites_states.dart';
import 'package:khsomat/data/models/products_model.dart';
import 'package:lottie/lottie.dart';

import 'Widgets/order_product_item.dart';

class CartScreen extends StatelessWidget {
  CartScreen({Key? key}) : super(key: key);

  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final Product product;
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
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) => showOrderItem(
                            FavoritesCubit.get(context).orderList[index],
                            index,
                            context),
                        separatorBuilder: (context, index) => Divider(
                          thickness: 1,
                          height: 2,
                        ),
                        itemCount: FavoritesCubit.get(context).orderList.length,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          width: double.infinity,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () {
                              showBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return showSheet();
                                  });
                            },
                            child: Text(
                              'إنشئ الطلب',
                              style: TextStyle(fontSize: 20),
                            ),
                            style: ButtonStyle(),
                          ),
                        ),
                      ),
                    ],
                  ),
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
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget showSheet() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            children: [
              defaultFormField(
                  controller: firstNameController,
                  type: TextInputType.text,
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'يجب إدخال الإسم الأول';
                    }
                  },
                  label: 'الإسم الأول',
                  prefix: Icons.person),
              defaultFormField(
                  controller: lastNameController,
                  type: TextInputType.text,
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'يجب إدخال الإسم الأول';
                    }
                  },
                  label: 'الإسم الأخير',
                  prefix: Icons.person),
            ],
          ),
          ElevatedButton(onPressed: (){

          }, child: Text('إدفع'),),
        ],
      ),
    );
  }
}
