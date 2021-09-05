import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khsomat/business_logic/favorites_cubit/favorites_states.dart';

class FavoritesCubit extends Cubit <FavoritesStates>{
   FavoritesCubit():super(FavoritesInitialState());

   static FavoritesCubit get(context) => BlocProvider.of(context);


}