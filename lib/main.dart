import 'dart:convert';

import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khsomat/Shared/my_colors.dart';
import 'package:khsomat/business_logic/favorites_cubit/favorites_cubit.dart';
import 'package:khsomat/business_logic/home_cubit/home_cubit.dart';
import 'package:khsomat/business_logic/home_cubit/home_state.dart';
import 'package:khsomat/data/repository/products_repository.dart';
import 'package:khsomat/data/web_services/web_services.dart';
import 'package:khsomat/presentation/UI/app_layout.dart';
import 'package:khsomat/presentation/UI/register_screen.dart';
import 'package:khsomat/translations/codegen_loader.g.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:translator/translator.dart';

import 'BlocObserver.dart';
import 'Shared/constants.dart';
import 'app_router.dart';
import 'business_logic/search_cubit/search_cubit.dart';
import 'data/cache_helper/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final translator = GoogleTranslator();
  //
  // List text=[
  //   {
  //     'id': 1,
  //     'product_id': 52457,
  //     'name': ' جهاز بلايستيشن سونى Sony playstation 4 (1 تيرا)',
  //     'image': 'https://khsomat.net/wp-content/uploads/2021/09/kh2037-1.jpg',
  //     'regularprice': 870000,
  //     'saleprice': 810000,
  //     'permalink':
  //         'https://khsomat.net/product/%d8%ac%d9%87%d8%a7%d8%b2-%d8%a8%d9%84%d8%a7%d9%8a%d8%b3%d8%aa%d9%8a%d8%b4%d9%86-%d8%b3%d9%88%d9%86%d9%89-sony-playstation-4-1-%d8%aa%d9%8a%d8%b1%d8%a7/',
  //     'quantity': 7
  //   },
  //   {
  //     'id': 2,
  //     'product_id': 52302,
  //     'name': ' جمبسوت اطفالي',
  //     'image': 'https://khsomat.net/wp-content/uploads/2021/09/2-54.jpg',
  //     'regularprice': 34000,
  //     'saleprice': 27500,
  //     'permalink':
  //         'https://khsomat.net/product/%d8%ac%d9%85%d8%a8%d8%b3%d9%88%d8%aa-%d8%a7%d8%b7%d9%81%d8%a7%d9%84%d9%8a/',
  //     'quantity': 11
  //   }
  // ];
  // translator.translateAndPrint(text.toString(),to: 'en');

  await CacheHelper.init();
  await EasyLocalization.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  token = CacheHelper.getData(key: 'token');
  print(token);


  // if(stringFavList != null || productList != null){
  //   // printWrapped(stringFavList!);
  //   // printWrapped(productList);
  //
  // }

  Widget widget;
  if (token != null) {
    widget = AppLayout();
  } else {
    widget = RegisterScreen();
  }

  runApp( EasyLocalization(
    path: 'assets/translations',
    supportedLocales: [
      Locale('ar'),
      Locale('en'),
    ],
    fallbackLocale: Locale('ar'),
    assetLoader: CodegenLoader(),
    startLocale: Locale('ar'),
    saveLocale: true,
    child: MyApp(
        appRouter: AppRouter(),
        startWidget: widget,
      ),
  ),
  );
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  final Widget startWidget;
  const MyApp({Key? key, required this.appRouter, required this.startWidget})
      : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => HomeCubit(ProductRepository(WebServices()))..createDatabase()
              ..getAllProducts()
              ..getAllCategories()),
        BlocProvider(create: (context) => FavoritesCubit()),
        // BlocProvider(
        //   create: (context) => SearchCubit(
        //     ProductRepository(ProductsWebServices())..g,
        //   ),
        // ),
      ],
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ScreenUtilInit(
            designSize: Size(411, 845),
            builder: () =>  MaterialApp(
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              // builder: DevicePreview.appBuilder,
              // locale: DevicePreview.locale(context),


              // builder: (context, child) => ResponsiveWrapper.builder(
              //   child,
              //   maxWidth: 1200,
              //   minWidth: 400,
              //   defaultScale: true,
              //   breakpoints: [
              //     ResponsiveBreakpoint.resize(400, name: MOBILE),
              //     ResponsiveBreakpoint.autoScale(800, name: TABLET),
              //     ResponsiveBreakpoint.resize(1000, name: DESKTOP),
              //     ResponsiveBreakpoint.autoScale(2460, name: '4K'),
              //   ],
              // ),
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: defColor,
                fontFamily: 'Almarai',
                textTheme:  TextTheme(

                ),
              ),
              onGenerateRoute: appRouter.generateRoute,
              home: startWidget,
            ),
          );
        },
      ),
    );
  }
}
