import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:khsomat/Shared/components.dart';
import 'package:khsomat/Shared/constants.dart';
import 'package:khsomat/business_logic/favorites_cubit/favorites_cubit.dart';
import 'package:khsomat/business_logic/home_cubit/home_cubit.dart';
import 'package:khsomat/business_logic/home_cubit/home_state.dart';
import 'package:khsomat/business_logic/product_cubit/product_cubit.dart';
import 'package:khsomat/data/notifcations/notifications.dart';
import 'package:khsomat/presentation/UI/Widgets/drawer/drawer_menu_screen.dart';
import 'package:khsomat/presentation/UI/Widgets/drawer_item.dart';
import 'package:khsomat/presentation/UI/cart_screen.dart';
import 'package:khsomat/presentation/UI/home_screen.dart';
import 'package:khsomat/presentation/UI/login_screen.dart';
import 'package:khsomat/presentation/UI/products_screen.dart';
import 'package:khsomat/presentation/UI/search_screen.dart';
import 'package:khsomat/presentation/custom_icons/my_flutter_app_icons.dart';
import 'package:khsomat/translations/locale_keys.g.dart';
import 'package:lottie/lottie.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Widgets/drawer/drawer_home_screen.dart';

class AppLayout extends StatelessWidget {


  static const _whatsapp = 'https://wa.me/+201220255556';
  static const _facebook = 'https://www.facebook.com/khsomatcom';
  static const _messenger = 'https://m.me/khsomatcom';
  static const _phone = 'tel:+201220255556';
  final drawerController = ZoomDrawerController();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  void _launchURL(url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        late List<SalomonBottomBarItem> items = [
          SalomonBottomBarItem(
            icon: Icon(
              Icons.home_outlined,
            ),
            title: Text(LocaleKeys.home.tr(),),
          ),
          SalomonBottomBarItem(
            icon: Icon(
              MyFlutterApp.shop,
              size: 19.sp,
            ),
            title: Text('????????????????'),
          ),
          SalomonBottomBarItem(
            icon: Stack(
              children: [
                Icon(
                  Icons.favorite,
                ),
                if(wishList.isNotEmpty)
                  CircleAvatar(child: Text('${wishList.length}',style: TextStyle(fontSize: 10.sp),),radius: 6.r,),

              ],
            ),
            title: Text(LocaleKeys.favorites.tr()),
          ),
          SalomonBottomBarItem(
            icon: Stack(fit: StackFit.loose,
              children: [
                Icon(
                  Icons.shopping_bag_outlined,
                ),
                if(orderList.isNotEmpty)
                CircleAvatar(child: Text('${orderList.length}',style: TextStyle(fontSize: 10.sp),),radius: 6.r,),

              ],
            ),
            title: Text(LocaleKeys.cart.tr()),
          ),
          SalomonBottomBarItem(
            icon: Icon(
              Icons.person,
            ),
            title: Text(LocaleKeys.profile.tr()),
          ),
        ];
        return Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: HomeCubit.get(context).currentIndex==4 ? 0.0:4.0,
            title: SvgPicture.asset(
              'assets/images/logosvg.svg',height: 30.h,

              //color: Colors.white,
              cacheColorFilter: true,
            ),
           // elevation:0,
            toolbarHeight: 80.h,centerTitle: true,
            shape: HomeCubit.get(context).currentIndex==4 ? null :RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            //Image(image: AssetImage('assets/images/150x150 Png White-01.png'),),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchScreen(),
                    ),
                  );
                },
                icon: Icon(Icons.search,size: 22.w,),
              ),
              if(HomeCubit.get(context).currentIndex==1)
              IconButton(
                ///TODO: Error Here ! :( :         BlocProvider.of() called with a context that does not contain a ProductCubit.
                onPressed: () {
                  _scaffoldKey.currentState!.showBottomSheet((context) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                    TextButton(
                          child: Text('Sort'),
                          onPressed: (){
                            ProductCubit.get(context).sortProducts();
                            // List<Map<String, dynamic>> myProducts = [
                            //   {"name": "Shoes", "price": 100},
                            //   {"name": "Pants", "price": 50},
                            //   {"name": "Book", "price": 10},
                            //   {"name": "Lamp", "price": 40},
                            //   {"name": "Fan", "price": 200}
                            // ];
                            //  ProductCubit.get(context).getProductsScreen(pageNum: 1);
                            // _controller.jumpTo(_controller.position.maxScrollExtent);
                            // printWrapped(productScreen.toString());
                            //  myProducts.sort([]);
                            //  print(myProducts);
                          },
                        ),
                    ],
                  ) );
                  // Scaffold.of(context).showBottomSheet((context) => Column(
                  //   children: [
                  //     TextButton(
                  //       child: Text('Sort'),
                  //       onPressed: (){
                  //         ProductCubit.get(context).sortProducts();
                  //         // List<Map<String, dynamic>> myProducts = [
                  //         //   {"name": "Shoes", "price": 100},
                  //         //   {"name": "Pants", "price": 50},
                  //         //   {"name": "Book", "price": 10},
                  //         //   {"name": "Lamp", "price": 40},
                  //         //   {"name": "Fan", "price": 200}
                  //         // ];
                  //         //  ProductCubit.get(context).getProductsScreen(pageNum: 1);
                  //         // _controller.jumpTo(_controller.position.maxScrollExtent);
                  //         // printWrapped(productScreen.toString());
                  //         //  myProducts.sort([]);
                  //         //  print(myProducts);
                  //       },
                  //     ),
                  //   ],
                  // ) );
                },
                icon: Icon(Icons.settings,size: 22.w,),
              ),
              // IconButton(
              //   onPressed: ()async{
              //     await createLocalNotification();
              //     AwesomeNotifications().createdStream.listen((notification) {
              //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //         content: Text(
              //           'Notification Created on ${notification.channelKey}',
              //         ),
              //       ));
              //     });
              //   },
              //   icon: Icon(Icons.alarm,size: 22.w,),
              // ),
              ///TODO:Test This Condition
              if(HomeCubit.get(context).currentIndex==2 && orderList.isNotEmpty)
              IconButton(
                onPressed: () {
                  if(orderList.isEmpty)
                    {
                      showToast(text: '?????????? ?????????? ????????????', state: ToastStates.WARNING);
                    }
                  else {
                    FavoritesCubit.get(context).deleteAllItemsFromOrderList();
                    showToast(text: '???? ?????? ???????? ???????????????? ???? ??????????', state: ToastStates.SUCCESS);
                  }
                },
                icon: Icon(Icons.delete_forever_rounded),
                color: Colors.pinkAccent[400],
              ),
              // if(HomeCubit.get(context).currentIndex==1)
              //   IconButton(
              //     onPressed: () {
              //       FavoritesCubit.get(context).deleteAllItemsFromWishList();
              //     },
              //     icon: Icon(Icons.remove),
              //     color: Colors.pinkAccent[400],
              //
              //   ),
              // TextButton(onPressed: (){
              //   signOut(context);
              // }, child: Text('?????????? ????????????',style: TextStyle(color: Colors.black),)),
            ],
          ),
          drawer: Drawer(
            semanticLabel: 'Menu',
            elevation: 20.0.w,
            child: SafeArea(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  // decoration: BoxDecoration(
                  //   color: Colors.grey.shade400,
                  //  // borderRadius: BorderRadius.circular(20),
                  //   gradient: LinearGradient(
                  //     begin: Alignment.centerRight,
                  //     end: Alignment.centerLeft,
                  //     colors:
                  //     [
                  //       Colors.blue,
                  //       //Colors.white,
                  //       Colors.grey
                  //     ],
                  //   ),
                  // ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (token == null)
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(20.r),
                              // gradient: LinearGradient(
                              //   begin: Alignment.centerRight,
                              //   end: Alignment.centerLeft,
                              //   colors:
                              //   [
                              //     Colors.blue,
                              //     //Colors.white,
                              //     Colors.grey
                              //   ],
                              // ),
                            ),
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                  ),
                                );
                              },
                              child: Text(LocaleKeys.sign_in_to_your_account.tr()),
                            ),
                          ),

                        // Lottie.asset('assets/loading/hi.json',height: 200,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (token != null)
                                Image.asset('assets/images/avatar.png',
                                    height: 80.h),
                              SizedBox(
                                height: 20.h,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '$username',
                                  style: TextStyle(fontSize: 20.sp,color: Colors.black),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: Text('$email',style: TextStyle(color: Colors.grey,fontSize: 15.sp),),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: Text('$firstname',style: TextStyle(color: Colors.grey,fontSize: 15.sp),),
                              ),
                            ],
                          ),
                        ),
                        //Image.asset('assets/images/avatar.png'),
                        Container(
                          // decoration: BoxDecoration(
                          //   color: Colors.grey.shade400,
                          //   borderRadius: BorderRadius.circular(20),
                          //   gradient: LinearGradient(
                          //     begin: Alignment.centerRight,
                          //     end: Alignment.centerLeft,
                          //     colors:
                          //     [
                          //       Colors.blue,
                          //       //Colors.white,
                          //       Colors.grey
                          //     ],
                          //   ),
                          // ),
                         // decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),gradient: Lin),
                          child: ListView.separated(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemBuilder: (context, index) => buildDrawerItem(
                                  HomeCubit.get(context).categories[index], context),
                              separatorBuilder: (context, index) => Divider(
                                    thickness: 1.w,
                                    height: 2.h,
                                  ),
                              itemCount: HomeCubit.get(context).categories.length),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          bottomNavigationBar: SalomonBottomBar(
            items: items,
            currentIndex: HomeCubit.get(context).currentIndex,
            onTap: (index) {
              HomeCubit.get(context).navBarChanger(index);
            },
          ),
          floatingActionButton: FabCircularMenu(
            alignment: Alignment.bottomLeft,
            fabSize: 55.r,
            fabMargin: EdgeInsets.only(bottom: 10.h, right: 15.w),
            fabOpenIcon: Icon(Icons.call,color: Colors.white,),
            ringDiameter: 250.r,
            ringWidth: 60.w,

            children: [
              IconButton(
                onPressed: () {
                  _launchURL(_phone);
                },
                icon: Icon(Icons.phone),
              ),
              IconButton(
                onPressed: () {
                  _launchURL(_whatsapp);
                },
                icon: Icon(MyFlutterApp.whatsapp),
              ),
              IconButton(
                onPressed: () {
                  _launchURL(_facebook);
                },
                icon: Icon(Icons.facebook),
              ),
              IconButton(
                onPressed: () {
                  _launchURL(_messenger);
                },
                icon: Icon(MyFlutterApp.facebook_messenger),
              ),
            ],
          ),
          body: HomeCubit.get(context)
              .screens[HomeCubit.get(context).currentIndex],
          // body: ZoomDrawer(
          //   controller: drawerController,
          //   style: DrawerStyle.DefaultStyle,
          //   menuScreen: DrawerMenuScreen(),
          //   mainScreen: DrawerHomeScreen(drawerController: drawerController,),
          //   borderRadius: 24.0,
          //   showShadow: true,
          //   angle: -12.0,
          //   backgroundColor: Colors.grey[300]!,
          //   slideWidth: MediaQuery.of(context).size.width*.65,
          //   openCurve: Curves.fastOutSlowIn,
          //   closeCurve: Curves.bounceIn,
          // isRtl: true,),
        );
      },
    );
  }
}
