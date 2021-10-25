import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khsomat/Shared/components.dart';
import 'package:khsomat/business_logic/favorites_cubit/favorites_cubit.dart';
import 'package:email_validator/email_validator.dart';


import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

var firstNameController = TextEditingController();
var lastNameController = TextEditingController();
var addressController = TextEditingController();
var cityController = TextEditingController();
var emailController = TextEditingController();
var phoneController = TextEditingController();
var customerNoteController = TextEditingController();
var formKey = GlobalKey<FormState>();

Widget showSheet(context) {
  return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              controller: firstNameController,
              keyboardType: TextInputType.name,
              validator: (String? value) {
                if (value!.isEmpty) {
                  return 'يجب إدخال الإسم الأول';
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                label: Text('الإسم الأول',style: TextStyle(fontSize: 20.sp),),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            TextFormField(
              controller: lastNameController,
              keyboardType: TextInputType.name,
              validator: (String? value) {
                if (value!.isEmpty) {
                  return 'يجب إدخال الإسم الآخير';
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                label: Text('الإسم الآخير',style: TextStyle(fontSize: 20.sp),),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            TextFormField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              validator: (String? value) {
                if (value!.isEmpty ) {
                  return 'يجب إدخال رقم التليفون';
                }
                else if( value.length != 11){
                  return 'رقم التليفون يجب أن يكون مكون من 11 رقم';
                }
                else if (value.startsWith('01')!=true){
                  return 'يجب أن يبدأ رقم التليفون ب *********01';
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                label: Text('رقم التليفون',style: TextStyle(fontSize: 20.sp),),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            // DropdownButtonFormField(
            //   items: cities,
            //   value: null,
            //   isDense: true,
            // ),
            TextFormField(
              controller: cityController,
              keyboardType: TextInputType.text,
              validator: (String? value) {
                if (value!.isEmpty) {
                  return 'يجب إدخال المدينة';
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                label: Text('المدينة',style: TextStyle(fontSize: 20.sp),),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            TextFormField(
              controller: addressController,
              keyboardType: TextInputType.streetAddress,
              validator: (String? value) {
                if (value!.isEmpty) {
                  return 'يجب إدخال العنوان';
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.pin_drop_outlined),
                label: Text('العنوان',style: TextStyle(fontSize: 20.sp),),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (String? value) {
                if (value!.isEmpty) {
                  return 'يجب إدخال البريد الإلكتروني';
                }
                else if (value.isNotEmpty){
                  // EmailValidator.validate(value);
                  if(EmailValidator.validate(value)==false){
                    return 'يجب إدخال بريد إلكتروني صحيح';
                  }

                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email_outlined),
                label: Text('البريد الإلكتروني',style: TextStyle(fontSize: 20.sp),),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            TextFormField(
              style: TextStyle(height: 5.h),
              controller: customerNoteController,
              keyboardType: TextInputType.multiline,
              // validator: (String? value) {
              //   if (value!.isEmpty) {
              //     return 'يجب إدخال الإسم الآخير';
              //   }
              //   return null;
              // },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.sticky_note_2_rounded),
                label: Text('ملاحظات',style: TextStyle(fontSize: 20.sp),),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80.w,
                    height: 50.h,
                    child: ElevatedButton(
                      onPressed: () {
                        //print(FavoritesCubit.get(context).orderList);
                        if (formKey.currentState!.validate())  {
                          // print(firstNameController.text);
                          FavoritesCubit.get(context).createOrder(
                            firstname: firstNameController.text,
                            lastname: lastNameController.text,
                            address: addressController.text,
                            city: cityController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                            customerNote: customerNoteController.text,
                            //  itemsList: jsonEncode(FavoritesCubit.get(context).orderList),
                          );
                          // showDialog(context: context, builder: (context) => Text('تم ارسال الطلب'),);
                          // print(jsonEncode(FavoritesCubit.get(context).orderList));
                          showAnimatedDialog(
                            context: context,
                            builder: (context) => ClassicGeneralDialogWidget(
                              titleText: 'معلومات عن الطلب',
                              contentText: 'تم إرسال الطلب بنجاح إنتظر مكالمة من خدمه العملاء',
                              onPositiveClick: () {
                                Navigator.of(context).pop();
                                FavoritesCubit.get(context).deleteAllItemsFromOrderList();

                              },
                              onNegativeClick: () {
                                Navigator.of(context).pop();
                                FavoritesCubit.get(context).deleteAllItemsFromOrderList();
                              },
                            ),
                            animationType: DialogTransitionType.slideFromBottomFade,
                            curve: Curves.fastOutSlowIn,
                            duration: Duration(seconds: 1),
                          );
                          FavoritesCubit.get(context).deleteAllItemsFromOrderList();
                          showToast(
                              text: 'تم ارسال الاوردر بأنتظار التأكيد',
                              state: ToastStates.SUCCESS);
                          Navigator.of(context).pop();
                        }
                        //showDialog(context: context, builder: (context) => Text('تم ارسال الطلب'),);
                        // showOkAlertDialog(
                        //   context: context,
                        //   title: 'معلومات عن الطلب',
                        //   message: 'تم إرسال الطلب بنجاح !',
                        //   okLabel: 'موافق',
                        // );

                      },
                      child: Text('تم',style: TextStyle(fontSize: 20.sp),),
                    ),
                  ),
                  SizedBox(width: 70.w,),
                  Container(
                    width: 80.w,
                    height: 50.h,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('رجوع',style: TextStyle(fontSize: 20.sp),),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
