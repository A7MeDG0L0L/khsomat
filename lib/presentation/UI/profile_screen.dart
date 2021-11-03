import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khsomat/Shared/components.dart';
import 'package:khsomat/Shared/constants.dart';
import 'package:khsomat/business_logic/favorites_cubit/favorites_cubit.dart';
import 'package:khsomat/business_logic/home_cubit/home_cubit.dart';
import 'package:khsomat/business_logic/login_cubit/login_cubit.dart';
import 'package:khsomat/business_logic/login_cubit/login_states.dart';
import 'package:khsomat/presentation/UI/Widgets/bottomSheetWidget.dart';
import 'package:khsomat/presentation/UI/favorites_screen.dart';
import 'package:khsomat/presentation/user_info_screen.dart';
import 'package:khsomat/presentation/user_orders_screen.dart';

import '../billing_info_screen.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var firstnameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {},
        builder: (context, state) {
          // var model = LoginCubit.get(context).loginResponseModel;
          return Conditional.single(
            context: context,
            conditionBuilder: (context) => username != null && email != null,
            // username!.isNotEmpty && email!.isNotEmpty,
            widgetBuilder: (context) {
              usernameController.text = username!;
              emailController.text = email!;
              phoneController.text = phone!;
              firstnameController.text = firstname!;

              return Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 200.h,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(70.r))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.orange,
                            ),
                            child: Center(
                              child: Image.asset('assets/images/avatar.png',
                                  height: 180.h),
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(70),
                                bottom: Radius.circular(20)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Column(
                              children: [
                                RawMaterialButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: UserInfoScreen(),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        'ملفي الشخصي',
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            color: Colors.white),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        size: 15.r,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                // RawMaterialButton(
                                //   onPressed: () {
                                //     Navigator.of(context).push(
                                //       MaterialPageRoute(
                                //         builder: (context) => Directionality(
                                //           textDirection: TextDirection.rtl,
                                //           child: BillingInfoScreen(),
                                //         ),
                                //       ),
                                //     );
                                //   },
                                //   child: Row(
                                //     children: [
                                //       Text(
                                //         'عنواني',
                                //         style: TextStyle(
                                //             fontSize: 18.sp,
                                //             color: Colors.white),
                                //       ),
                                //       Icon(Icons.arrow_forward_ios,
                                //           size: 15.r, color: Colors.white),
                                //     ],
                                //   ),
                                // ),
                                // SizedBox(
                                //   height: 15.h,
                                // ),
                                RawMaterialButton(
                                  onPressed: () {
                                    // Navigator.of(context).push(
                                    //   MaterialPageRoute(
                                    //     builder: (context) => Directionality(
                                    //       textDirection: TextDirection.rtl,
                                    //       child: FavoritesScreen(),
                                    //     ),
                                    //   ),
                                    // );
                                    HomeCubit.get(context).navBarChanger(1);
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        'قائمة المفضلة',
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            color: Colors.white),
                                      ),
                                      if (FavoritesCubit.get(context)
                                          .wishList
                                          .isNotEmpty)
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      if (FavoritesCubit.get(context)
                                          .wishList
                                          .isNotEmpty)
                                      CircleAvatar(
                                        radius: 10,
                                        child: Text(
                                            '${FavoritesCubit.get(context).wishList.length}'),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        size: 15.r,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                RawMaterialButton(
                                  onPressed: () {
                                    // Navigator.of(context).push(
                                    //   MaterialPageRoute(
                                    //     builder: (context) => Directionality(
                                    //       textDirection: TextDirection.rtl,
                                    //       child: FavoritesScreen(),
                                    //     ),
                                    //   ),
                                    // );
                                    HomeCubit.get(context).navBarChanger(2);
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        'سلة التسوق',
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            color: Colors.white),
                                      ),
                                      if (FavoritesCubit.get(context)
                                          .orderList
                                          .isNotEmpty)
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                      if (FavoritesCubit.get(context)
                                          .orderList
                                          .isNotEmpty)
                                        CircleAvatar(
                                          radius: 10,
                                          child: Text(
                                              '${FavoritesCubit.get(context).orderList.length}'),
                                        ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        size: 15.r,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                RawMaterialButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: UserOrdersScreen(),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        'طلباتي',
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            color: Colors.white),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        size: 15.r,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                RawMaterialButton(
                                  onPressed: () {
                                    signOut(context);
                                    // Navigator.of(context).push(
                                    //   MaterialPageRoute(
                                    //     builder: (context) => Directionality(
                                    //       textDirection: TextDirection.rtl,
                                    //       child: UserOrdersScreen(),
                                    //     ),
                                    //   ),
                                    // );
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        'تسجيل الخروج',
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Icon(Icons.arrow_forward_ios,
                                          size: 15.r, color: Colors.white),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // defaultFormField(
                      //     controller: emailController,
                      //     type: TextInputType.emailAddress,
                      //     validate: (String value) {
                      //       if (value.isEmpty) {
                      //         return 'يجب إدخال البريد الإلكتروني';
                      //       }
                      //     },
                      //     label: 'البريد الإلكتروني',
                      //     prefix: Icons.person),
                      // SizedBox(
                      //   height: 100.h,
                      // ),
                      // TextFormField(
                      //   controller: phoneController,
                      //   keyboardType: TextInputType.phone,
                      //   validator: (String? value) {
                      //     if (value!.isEmpty) {
                      //       return 'يجب إدخال رقم التليفون';
                      //     } else if (value.length != 11) {
                      //       return 'رقم التليفون يجب أن يكون مكون من 11 رقم';
                      //     } else if (value.startsWith('01') != true) {
                      //       return 'يجب أن يبدأ رقم التليفون ب *********01';
                      //     }
                      //     return null;
                      //   },
                      //   decoration: InputDecoration(
                      //     prefixIcon: Icon(Icons.person),
                      //     label: Text(
                      //       'رقم التليفون',
                      //       style: TextStyle(fontSize: 20.sp),
                      //     ),
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(20.r),
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 15.h,
                      // ),
                      // // DropdownButtonFormField(
                      // //   items: cities,
                      // //   value: null,
                      // //   isDense: true,
                      // // ),
                      // TextFormField(
                      //   controller: firstnameController,
                      //   keyboardType: TextInputType.text,
                      //   validator: (String? value) {
                      //     if (value!.isEmpty) {
                      //       return 'يجب إدخال المدينة';
                      //     }
                      //     return null;
                      //   },
                      //   decoration: InputDecoration(
                      //     prefixIcon: Icon(Icons.person),
                      //     label: Text(
                      //       'المدينة',
                      //       style: TextStyle(fontSize: 20.sp),
                      //     ),
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(20),
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 15.h,
                      // ),

                      // Center(
                      //   child: Container(
                      //     height: 70.h,
                      //     width: 200.w,
                      //     decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(20.r),
                      //         color: Colors.amber),
                      //     child: TextButton(
                      //       onPressed: () {
                      //         signOut(context);
                      //       },
                      //       child: Text(
                      //         'تسجيل الخروج',
                      //         style: TextStyle(
                      //           color: Colors.black,
                      //           fontSize: 20.sp,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              );
            },
            fallbackBuilder: (context) => Center(
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Directionality(
                        textDirection: TextDirection.rtl,
                        child: LoginScreen(),
                      ),
                    ),
                  );
                },
                child: Text(
                  'سجل الدخول الآن',
                  style: TextStyle(fontSize: 20.sp),
                ),
              ),
            ),
          );

          // usernameController.text = model!.data!.displayName!;
          // emailController.text = model.data!.email!;

          // return  Conditional.single(
          //   context: context,
          //   conditionBuilder: (context) =>model != null,
          //   widgetBuilder: (context) => Padding(
          //     padding: const EdgeInsets.all(25.0),
          //     child:Form(
          //       key:formKey,
          //       child: Column(
          //         children: [
          //           defaultFormField(
          //               controller: usernameController,
          //               type: TextInputType.text,
          //               validate: (String value) {
          //                 if (value.isEmpty) {
          //                   return 'يجب إدخال إسم المستخدم';
          //                 }
          //               },
          //               label: 'إسم المستخدم',
          //               prefix: Icons.person),
          //           SizedBox(height: 15,),
          //           defaultFormField(
          //               controller: emailController,
          //               type: TextInputType.emailAddress,
          //               validate: (String value) {
          //                 if (value.isEmpty) {
          //                   return 'يجب إدخال البريد الإلكتروني';
          //                 }
          //               },
          //               label: 'البريد الإلكتروني',
          //               prefix: Icons.person),
          //
          //         ],
          //       ),
          //     ),
          //   ),
          //   fallbackBuilder: (context) => Center(child: CircularProgressIndicator()),
          // );
        },
      ),
    );
  }
}
