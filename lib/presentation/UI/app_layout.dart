import 'package:carousel_slider/carousel_slider.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khsomat/Shared/my_colors.dart';
import 'package:khsomat/business_logic/home_cubit/home_cubit.dart';
import 'package:khsomat/business_logic/home_cubit/home_state.dart';
import 'package:khsomat/presentation/UI/favorites_screen.dart';
import 'package:khsomat/presentation/UI/home_screen.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class AppLayout extends StatelessWidget {


  late List<SalomonBottomBarItem> items = [
    SalomonBottomBarItem(
      icon: Icon(
        Icons.home_outlined,
      ),
      title: Text('الرئيسية'),
    ),
    SalomonBottomBarItem(
      icon: Icon(
        Icons.favorite,
      ),
      title: Text('المفضلة'),
    ),
    SalomonBottomBarItem(
      icon: Icon(
        Icons.shopping_bag_outlined,
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


  static const _whatsapp = 'https://wa.me/+201119369127';
  static const _facebook = 'https://www.facebook.com/khsomatcom';
  static const _phone = 'tel:+201119369127';

  void _launchURL(url) async => await canLaunch(url)
      ? await launch(url)
      : throw 'Could not launch $url';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: SvgPicture.asset('assets/images/company logo.svg'),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.search),
              ),
            ],
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
            fabSize: 54,
            fabMargin: EdgeInsets.only(bottom: 10,right: 15) ,
            fabOpenIcon: Icon(Icons.contact_support_outlined),
            ringDiameter: 250,
            ringWidth: 60,

            children: [
            IconButton(onPressed: (){
              _launchURL(_phone);

            }, icon: Icon(Icons.phone),),
            IconButton(onPressed: (){
              _launchURL(_whatsapp);
            }, icon: Icon(Icons.chat),),
            IconButton(onPressed: (){
              _launchURL(_facebook);
            }, icon: Icon(Icons.facebook),),
          ],),
          body: HomeCubit.get(context).screens[HomeCubit.get(context).currentIndex],
        );
      },
    );
  }


}
