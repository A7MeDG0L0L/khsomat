import 'package:easy_localization/src/public_ext.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:im_stepper/stepper.dart';
import 'package:khsomat/Shared/components.dart';
import 'package:khsomat/Shared/constants.dart';
import 'package:khsomat/business_logic/cart_cubit/cart_cubit.dart';
import 'package:khsomat/business_logic/cart_cubit/cart_states.dart';
import 'package:khsomat/business_logic/favorites_cubit/favorites_cubit.dart';
import 'package:khsomat/business_logic/favorites_cubit/favorites_states.dart';
import 'package:khsomat/business_logic/home_cubit/home_cubit.dart';
import 'package:khsomat/presentation/UI/Widgets/bottomSheetWidget.dart';
import 'package:khsomat/presentation/UI/Widgets/checkout_item.dart';
// import 'package:cupertino_stepper/cupertino_stepper.dart';
import 'package:khsomat/presentation/UI/app_layout.dart';
import 'package:khsomat/translations/locale_keys.g.dart';
import 'package:lottie/lottie.dart';
import 'package:select_form_field/select_form_field.dart';

class CheckoutScreen extends StatefulWidget {
  CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int currentStep = 0;
  bool isCompleted = false;
  var formKey = GlobalKey<FormState>();
  var usernameController = TextEditingController();
  var firstnameController = TextEditingController();
  var lastnameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var cityController = TextEditingController();
  var addressController = TextEditingController();
  var customerNoteController = TextEditingController();
  var dropdownController = TextEditingController();
  var dropValue = '0';

  final List<Map<String, dynamic>> _items = [
    {
      'value': 'Port Said',
      'label': '??????????????',
      'icon': Text('40'),
    },
    {
      'value': 'Cairo',
      'label': '??????????????',
      'icon': Text('50'),
      // 'textStyle': TextStyle(color: Colors.red),
    },
    {
      'value': 'Alexandria',
      'label': '????????????????',
      'icon': Text('50'),
    },
    // {
    //   'value': 'starValue',
    //   'label': 'Star Label',
    //   'enable': false,
    //   'icon': Icon(Icons.grade),
    // },
    {
      'value': 'Ismailia',
      'label': '????????????????',
      'icon': Text('50'),
    },
    {
      'value': 'Suez',
      'label': '????????????',
      'icon': Text('50'),
    },
    {
      'value': 'Damietta',
      'label': '??????????',
      'icon': Text('50'),
    },
    {
      'value': 'Giza',
      'label': '????????????',
      'icon': Text('50'),
    },
    {
      'value': 'Sharqia',
      'label': '??????????????',
      'icon': Text('50'),
    },
    {
      'value': 'Behera',
      'label': '??????????????',
      'icon': Text('50'),
    },
    {
      'value': 'Gharbia',
      'label': '??????????????',
      'icon': Text('50'),
    },
    {
      'value': 'Dakahlia',
      'label': '????????????????',
      'icon': Text('50'),
    },
    {
      'value': 'Qaliobia',
      'label': '??????????????????',
      'icon': Text('50'),
    },
    {
      'value': 'Kafr El-Shekh',
      'label': '?????? ??????????',
      'icon': Text('50'),
    },
    {
      'value': 'Menofia',
      'label': '????????????????',
      'icon': Text('50'),
    },
    {
      'value': 'Mahalla',
      'label': '????????????',
      'icon': Text('50'),
    },
    {
      'value': 'Bani Sweif',
      'label': '?????? ????????',
      'icon': Text('85'),
    },
    {
      'value': 'Aswan',
      'label': '??????????',
      'icon': Text('85'),
    },
    {
      'value': 'Asiout',
      'label': '??????????',
      'icon': Text('85'),
    },
    {
      'value': 'Qena',
      'label': '??????',
      'icon': Text('85'),
    },
    {
      'value': 'Luxor',
      'label': '????????????',
      'icon': Text('85'),
    },
    {
      'value': 'Menya',
      'label': '????????????',
      'icon': Text('85'),
    },
    {
      'value': 'Sohag',
      'label': '??????????',
      'icon': Text('85'),
    },
    {
      'value': 'Red Sea',
      'label': '?????????? ????????????',
      'icon': Text('85'),
    },
    {
      'value': 'Fayoum',
      'label': '????????????',
      'icon': Text('85'),
    },
    {
      'value': 'sSinai',
      'label': '???????? ??????????',
      'icon': Text('85'),
    },
    {
      'value': 'nSinai',
      'label': '???????? ??????????',
      'icon': Text('85'),
    },
    {
      'value': 'Matrouh',
      'label': '??????????',
      'icon': Text('85'),
    },
    {
      'value': 'New Valley',
      'label': '???????????? ????????????',
      'icon': Text('85'),
    },
  ];

