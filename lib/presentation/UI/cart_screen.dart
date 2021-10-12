import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:khsomat/Shared/components.dart';
import 'package:khsomat/business_logic/favorites_cubit/favorites_cubit.dart';
import 'package:khsomat/business_logic/favorites_cubit/favorites_states.dart';
import 'package:khsomat/data/models/products_model.dart';
import 'package:khsomat/presentation/UI/checkout_screen.dart';
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
  var customerNoteController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var _selectedValue;

  List<DropdownMenuItem<dynamic>> cities = [
    DropdownMenuItem(
      child: Text('القاهرة'),
    ),
    DropdownMenuItem(
      child: Text('الجيزة'),
    ),
    DropdownMenuItem(
      child: Text('الاسكندرية'),
    ),
    DropdownMenuItem(
      child: Text('الفيوم'),
    ),
  ];

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
          return Scaffold(
            bottomSheet: Container(
              color: Colors.transparent,
              width: double.infinity,
              // height: 200,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('الإجمالي'),
                //  FavoritesCubit.get(context).orderList.length==0?  Text('${FavoritesCubit.get(context).orderList[0]['quantity']}'):Text('Null'),
                  Text('${FavoritesCubit.get(context).totalPrice()}'),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: CheckoutScreen()),
                            ),
                          );
                          // showBottomSheet(
                          //     context: context,
                          //     builder: (context) {
                          //       return showSheet(context);
                          //     });
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
            ),
            body: Padding(
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
                          itemCount:
                              FavoritesCubit.get(context).orderList.length,
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(15.0),
                        //   child: Container(
                        //     width: double.infinity,
                        //     height: 60,
                        //     child: ElevatedButton(
                        //       onPressed: () {
                        //         Navigator.push(
                        //           context,
                        //           MaterialPageRoute(
                        //             builder: (context) => Directionality(
                        //                 textDirection: TextDirection.rtl,
                        //                 child: CheckoutScreen()),
                        //           ),
                        //         );
                        //         // showBottomSheet(
                        //         //     context: context,
                        //         //     builder: (context) {
                        //         //       return showSheet(context);
                        //         //     });
                        //       },
                        //       child: Text(
                        //         'إنشئ الطلب',
                        //         style: TextStyle(fontSize: 20),
                        //       ),
                        //       style: ButtonStyle(),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  );
                },
                fallbackBuilder: (context) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset('assets/loading/buyBasket2.json',
                          height: 200, width: double.infinity),
                      SizedBox(
                        height: 15,
                      ),
                      Text('السلة تبدو فارغه 🙄'),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  //
  // Widget showSheet(context) {
  //   return SingleChildScrollView(
  //     scrollDirection: Axis.vertical,
  //     child: Padding(
  //       padding: const EdgeInsets.all(20.0),
  //       child: Form(
  //         key: formKey,
  //         child: Column(
  //           children: [
  //             TextFormField(
  //               controller: firstNameController,
  //               keyboardType: TextInputType.name,
  //               validator: (String? value) {
  //                 if (value!.isEmpty) {
  //                   return 'يجب إدخال الإسم الأول';
  //                 }
  //                 return null;
  //               },
  //               decoration: InputDecoration(
  //                 prefixIcon: Icon(Icons.person),
  //                 label: Text('الإسم الأول'),
  //                 border: OutlineInputBorder(
  //                   borderRadius: BorderRadius.circular(20),
  //                 ),
  //               ),
  //             ),
  //             SizedBox(
  //               height: 15,
  //             ),
  //             TextFormField(
  //               controller: lastNameController,
  //               keyboardType: TextInputType.name,
  //               validator: (String? value) {
  //                 if (value!.isEmpty) {
  //                   return 'يجب إدخال الإسم الآخير';
  //                 }
  //                 return null;
  //               },
  //               decoration: InputDecoration(
  //                 prefixIcon: Icon(Icons.person),
  //                 label: Text('الإسم الآخير'),
  //                 border: OutlineInputBorder(
  //                   borderRadius: BorderRadius.circular(20),
  //                 ),
  //               ),
  //             ),
  //             SizedBox(
  //               height: 15,
  //             ),
  //             TextFormField(
  //               controller: phoneController,
  //               keyboardType: TextInputType.phone,
  //               validator: (String? value) {
  //                 if (value!.isEmpty) {
  //                   return 'يجب إدخال رقم التليفون';
  //                 }
  //                 return null;
  //               },
  //               decoration: InputDecoration(
  //                 prefixIcon: Icon(Icons.person),
  //                 label: Text('رقم التليفون'),
  //                 border: OutlineInputBorder(
  //                   borderRadius: BorderRadius.circular(20),
  //                 ),
  //               ),
  //             ),
  //             SizedBox(
  //               height: 15,
  //             ),
  //             // DropdownButtonFormField(
  //             //   items: cities,
  //             //   value: null,
  //             //   isDense: true,
  //             // ),
  //             TextFormField(
  //               controller: cityController,
  //               keyboardType: TextInputType.text,
  //               validator: (String? value) {
  //                 if (value!.isEmpty) {
  //                   return 'يجب إدخال المدينة';
  //                 }
  //                 return null;
  //               },
  //               decoration: InputDecoration(
  //                 prefixIcon: Icon(Icons.person),
  //                 label: Text('المدينة'),
  //                 border: OutlineInputBorder(
  //                   borderRadius: BorderRadius.circular(20),
  //                 ),
  //               ),
  //             ),
  //             SizedBox(
  //               height: 15,
  //             ),
  //             TextFormField(
  //               controller: addressController,
  //               keyboardType: TextInputType.streetAddress,
  //               validator: (String? value) {
  //                 if (value!.isEmpty) {
  //                   return 'يجب إدخال العنوان';
  //                 }
  //                 return null;
  //               },
  //               decoration: InputDecoration(
  //                 prefixIcon: Icon(Icons.pin_drop_outlined),
  //                 label: Text('العنوان'),
  //                 border: OutlineInputBorder(
  //                   borderRadius: BorderRadius.circular(20),
  //                 ),
  //               ),
  //             ),
  //             SizedBox(
  //               height: 15,
  //             ),
  //             TextFormField(
  //               controller: emailController,
  //               keyboardType: TextInputType.emailAddress,
  //               validator: (String? value) {
  //                 if (value!.isEmpty) {
  //                   return 'يجب إدخال البريد الإلكتروني';
  //                 }
  //                 return null;
  //               },
  //               decoration: InputDecoration(
  //                 prefixIcon: Icon(Icons.email_outlined),
  //                 label: Text('البريد الإلكتروني'),
  //                 border: OutlineInputBorder(
  //                   borderRadius: BorderRadius.circular(20),
  //                 ),
  //               ),
  //             ),
  //             SizedBox(
  //               height: 15,
  //             ),
  //             TextFormField(
  //               style: TextStyle(height: 5),
  //               controller: customerNoteController,
  //               keyboardType: TextInputType.multiline,
  //               // validator: (String? value) {
  //               //   if (value!.isEmpty) {
  //               //     return 'يجب إدخال الإسم الآخير';
  //               //   }
  //               //   return null;
  //               // },
  //               decoration: InputDecoration(
  //                 prefixIcon: Icon(Icons.sticky_note_2_rounded),
  //                 label: Text('ملاحظات'),
  //                 border: OutlineInputBorder(
  //                   borderRadius: BorderRadius.circular(20),
  //                 ),
  //               ),
  //             ),
  //             ElevatedButton(
  //               onPressed: () {
  //                 if (formKey.currentState!.validate()) {
  //                   print(firstNameController.text);
  //                   FavoritesCubit.get(context).createOrder(
  //                     firstname: firstNameController.text,
  //                     lastname: lastNameController.text,
  //                     address: addressController.text,
  //                     city: cityController.text,
  //                     email: emailController.text,
  //                     phone: phoneController.text,
  //                     customerNote: customerNoteController.text,
  //                     itemsList: FavoritesCubit.get(context).orderList,
  //                   );
  //                   showToast(
  //                       text: 'تم ارسال الاوردر بأنتظار التأكيد',
  //                       state: ToastStates.SUCCESS);
  //                   Navigator.pop(context);
  //                 }
  //               },
  //               child: Text('إدفع'),
  //             ),
  //             ElevatedButton(
  //               onPressed: () {
  //                 Navigator.pop(context);
  //               },
  //               child: Text('اخلع'),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
