import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:im_stepper/stepper.dart';
import 'package:khsomat/Shared/constants.dart';
import 'package:khsomat/business_logic/favorites_cubit/favorites_cubit.dart';
import 'package:khsomat/business_logic/favorites_cubit/favorites_states.dart';
import 'package:khsomat/presentation/UI/Widgets/bottomSheetWidget.dart';
import 'package:khsomat/presentation/UI/Widgets/checkout_item.dart';
import 'package:cupertino_stepper/cupertino_stepper.dart';

class CheckoutScreen extends StatefulWidget {
   CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int currentStep=0;
  bool isCompleted = false;
  var customerNoteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoritesCubit()
        ..getOrderListDataFromDatabase(FavoritesCubit.get(context).database),
      child: BlocConsumer<FavoritesCubit, FavoritesStates>(
        listener: (context, state) {},
        builder: (context, state) {
          List<Step> getSteps()=>[
            Step(
              state: currentStep>0 ? StepState.complete:StepState.indexed,
              isActive: currentStep >=0,
              title: Text('بياناتي'),
              content: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(children: [
                      Text('الإسم الأول :'),
                      SizedBox(width: 20.w,),
                      Text(firstname!),
                    ],),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(children: [
                      Text('الإسم الأخير : '),
                      SizedBox(width: 20.w,),
                      Text(lastname!),
                    ],),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(children: [
                      Text('رقم التليفون : '),
                      SizedBox(width: 20.w,),
                      Text(phone!),
                    ],),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(children: [
                      Text('المدينة : '),
                      SizedBox(width: 20.w,),
                      Text(city!),
                    ],),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(children: [
                      Text('العنوان : '),
                      SizedBox(width: 20.w,),
                      Text(address!),
                    ],),
                  ),
                ],
              ),
            ),
            Step(
              state: currentStep>1 ? StepState.complete:StepState.indexed,
              isActive: currentStep >=1,
              title: Text('المنتجات'),
              content: Column(children: [
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
                        print(FavoritesCubit.get(context).orderList);

                        return showCheckoutItem(
                            FavoritesCubit.get(context).orderList[index],
                            context);
                      },
                      separatorBuilder: (context, index) => Divider(
                        thickness: 1.h,
                      ),
                      itemCount: FavoritesCubit.get(context).orderList.length,
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
                            'الإجمالي',
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
              ],),
            ),
            Step(
              isActive: currentStep >=2,
              title: Text('إتمام الطلب'),
              content: Container(
                child:  TextFormField(
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
              ),
            )
          ];
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'إتمام الطلب',
                style: TextStyle(fontSize: 20.sp),
              ),
            ),
            body: Stepper(
                controlsBuilder: (BuildContext context,
                    {VoidCallback? onStepContinue, VoidCallback? onStepCancel}) {
                  final isLastStep = currentStep==getSteps().length-1;

                  return Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: onStepContinue,
                          child:  Text(isLastStep ?'إتمام الطلب':'متابعة'),
                        ),
                        SizedBox(width: 50.w,),
                        if(currentStep!=0)
                        ElevatedButton(
                          onPressed: onStepCancel,
                          child: const Text('رجوع'),
                        ),
                      ],
                    ),
                  );
                },
                type: StepperType.horizontal,
                currentStep: currentStep,
                onStepContinue: (){
                  final isLastStep = currentStep==getSteps().length-1;
                  if(isLastStep){
                    print('Completed');
                    ///TODO:send data to server
                    FavoritesCubit.get(context).createOrder(firstname: firstname!, lastname: lastname!, address: address!, city: city!, email: email!, phone: phone!, customerNote: customerNoteController.text);
                  }else
                  setState(() {
                    currentStep+=1;
                  });
            },
                onStepCancel:currentStep==0? null : (){
                  setState(() {
                    currentStep-=1;
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
            //     //       title: Text('عنواني'),
            //     //       content: Container(
            //     //         color: Colors.red,
            //     //         width: 200.w,
            //     //         height: 200.h,
            //     //       ),
            //     //       subtitle: Text('subtitle'),
            //     //     ),
            //     //     Step(
            //     //       isActive: true,
            //     //       title: Text('مراجعة الطلب'),
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
            //     //       Text('الاسم'),
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
            //                 'الإجمالي',
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
            //         'رجاء ادخل بياناتك لاكتمال الطلب',
            //         style: TextStyle(fontSize: 19.sp),
            //       ),
            //     ),
            //     showSheet(context),
            //   ],
            // ),
          );
        },
      ),
    );
  }

}
