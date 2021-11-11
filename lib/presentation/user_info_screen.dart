import 'package:easy_localization/src/public_ext.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khsomat/Shared/constants.dart';
import 'package:khsomat/business_logic/profile_cubit/profile_cubit.dart';
import 'package:khsomat/business_logic/profile_cubit/profile_states.dart';
import 'package:khsomat/data/cache_helper/cache_helper.dart';
import 'package:khsomat/data/repository/products_repository.dart';
import 'package:khsomat/data/web_services/web_services.dart';
import 'package:khsomat/presentation/UI/Widgets/bottomSheetWidget.dart';
import 'package:khsomat/presentation/UI/login_screen.dart';
import 'package:khsomat/translations/locale_keys.g.dart';
import 'package:lottie/lottie.dart';

class UserInfoScreen extends StatelessWidget {
  UserInfoScreen({Key? key}) : super(key: key);

  var firstnameController = TextEditingController();
  var lastnameController = TextEditingController();
  var emailController = TextEditingController();
  var usernameController = TextEditingController();

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
            firstnameController.text = state.customerModel2.firstName!;
            lastnameController.text = state.customerModel2.lastName!;
            usernameController.text = state.customerModel2.username!;
            emailController.text = state.customerModel2.email!;
            phoneController.text = state.customerModel2.billing!.phone!;
            cityController.text = state.customerModel2.billing!.city!;
            addressController.text = state.customerModel2.billing!.address1!;
          }
          if (state is RetrieveCustomerByIDErrorState) {
            firstnameController.text = state.customerModel2.firstName!;
            lastnameController.text = state.customerModel2.lastName!;
            usernameController.text = state.customerModel2.username!;
            emailController.text = state.customerModel2.email!;
            phoneController.text = state.customerModel2.billing!.phone!;
            cityController.text = state.customerModel2.billing!.city!;
            addressController.text = state.customerModel2.billing!.address1!;
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(LocaleKeys.my_profile.tr()),
              elevation: 0,
               toolbarHeight: 80.h,centerTitle: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              ),
            body: Conditional.single(
              context: context,
              conditionBuilder: (context) =>
              state is! RetrieveCustomerByIDLoadingState,
                  // firstname!.isNotEmpty &&
                  // lastname!.isNotEmpty &&
                  // email!.isNotEmpty,
              widgetBuilder: (context) {
                // firstnameController.text=firstname!;
                // lastnameController.text=lastname!;
                // emailController.text=email!;
                // usernameController.text=username!;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: firstnameController,
                                keyboardType: TextInputType.text,
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'يجب إدخال الإسم الأول';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.person),
                                  label: Text(
                                    LocaleKeys.first_name.tr(),
                                    style: TextStyle(fontSize: 20.sp),
                                  ),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: lastnameController,
                                keyboardType: TextInputType.text,
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'يجب إدخال الإسم الأخير';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.person),
                                  label: Text(
                                    LocaleKeys.last_name.tr(),
                                    style: TextStyle(fontSize: 20.sp),
                                  ),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: usernameController,
                                keyboardType: TextInputType.text,
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'يجب إدخال إسم المستخدم';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  label: Text(
                                    LocaleKeys.username.tr(),
                                    style: TextStyle(fontSize: 20.sp),
                                  ),
                                  prefixIcon: Icon(Icons.verified_user),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'يجب إدخال البريد الإلكتروني';
                                  } else if (value.isNotEmpty) {
                                    // EmailValidator.validate(value);
                                    if (EmailValidator.validate(value) ==
                                        false) {
                                      return 'يجب إدخال بريد إلكتروني صحيح';
                                    }
                                  }

                                  return null;
                                },
                                decoration: InputDecoration(
                                  label: Text(
                                    LocaleKeys.email.tr(),
                                    style: TextStyle(fontSize: 20.sp),
                                  ),
                                  prefixIcon: Icon(Icons.email),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
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
                                    LocaleKeys.phone.tr(),
                                    style: TextStyle(fontSize: 20.sp),
                                  ),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
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
                                    LocaleKeys.city.tr(),
                                    style: TextStyle(fontSize: 20.sp),
                                  ),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
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
                                    LocaleKeys.address.tr(),
                                    style: TextStyle(fontSize: 20.sp),
                                  ),
                                  prefixIcon: Icon(Icons.home_outlined),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 200.h,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(60),),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 160.w,
                              height: 70.h,
                              decoration: BoxDecoration(

                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  ProfileCubit.get(context).updateProfile(
                                    id!,
                                    firstname: firstnameController.text,
                                    lastname: lastnameController.text,
                                    username: usernameController.text,
                                    email: emailController.text,
                                    address: addressController.text,
                                    city: cityController.text,
                                    phone: phoneController.text,
                                  );
                                  CacheHelper.sharedPreferences.reload();
                                  CacheHelper.saveData(key: 'firstname', value: firstnameController.text);
                                  CacheHelper.saveData(key: 'lastname', value: lastnameController.text);
                                  CacheHelper.saveData(key: 'username', value: usernameController.text);
                                  CacheHelper.saveData(key: 'email', value: emailController.text);
                                  CacheHelper.saveData(key: 'address', value: addressController.text);
                                  CacheHelper.saveData(key: 'city', value: cityController.text);
                                  CacheHelper.saveData(key: 'phone', value: phoneController.text);
                                  CacheHelper.sharedPreferences.reload();
                                  print(lastname);

                                },
                                child: Text(LocaleKeys.update_my_info.tr(),style:TextStyle(color: Colors.white)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              fallbackBuilder: (context) {
                if(token==null){
                  return Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ));
                      },
                      child: Text(LocaleKeys.sign_in.tr()),
                    ),
                  );
                }
                else
                  return Center(
                    child: Lottie.asset('assets/loading/loading4.json'),
                  );
              },
            ),
          );
        },
      ),
    );
  }
}
