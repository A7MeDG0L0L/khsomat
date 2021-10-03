import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khsomat/Shared/components.dart';
import 'package:khsomat/business_logic/favorites_cubit/favorites_cubit.dart';
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
                label: Text('الإسم الأول'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(
              height: 15,
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
                label: Text('الإسم الآخير'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              validator: (String? value) {
                if (value!.isEmpty) {
                  return 'يجب إدخال رقم التليفون';
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                label: Text('رقم التليفون'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(
              height: 15,
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
                label: Text('المدينة'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(
              height: 15,
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
                label: Text('العنوان'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (String? value) {
                if (value!.isEmpty) {
                  return 'يجب إدخال البريد الإلكتروني';
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email_outlined),
                label: Text('البريد الإلكتروني'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              style: TextStyle(height: 5),
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
                label: Text('ملاحظات'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                print(FavoritesCubit.get(context).orderList);
                if (formKey.currentState!.validate()) {
                  print(firstNameController.text);
                  FavoritesCubit.get(context).createOrder(
                    firstname: firstNameController.text,
                    lastname: lastNameController.text,
                    address: addressController.text,
                    city: cityController.text,
                    email: emailController.text,
                    phone: phoneController.text,
                    customerNote: customerNoteController.text,
                    itemsList: FavoritesCubit.get(context).orderListToJson(),
                  );
                  showToast(
                      text: 'تم ارسال الاوردر بأنتظار التأكيد',
                      state: ToastStates.SUCCESS);
                  Navigator.pop(context);
                }
              },
              child: Text('إدفع'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('اخلع'),
            ),
          ],
        ),
      ),
    ),
  );
}