import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khsomat/Shared/constants.dart';
import 'package:khsomat/business_logic/profile_cubit/profile_cubit.dart';
import 'package:khsomat/business_logic/profile_cubit/profile_states.dart';
import 'package:khsomat/data/repository/products_repository.dart';
import 'package:khsomat/data/web_services/web_services.dart';
import 'package:khsomat/presentation/UI/login_screen.dart';

class BillingInfoScreen extends StatelessWidget {
  BillingInfoScreen({Key? key}) : super(key: key);

  var phoneController = TextEditingController();
  var cityController = TextEditingController();
  var addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProfileCubit(ProductRepository(WebServices()))..retrieveCustomer(),
      child: BlocConsumer<ProfileCubit, ProfileStates>(
        listener: (context, state) {
          if (state is UpdateProfileSuccessState) {
            ProfileCubit.get(context).retrieveCustomer();
          }
          if (state is RetrieveCustomerByIDSuccessState) {
            phoneController.text = state.customerModel2.billing!.phone!;
            cityController.text = state.customerModel2.billing!.city!;
            addressController.text = state.customerModel2.billing!.address1!;
          }
          if (state is RetrieveCustomerByIDErrorState) {

          }
        },
        builder: (context, state) {
          return  Scaffold(
            appBar: AppBar(
              title: Text('عنواني'),
            ),
            body: Conditional.single(
              context: context,
              conditionBuilder: (context) =>
              firstname!.isNotEmpty &&
                  lastname!.isNotEmpty &&
                  email!.isNotEmpty,
              widgetBuilder: (context) {
                // phoneController.text=phone!;
                // cityController.text=city!;
                // addressController.text=address??'Address';
                return Column(
                  children: [
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
                        label: Text(
                          'التليفون',
                          style: TextStyle(fontSize: 20.sp),
                        ),
                        border: UnderlineInputBorder(),
                      ),
                    ),
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
                        prefixIcon: Icon(Icons.pin_drop_outlined),
                        label: Text(
                          'المدينة',
                          style: TextStyle(fontSize: 20.sp),
                        ),
                        border: UnderlineInputBorder(),
                      ),
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
                        label: Text(
                          'العنوان',
                          style: TextStyle(fontSize: 20.sp),
                        ),
                        prefixIcon: Icon(Icons.home_outlined),
                        border: UnderlineInputBorder(),
                      ),
                    ),
                  ],
                );
              },
              fallbackBuilder: (context) {
                return TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Directionality(
                          textDirection: TextDirection.rtl, child: LoginScreen()),
                    ));
                  },
                  child: Text('سجل الدخول'),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