  Widget isCompletedWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 300.w,
            height: 300.h,
            child: Lottie.asset('assets/loading/1708-success.json'),
          ),
          ElevatedButton(
            onPressed: () {
              isCompleted = true;
              HomeCubit.get(context).currentIndex = 0;
              HomeCubit.get(context).getAllProducts();
              HomeCubit.get(context).getAllCategories();
              FavoritesCubit.get(context).deleteAllItemsFromOrderList();
              showToast(text: '???? ?????? ???????? ???????????????? ???? ??????????', state: ToastStates.SUCCESS);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AppLayout(),
                  ),
                  (route) => false);
            },
            child: Text(LocaleKeys.back_to_home_page.tr()),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit()..retrieveCustomer(),
      // ..getOrderListDataFromDatabase(database),
      child: BlocConsumer<CartCubit, CartStates>(
        listener: (context, state) {
          if (state is RetrieveCustomerByIDSuccessState) {
            firstnameController.text = state.customerModel.firstName!;
            lastnameController.text = state.customerModel.lastName!;
            phoneController.text = state.customerModel.billing!.phone!;
            addressController.text = state.customerModel.billing!.address1!;
          }
        },
        builder: (context, state) {
          List<Step> getSteps() => [
                Step(
                  state:
                      currentStep > 0 ? StepState.complete : StepState.indexed,
                  isActive: currentStep >= 0,
                  title: Text(LocaleKeys.my_info.tr()),
                  content: state is RetrieveCustomerByIDSuccessState
                      ? Form(
                          key: formKey,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: firstnameController,
                                  keyboardType: TextInputType.text,
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return LocaleKeys.must_enter_firstname
                                          .tr();
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
                                      return LocaleKeys.must_enter_lastname
                                          .tr();
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
                              // Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: TextFormField(
                              //     controller: usernameController,
                              //     keyboardType: TextInputType.text,
                              //     validator: (String? value) {
                              //       if (value!.isEmpty) {
                              //         return '?????? ?????????? ?????? ????????????????';
                              //       }
                              //       return null;
                              //     },
                              //     decoration: InputDecoration(
                              //       label: Text(
                              //         '?????? ????????????????',
                              //         style: TextStyle(fontSize: 20.sp),
                              //       ),
                              //       prefixIcon: Icon(Icons.verified_user),
                              //       border: OutlineInputBorder(),
                              //     ),
                              //   ),
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: TextFormField(
                              //     controller: emailController,
                              //     keyboardType: TextInputType.emailAddress,
                              //     validator: (String? value) {
                              //       if (value!.isEmpty) {
                              //         return '?????? ?????????? ???????????? ????????????????????';
                              //       } else if (value.isNotEmpty) {
                              //         // EmailValidator.validate(value);
                              //         if (EmailValidator.validate(value) ==
                              //             false) {
                              //           return '?????? ?????????? ???????? ???????????????? ????????';
                              //         }
                              //       }
                              //
                              //       return null;
                              //     },
                              //     decoration: InputDecoration(
                              //       label: Text(
                              //         '???????????? ????????????????????',
                              //         style: TextStyle(fontSize: 20.sp),
                              //       ),
                              //       prefixIcon: Icon(Icons.email),
                              //       border: OutlineInputBorder(),
                              //     ),
                              //   ),
                              // ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: phoneController,
                                  keyboardType: TextInputType.phone,
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return LocaleKeys.must_enter_phone.tr();
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
                              // Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: TextFormField(
                              //     controller: cityController,
                              //     keyboardType: TextInputType.text,
                              //     validator: (String? value) {
                              //       if (value!.isEmpty) {
                              //         return '?????? ?????????? ??????????????';
                              //       }
                              //       return null;
                              //     },
                              //     decoration: InputDecoration(
                              //       prefixIcon: Icon(Icons.pin_drop_outlined),
                              //       label: Text(
                              //         '??????????????',
                              //         style: TextStyle(fontSize: 20.sp),
                              //       ),
                              //       border: OutlineInputBorder(),
                              //     ),
                              //   ),
                              // ),

                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SelectFormField(
                                  type: SelectFormFieldType
                                      .dialog, // or can be dialog
                                  // initialValue: 'City',
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    label: Text(LocaleKeys.city.tr()),
                                    prefixIcon: Icon(Icons.map),
                                    hintText: '???????? ????????????',
                                  ),
                                  controller: dropdownController,
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return '?????? ?????????? ?????????????? ???????????? ?????????? ??????????';
                                    }
                                    return null;
                                  },
                                  icon: Icon(Icons.map),
                                  labelText: '??????????????',
                                  items: _items,
                                  onChanged: (val) {
                                    switch (val) {
                                      case 'Port Said':
                                        val = '40';
                                        dropValue = val;
                                        break;
                                      case 'Cairo':
                                        val = '50';
                                        dropValue = val;
                                        break;
                                      case 'Giza':
                                        val = '50';
                                        dropValue = val;
                                        break;
                                      case 'Ismailia':
                                        val = '50';
                                        dropValue = val;
                                        break;
                                      case 'Alexandria':
                                        val = '50';
                                        dropValue = val;
                                        break;
                                      case 'Behera':
                                        val = '50';
                                        dropValue = val;
                                        break;
                                      case 'Dakahlia':
                                        val = '50';
                                        dropValue = val;
                                        break;
                                      case 'Damietta':
                                        val = '50';
                                        dropValue = val;
                                        break;
                                      case 'Gharbia':
                                        val = '50';
                                        dropValue = val;
                                        break;
                                      case 'Qaliobia':
                                        val = '50';
                                        dropValue = val;
                                        break;
                                      case 'Kafr El-Shekh':
                                        val = '50';
                                        dropValue = val;
                                        break;
                                      case 'Menofia':
                                        val = '50';
                                        dropValue = val;
                                        break;
                                      case 'Sharqia':
                                        val = '50';
                                        dropValue = val;
                                        break;
                                      case 'Mahalla':
                                        val = '50';
                                        dropValue = val;
                                        break;
                                      case 'Suez':
                                        val = '50';
                                        dropValue = val;
                                        break;
                                      case 'Aswan':
                                        val = '85';
                                        dropValue = val;
                                        break;
                                      case 'Asiout':
                                        val = '85';
                                        dropValue = val;
                                        break;
                                      case 'Bani Sweif':
                                        val = '85';
                                        dropValue = val;
                                        break;
                                      case 'Qena':
                                        val = '85';
                                        dropValue = val;
                                        break;
                                      case 'Luxor':
                                        val = '85';
                                        dropValue = val;
                                        break;
                                      case 'Menya':
                                        val = '85';
                                        dropValue = val;
                                        break;
                                      case 'Sohag':
                                        val = '85';
                                        dropValue = val;
                                        break;
                                      case 'Red Sea':
                                        val = '85';
                                        dropValue = val;
                                        break;
                                      case 'Fayoum':
                                        val = '85';
                                        dropValue = val;
                                        break;
                                      case 'sSinai':
                                        val = '85';
                                        dropValue = val;
                                        break;
                                      case 'nSinai':
                                        val = '85';
                                        dropValue = val;
                                        break;
                                      case 'Matrouh':
                                        val = '85';
                                        dropValue = val;
                                        break;
                                      case 'New Valley':
                                        val = '85';
                                        dropValue = val;
                                        break;
                                    }

                                    print(val);
                                    setState(() {
                                      dropValue = val;
                                    });
                                  },
                                  onSaved: (val) => print(val),
                                  dialogTitle: '???????? ?????????????? ???????? ????????',
                                  hintText: 'Galal',
                                  enabled: true,
                                  changeIcon: true,
                                  enableSearch: true,
                                  dialogSearchHint: '???????? ???? ????????????',
                                  dialogCancelBtn: '??????????',
                                  autovalidate: true,
                                  enableSuggestions: true,
                                  enableInteractiveSelection: false,
                                  toolbarOptions: ToolbarOptions(
                                    copy: true,
                                    selectAll: true,
                                  ),
                                  showCursor: true,
                                  smartQuotesType: SmartQuotesType.enabled,
                                ),
                              ),
                              Text(
                                  '${LocaleKeys.total_shipping_is.tr()}$dropValue'),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: addressController,
                                  keyboardType: TextInputType.streetAddress,
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return LocaleKeys.must_enter_address.tr();
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

                              // Padding(
                              //   padding: const EdgeInsets.all(10.0),
                              //   child: Row(
                              //     children: [
                              //       Text('?????????? ?????????? :'),
                              //       SizedBox(
                              //         width: 20.w,
                              //       ),
                              //       Text(firstname!),
                              //     ],
                              //   ),
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.all(10.0),
                              //   child: Row(
                              //     children: [
                              //       Text('?????????? ???????????? : '),
                              //       SizedBox(
                              //         width: 20.w,
                              //       ),
                              //       Text(lastname!),
                              //     ],
                              //   ),
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.all(10.0),
                              //   child: Row(
                              //     children: [
                              //       Text('?????? ???????????????? : '),
                              //       SizedBox(
                              //         width: 20.w,
                              //       ),
                              //       Text(phone!),
                              //     ],
                              //   ),
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.all(10.0),
                              //   child: Row(
                              //     children: [
                              //       Text('?????????????? : '),
                              //       SizedBox(
                              //         width: 20.w,
                              //       ),
                              //       Text(city!),
                              //     ],
                              //   ),
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.all(10.0),
                              //   child: Row(
                              //     children: [
                              //       Text('?????????????? : '),
                              //       SizedBox(
                              //         width: 20.w,
                              //       ),
                              //       Text(address!),
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                        )
                      : Center(child: loadingIndicator()),
                ),
                Step(
                  state:
                      currentStep > 1 ? StepState.complete : StepState.indexed,
                  isActive: currentStep >= 1,
                  title: Text(LocaleKeys.products.tr()),
                  content: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            //  color: Colors.grey.shade500,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: ListView.separated(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              // if(FavoritesCubit.get(context).orderList.isEmpty){
                              //   FavoritesCubit.get(context).getOrderListDataFromDatabase(FavoritesCubit.get(context).database);
                              //
                              // }
                              print(orderList);

                              return showCheckoutItem(
                                  orderList[index], context);
                            },
                            separatorBuilder: (context, index) => Divider(
                              thickness: 1.h,
                            ),
                            itemCount: orderList.length,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(20.r)),
                            color: Colors.blue,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                Text(
                                  LocaleKeys.subtotal.tr(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 21.sp),
                                ),
                                Spacer(),
                                Text(
                                  '${FavoritesCubit.get(context).totalPrice()}',
                                  style: TextStyle(
                                      fontSize: 23.sp, color: Colors.white),
                                ),

                                // Text(
                                //   '$total',
                                //   style: TextStyle(
                                //       fontSize: 23.sp, color: Colors.white),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8, bottom: 8, right: 25, left: 25),
                        child: Row(children: [
                          Text(
                            LocaleKeys.total_shipping.tr(),
                            style:
                                TextStyle(color: Colors.black, fontSize: 21.sp),
                          ),
                          Spacer(),
                          Text(
                            '$dropValue',
                            style:
                                TextStyle(fontSize: 23.sp, color: Colors.black),
                          ),
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(20.r)),
                            color: Colors.blue,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                Text(
                                  LocaleKeys.total.tr(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 21.sp),
                                ),
                                Spacer(),
                                Text(
                                  '${FavoritesCubit.get(context).totalPrice() + int.parse(dropValue)}',
                                  style: TextStyle(
                                      fontSize: 23.sp, color: Colors.white),
                                ),

                                // Text(
                                //   '$total',
                                //   style: TextStyle(
                                //       fontSize: 23.sp, color: Colors.white),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Step(
                  isActive: currentStep >= 2,
                  title: Text(LocaleKeys.complete_order.tr()),
                  content: Container(
                    child: TextFormField(
                      style: TextStyle(height: 5.h),
                      controller: customerNoteController,
                      keyboardType: TextInputType.multiline,
                      // validator: (String? value) {
                      //   if (value!.isEmpty) {
                      //     return '?????? ?????????? ?????????? ????????????';
                      //   }
                      //   return null;
                      // },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.sticky_note_2_rounded),
                        label: Text(
                          LocaleKeys.notes.tr(),
                          style: TextStyle(fontSize: 20.sp),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                      ),
                    ),
                  ),
                )
              ];

          if (state is RetrieveCustomerByIDSuccessState)
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  LocaleKeys.complete_order.tr(),
                  style: TextStyle(fontSize: 20.sp),
                ),
              ),
              body: isCompleted
                  ? isCompletedWidget()
                  : Stepper(
                      controlsBuilder: (BuildContext context,details,
                          {VoidCallback? onStepContinue,
                          VoidCallback? onStepCancel}) {
                        final isLastStep = currentStep == getSteps().length - 1;

                        return Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              ElevatedButton(
                                style: ButtonStyle(
                                  alignment: Alignment.center,
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.only(
                                          top: 20,
                                          left: 30,
                                          right: 30,
                                          bottom: 20)),
                                ),
                                onPressed: onStepContinue,
                                child: Text(isLastStep
                                    ? LocaleKeys.complete_order.tr()
                                    : LocaleKeys.continuee.tr()),
                              ),
                              SizedBox(
                                width: 50.w,
                              ),
                              if (currentStep != 0)
                                ElevatedButton(
                                  onPressed: onStepCancel,
                                  child: Text(LocaleKeys.back.tr()),
                                  style: ButtonStyle(
                                    alignment: Alignment.center,
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.only(
                                            top: 20,
                                            left: 30,
                                            right: 30,
                                            bottom: 20)),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                      type: StepperType.horizontal,
                      currentStep: currentStep,
                      onStepContinue: () {
                        // if(currentStep==0){
                        //   formKey.currentState!.validate();
                        //   print('Validate !');
                        // }

                        final isLastStep = currentStep == getSteps().length - 1;
                        if (isLastStep) {
                          print('Completed');
                          print(isCompleted);
                          setState(() {
                            isCompleted = true;
                          });

                          print(isCompleted);

                          // if(formKey.currentState!.validate()){

                          ///TODO:send data to server
                          FavoritesCubit.get(context).createOrder(
                            firstname: firstnameController.text,
                            lastname: lastnameController.text,
                            address: addressController.text,
                            city: dropdownController.text,
                            shippingRate: dropValue,
                            phone: phoneController.text,
                            customerNote: customerNoteController.text,
                            email: email!,
                          );
                          // }

                          // HomeCubit.get(context).currentIndex = 0;
                          // Navigator.pushAndRemoveUntil(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => Directionality(
                          //           textDirection: TextDirection.rtl,
                          //           child: AppLayout()),
                          //     ),
                          //     (route) => false);
                        } else if (currentStep == 0 &&
                            formKey.currentState!.validate()) {
                          setState(() {
                            currentStep += 1;
                          });
                        } else if (currentStep != 0)
                          setState(() {
                            currentStep += 1;
                          });
                      },
                      onStepCancel: currentStep == 0
                          ? null
                          : () {
                              setState(() {
                                currentStep -= 1;
                              });
                            },
                      steps: getSteps()),

              // child: Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   // mainAxisSize: MainAxisSize.max,
              //   children: [
              //
              //
              //     // NumberStepper(numbers: [1,2],activeStepColor: Colors.blue,lineLength: 100.w,enableNextPreviousButtons: false,stepReachedAnimationDuration: Duration(seconds: 1),stepReachedAnimationEffect: Curves.fastOutSlowIn,activeStep: 0,onStepReached: (int){
              //     // },),
              //
              //     // CupertinoStepper(
              //     //   type: StepperType.vertical,
              //     //   physics: BouncingScrollPhysics(),
              //     //
              //     //   steps: [
              //     //     Step(isActive: true,
              //     //       title: Text('????????????'),
              //     //       content: Container(
              //     //         color: Colors.red,
              //     //         width: 200.w,
              //     //         height: 200.h,
              //     //       ),
              //     //       subtitle: Text('subtitle'),
              //     //     ),
              //     //     Step(
              //     //       isActive: true,
              //     //       title: Text('???????????? ??????????'),
              //     //       content: Container(
              //     //         color: Colors.red,
              //     //         width: 200.w,
              //     //         height: 200.h,
              //     //       ),
              //     //       subtitle: Text('subtitle'),
              //     //     ),
              //     //   ],
              //     // ),
              //
              //     // Padding(
              //     //   padding: const EdgeInsets.all(20.0),
              //     //   child: Container(
              //     //     width: 300,
              //     //     height: 400,
              //     //     child: HorizontalDataTable(
              //     //       leftHandSideColumnWidth: 100,
              //     //       rightHandSideColumnWidth: 100,
              //     //       rightSideChildren: [Text('Name'), Text('age')],
              //     //       leftSideChildren: [Text('phone'), Text('price')],
              //     //       tableHeight: 300,
              //     //       isFixedHeader: true,
              //     //       headerWidgets: [
              //     //         Text('name'),
              //     //         Text('rates'),
              //     //         Text('Quantity')
              //     //       ],
              //     //       rowSeparatorWidget: const Divider(
              //     //         height: 2,
              //     //         thickness: 2,
              //     //       ),
              //     //       leftHandSideColBackgroundColor: Color(0xFFFFFFFF),
              //     //       rightHandSideColBackgroundColor: Color(0xFFFFFFFF),
              //     //       verticalScrollbarStyle: const ScrollbarStyle(
              //     //         isAlwaysShown: true,
              //     //         thickness: 20.0,
              //     //         radius: Radius.circular(20.0),
              //     //       ),
              //     //       horizontalScrollbarStyle: const ScrollbarStyle(
              //     //         isAlwaysShown: true,
              //     //         thickness: 4.0,
              //     //         radius: Radius.circular(5.0),
              //     //       ),
              //     //     ),
              //     //   ),
              //     // ),
              //     // Padding(
              //     //   padding: const EdgeInsets.all(8.0),
              //     //   child: Row(
              //     //     children: <Widget>[
              //     //       Text('??????????'),
              //     //
              //     //     ],
              //     //   ),
              //     // ),
              //     // SizedBox(
              //     //   height: 100,
              //     // ),
              //     Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Container(
              //         decoration: BoxDecoration(
              //           //  color: Colors.grey.shade500,
              //           borderRadius: BorderRadius.circular(20.r),
              //         ),
              //         child: ListView.separated(
              //           scrollDirection: Axis.vertical,
              //           shrinkWrap: true,
              //           physics: BouncingScrollPhysics(),
              //           itemBuilder: (context, index) {
              //             // if(FavoritesCubit.get(context).orderList.isEmpty){
              //             //   FavoritesCubit.get(context).getOrderListDataFromDatabase(FavoritesCubit.get(context).database);
              //             //
              //             // }
              //             print(FavoritesCubit.get(context).orderList);
              //
              //             return showCheckoutItem(
              //                 FavoritesCubit.get(context).orderList[index],
              //                 context);
              //           },
              //           separatorBuilder: (context, index) => Divider(
              //             thickness: 1.h,
              //           ),
              //           itemCount: FavoritesCubit.get(context).orderList.length,
              //         ),
              //       ),
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Container(
              //         height: 30,
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.vertical(
              //               bottom: Radius.circular(20.r)),
              //           color: Colors.blue,
              //         ),
              //         child: Padding(
              //           padding: const EdgeInsets.symmetric(horizontal: 20),
              //           child: Row(
              //             children: [
              //               Text(
              //                 '????????????????',
              //                 style: TextStyle(
              //                     color: Colors.white, fontSize: 21.sp),
              //               ),
              //               Spacer(),
              //               Text(
              //                 '${FavoritesCubit.get(context).totalPrice()}',
              //                 style: TextStyle(
              //                     fontSize: 23.sp, color: Colors.white),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ),
              //     SizedBox(
              //       height: 20.h,
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Text(
              //         '???????? ???????? ?????????????? ?????????????? ??????????',
              //         style: TextStyle(fontSize: 19.sp),
              //       ),
              //     ),
              //     showSheet(context),
              //   ],
              // ),
            );
          else {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  LocaleKeys.complete_order.tr(),
                  style: TextStyle(fontSize: 20.sp),
                ),
              ),
              body: loadingIndicator(),
            );
          }
        },
      ),
    );
  }
}
