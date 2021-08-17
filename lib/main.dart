import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khsomat/Shared/my_colors.dart';
import 'package:khsomat/business_logic/home_cubit/home_cubit.dart';
import 'package:khsomat/business_logic/home_cubit/home_state.dart';
import 'package:khsomat/data/repository/products_repository.dart';
import 'package:khsomat/data/web_services/products_web_services.dart';
import 'package:khsomat/presentation/UI/app_layout.dart';

import 'BlocObserver.dart';


void main() {
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeCubit(ProductRepository(ProductsWebServices()))..getAllProducts(),),
      ],
      child: BlocConsumer<HomeCubit,HomeStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          return  MaterialApp(
            debugShowCheckedModeBanner: false,

            theme: ThemeData(
              primarySwatch: defColor,

            ),
            home:Directionality(
              textDirection: TextDirection.rtl,
              child: AppLayout(),),
          );
        },

      ),
    );
  }
}
