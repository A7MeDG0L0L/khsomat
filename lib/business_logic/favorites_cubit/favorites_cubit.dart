import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khsomat/business_logic/favorites_cubit/favorites_states.dart';
import 'package:khsomat/data/models/products_model.dart';
import 'package:sqflite/sqflite.dart';

class FavoritesCubit extends Cubit<FavoritesStates> {
  FavoritesCubit() : super(FavoritesInitialState());

  static FavoritesCubit get(context) => BlocProvider.of(context);


  List<Map>? productList = [];

   late Database database;



  void createDatabase()  {
    openDatabase(
      'wishlist.db',
      version: 1,
      onCreate: (database, version) {
        print('database Created Successfully !');
        database
            .execute(
                'CREATE TABLE wishlist (id INTEGER PRIMARY KEY, title TEXT, image TEXT, regularprice TEXT,saleprice TEXT, permalink TEXT)')
            .then((value) => print('table Created Successfully !'))
            .catchError((error) {
          print('Error While Creating Table Wishlist : ${error.toString()}');
        });
      },
      onOpen: (database) async {

       getDataFromDatabase(database);
      //  print(productList);
        print('database Opened Successfully !');
      },
    ).then((value) {
      database = value;

      print(productList);

      emit(AppCreatedDatabaseState());
    });
  }

   insertToDatabase({
    required int? id,
    required String? text,
    required String? image,
    required String? regularprice,
    required String? saleprice,
    required String? permalink,

  }) async {
    await database.transaction((txn)  {
      return  txn
          .rawInsert(
              'INSERT INTO wishlist(title,image,regularprice,saleprice,permalink) VALUES("$text","$image","$regularprice","$saleprice","$permalink")')
          .then((value) {
        print('$value inserted successfully');
        getDataFromDatabase(database);
        print(productList);
        emit(AppInsertedToDatabaseState());
      }).catchError((error) {
        print('Error When Inserting New Record ${error.toString()}');
      });
    });
  }

  void getDataFromDatabase(database)  {
     // productList = [];
    emit(AppGetDatabaseLoadingState());
      productList = database.rawQuery('SELECT * FROM wishlist').then((value) {
      value.forEach((product) {
        productList!.add(product);
      });
      emit(GetFromDataBaseState());
    });
  }

  void removeDataFromDatabase()async{
    await database.rawUpdate('DELETE * FROM wishlist').then((value) {
      getDataFromDatabase(database);
      emit(RemoveDataFromDatabase());
    });
  }
}
