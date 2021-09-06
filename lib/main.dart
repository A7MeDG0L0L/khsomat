import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khsomat/Shared/my_colors.dart';
import 'package:khsomat/business_logic/home_cubit/home_cubit.dart';
import 'package:khsomat/business_logic/home_cubit/home_state.dart';
import 'package:khsomat/data/repository/products_repository.dart';
import 'package:khsomat/data/web_services/web_services.dart';
import 'package:khsomat/presentation/UI/app_layout.dart';
import 'package:khsomat/presentation/UI/register_screen.dart';

import 'BlocObserver.dart';
import 'Shared/constants.dart';
import 'app_router.dart';
import 'business_logic/search_cubit/search_cubit.dart';
import 'data/cache_helper/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();

  Bloc.observer = MyBlocObserver();
  token = CacheHelper.getData(key: 'token');
  print(token);
  // print(stringFavList);
  //print(productList);

  Widget widget;
  if (token != null) {
    widget = AppLayout();
  } else {
    widget = RegisterScreen();
  }

  runApp(MyApp(
    appRouter: AppRouter(),
    startWidget: widget,
  ));
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
            create: (context) =>
                HomeCubit(ProductRepository(ProductsWebServices()))
                  ..getAllProducts()
                  ..getAllCategories()),
        // BlocProvider(
        //   create: (context) => SearchCubit(
        //     ProductRepository(ProductsWebServices())..g,
        //   ),
        // ),
      ],
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: defColor,
              fontFamily: 'Almarai',
            ),
            onGenerateRoute: appRouter.generateRoute,
            home: Directionality(
                textDirection: TextDirection.rtl, child: startWidget),
          );
        },
      ),
    );
  }
}
