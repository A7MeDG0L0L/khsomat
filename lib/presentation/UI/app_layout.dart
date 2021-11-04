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
import 'package:khsomat/presentation/UI/Widgets/drawer/drawer_menu_screen.dart';
import 'package:khsomat/presentation/UI/Widgets/drawer_item.dart';
import 'package:khsomat/presentation/UI/cart_screen.dart';
import 'package:khsomat/presentation/UI/home_screen.dart';
import 'package:khsomat/presentation/UI/login_screen.dart';
import 'package:khsomat/presentation/UI/search_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Widgets/drawer/drawer_home_screen.dart';

class AppLayout extends StatelessWidget {


  static const _whatsapp = 'https://wa.me/+201220255556';
  static const _facebook = 'https://www.facebook.com/khsomatcom';
  static const _phone = 'tel:+201220255556';
  final drawerController = ZoomDrawerController();

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
            title: Text('الرئيسية',),
          ),
          SalomonBottomBarItem(
            icon: Stack(
              children: [
                Icon(
                  Icons.favorite,
                ),
                if(FavoritesCubit.get(context).wishList.isNotEmpty)
                  CircleAvatar(child: Text('${FavoritesCubit.get(context).wishList.length}',style: TextStyle(fontSize: 10.sp),),radius: 6.r,),

              ],
            ),
            title: Text('المفضلة'),
          ),
          SalomonBottomBarItem(
            icon: Stack(fit: StackFit.loose,
              children: [
                Icon(
                  Icons.shopping_bag_outlined,
                ),
                if(FavoritesCubit.get(context).orderList.isNotEmpty)
                CircleAvatar(child: Text('${FavoritesCubit.get(context).orderList.length}',style: TextStyle(fontSize: 10.sp),),radius: 6.r,),

              ],
            ),
            title: Text('السلة'),
          ),
          SalomonBottomBarItem(
            icon: Icon(
              Icons.person,
            ),
            title: Text('صفحتي'),
          ),
        ];
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: HomeCubit.get(context).currentIndex==3 ? 0.0:4.0,
            title: SvgPicture.asset(
              'assets/images/logosvg.svg',height: 30.h,

              //color: Colors.white,
              cacheColorFilter: true,
            ),
            //Image(image: AssetImage('assets/images/150x150 Png White-01.png'),),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Directionality(
                        textDirection: TextDirection.rtl,
                        child: SearchScreen(),
                      ),
                    ),
                  );
                },
                icon: Icon(Icons.search,size: 22.w,),
              ),
              ///TODO:Test This Condition
              if(HomeCubit.get(context).currentIndex==2 && FavoritesCubit.get(context).orderList.isNotEmpty)
              IconButton(
                onPressed: () {
                  if(FavoritesCubit.get(context).orderList.isEmpty)
                    {
                      showToast(text: 'السلة فارغة بالفعل', state: ToastStates.WARNING);
                    }
                  else {
                    FavoritesCubit.get(context).deleteAllItemsFromOrderList();
                    showToast(text: 'تم حذف جميع المنتجات من السلة', state: ToastStates.SUCCESS);
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
              // }, child: Text('تسجيل الخروج',style: TextStyle(color: Colors.black),)),
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
                                    builder: (context) => Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: LoginScreen(),
                                    ),
                                  ),
                                );
                              },
                              child: Text('سجل الدخول الآن'),
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
                icon: Icon(Icons.chat),
              ),
              IconButton(
                onPressed: () {
                  _launchURL(_facebook);
                },
                icon: Icon(Icons.facebook),
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
