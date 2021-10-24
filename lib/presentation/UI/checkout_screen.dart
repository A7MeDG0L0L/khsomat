import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khsomat/business_logic/favorites_cubit/favorites_cubit.dart';
import 'package:khsomat/business_logic/favorites_cubit/favorites_states.dart';
import 'package:khsomat/presentation/UI/Widgets/bottomSheetWidget.dart';
import 'package:khsomat/presentation/UI/Widgets/checkout_item.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoritesCubit()
        ..getOrderListDataFromDatabase(FavoritesCubit.get(context).database),
      child: BlocConsumer<FavoritesCubit, FavoritesStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('checkout',style: TextStyle(fontSize: 20.sp),),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisSize: MainAxisSize.max,
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.all(20.0),
                  //   child: Container(
                  //     width: 300,
                  //     height: 400,
                  //     child: HorizontalDataTable(
                  //       leftHandSideColumnWidth: 100,
                  //       rightHandSideColumnWidth: 100,
                  //       rightSideChildren: [Text('Name'), Text('age')],
                  //       leftSideChildren: [Text('phone'), Text('price')],
                  //       tableHeight: 300,
                  //       isFixedHeader: true,
                  //       headerWidgets: [
                  //         Text('name'),
                  //         Text('rates'),
                  //         Text('Quantity')
                  //       ],
                  //       rowSeparatorWidget: const Divider(
                  //         height: 2,
                  //         thickness: 2,
                  //       ),
                  //       leftHandSideColBackgroundColor: Color(0xFFFFFFFF),
                  //       rightHandSideColBackgroundColor: Color(0xFFFFFFFF),
                  //       verticalScrollbarStyle: const ScrollbarStyle(
                  //         isAlwaysShown: true,
                  //         thickness: 20.0,
                  //         radius: Radius.circular(20.0),
                  //       ),
                  //       horizontalScrollbarStyle: const ScrollbarStyle(
                  //         isAlwaysShown: true,
                  //         thickness: 4.0,
                  //         radius: Radius.circular(5.0),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Row(
                  //     children: <Widget>[
                  //       Text('الاسم'),
                  //
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 100,
                  // ),
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
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.r)),
                      color: Colors.blue,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Text('الإجمالي',style: TextStyle(color: Colors.white,fontSize: 21.sp),),
                            Spacer(),
                            Text('${FavoritesCubit.get(context).totalPrice()}',style: TextStyle(fontSize: 23.sp,color: Colors.white),),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('رجاء ادخل بياناتك لاكتمال الطلب',style: TextStyle(fontSize: 19.sp),),
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
