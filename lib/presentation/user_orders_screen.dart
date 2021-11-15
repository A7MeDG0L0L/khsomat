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
import 'package:khsomat/data/models/order_model.dart';
import 'package:khsomat/data/repository/products_repository.dart';
import 'package:khsomat/data/web_services/web_services.dart';
import 'package:khsomat/presentation/UI/login_screen.dart';
import 'package:khsomat/translations/locale_keys.g.dart';

class UserOrdersScreen extends StatelessWidget {
  UserOrdersScreen({Key? key}) : super(key: key);

  List<OrderModel>? orders;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            ProfileCubit(ProductRepository(WebServices()))..getCustomerOrders(),
        child: BlocConsumer<ProfileCubit, ProfileStates>(
          listener: (context, state) {
            if (state is RetrieveCustomerOrdersSuccessState) {
              orders = state.orders;
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Text(LocaleKeys.my_orders.tr()),
                toolbarHeight: 80.h,centerTitle: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(30),
                  ),
                ),
              ),
              body: Conditional.single(
                context: context,
                conditionBuilder:(context) =>  ProfileCubit.get(context).orders.isNotEmpty,
                widgetBuilder: (context) => SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemBuilder: (context, index) => builderWidget(
                            ProfileCubit.get(context).orders[index]),
                        separatorBuilder: (context, index) => Divider(
                          thickness: 1.w,
                          height: 1.h,
                        ),
                        itemCount: ProfileCubit.get(context).orders.length,
                      ),
                    ],
                  ),
                ),
                fallbackBuilder: (context) =>  Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Icon(Icons.remove_shopping_cart_outlined,color: Colors.blue,size: 150.w,),
                    SizedBox(height: 20.h,),
                    Text(LocaleKeys.no_orders_yet.tr()),
                  ],),
                ),
              ),
            );
          },
        ));
  }

  Widget builderWidget(OrderModel model) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        Container(
          child: Center(
              child: Text(
            '${model.status}',
            style: TextStyle(color: Colors.white),
          )),
          width: 100.w,
          height: 30.h,
          decoration: BoxDecoration(
            color: Colors.deepOrangeAccent,
            borderRadius: BorderRadius.horizontal(
              right: Radius.circular(20),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 30.r,
                child: Text(
                  '${model.id}',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(
                height: 5.h,
                width: 20.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      '${model.billing!.firstName! + ' ' + model.billing!.lastName!}'),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text('${LocaleKeys.total.tr()} : ${model.total}'),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text('${LocaleKeys.total_shipping.tr()} : ${model.shippingTotal}'),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text('${LocaleKeys.order_date.tr()} : ${model.dateCreated}'),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text('${LocaleKeys.paying_method.tr()} : ${model.paymentMethodTitle}'),
                  SizedBox(
                    height: 5.h,
                  ),
                  Container(
                      width: 250.w,
                      child: Text(
                        '${LocaleKeys.address.tr()} : ${model.billing!.address1}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text('${LocaleKeys.phone.tr()} : ${model.billing!.phone}'),
                  SizedBox(
                    height: 5.h,
                  ),
                  Center(
                      child: Container(
                          height: 100.h,
                          width: 200.w,
                          child: ListView.separated(
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemBuilder: (context, index) =>
                                  Text('${model.lineItems![index].name}',style: TextStyle(color: Colors.orange),),
                              separatorBuilder: (context, index) => Divider(
                                    height: 1.h,
                                    endIndent: 20.w,
                                  ),
                              itemCount: model.lineItems!.length))),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
