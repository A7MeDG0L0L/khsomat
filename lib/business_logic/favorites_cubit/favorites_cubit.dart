import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khsomat/business_logic/favorites_cubit/favorites_states.dart';
import 'package:sqflite/sqflite.dart';

class FavoritesCubit extends Cubit<FavoritesStates> {
  FavoritesCubit() : super(FavoritesInitialState());

  static FavoritesCubit get(context) => BlocProvider.of(context);

  late Database database;

  List<Map<dynamic, dynamic>> wishList = [];
  List<Map<dynamic, dynamic>> orderList = [];

  Future<void> createDatabase() async {
  database = await openDatabase(
      'wishlist.db',
      version: 1,
      onCreate: (database, version) {
        print('database Created Successfully !');
        database
            .execute(
                'CREATE TABLE wishlist (id INTEGER PRIMARY KEY, title TEXT, image TEXT, regularprice TEXT,saleprice TEXT,permalink TEXT)');
        database
            .execute(
            'CREATE TABLE orderlist (id INTEGER PRIMARY KEY, title TEXT, image TEXT, regularprice TEXT,saleprice TEXT,permalink TEXT)');

        print('table Created Successfully !');
        //     .catchError((error) {
        //   print('Error While Creating Table Wishlist : ${error.toString()}');
        // });
      },
      onOpen: (database) {
        getWishListDataFromDatabase(database);
        getOrderListDataFromDatabase(database);
        // print(productList);
        print('database Opened Successfully !');
      },
    );
     // database = value;
      print(wishList);

      emit(AppCreatedDatabaseState());

  }

  Future insertToDatabase({
    required int id,
    required String text,
    required String image,
    required String regularprice,
    required String saleprice,
    required String permalink,
  }) async {
    await database.transaction((txn) async {
      return await txn
          .rawInsert(
              'INSERT INTO wishlist(title,image,regularprice,saleprice,permalink) VALUES("$text","$image","$regularprice","$saleprice","$permalink")')
          .then((value) {
        print('$value inserted successfully');
        getWishListDataFromDatabase(database);
        print(wishList);
        emit(AppInsertedToDatabaseState());
      }).catchError((error) {
        print('Error When Inserting New Record ${error.toString()}');
      });
    });
  }

  Future insertToOrderListDatabase({
    required int id,
    required String text,
    required String image,
    required String regularprice,
    required String saleprice,
    required String permalink,
  }) async {
    await database.transaction((txn) async {
      return await txn
          .rawInsert(
          'INSERT INTO orderlist(title,image,regularprice,saleprice,permalink) VALUES("$text","$image","$regularprice","$saleprice","$permalink")')
          .then((value) {
        print('$value inserted successfully');
        getWishListDataFromDatabase(database);
        print(orderList);
        emit(AppInsertedToDatabaseState());
      }).catchError((error) {
        print('Error When Inserting New Record ${error.toString()}');
      });
    });
  }

  void getWishListDataFromDatabase(database) async {
    //productList = [];
    emit(AppGetWishListDatabaseLoadingState());

    await database.rawQuery('SELECT * FROM wishlist').then((value) {
      value.forEach((product) {
        wishList.add(product);
        print(wishList);
      });
      emit(GetWishListFromDataBaseState());
    });
  }

  void getOrderListDataFromDatabase(database) async {
    //productList = [];
    emit(AppGetOrderListDatabaseLoadingState());

    await database.rawQuery('SELECT * FROM orderlist').then((value) {
      value.forEach((product) {
        orderList.add(product);
        print(orderList);
      });
      emit(GetOrderListFromDataBaseState());
    });
  }

  void deleteItemWishListFromDatabase({
    required int id,
  }) async {

    await database
        .rawDelete('DELETE FROM wishlist WHERE id = ?', [id]).then((value) {
    //  getWishListDataFromDatabase(database);
      emit(DeleteWishListDataFromDatabaseState());
    });
  }


  void deleteItemOrderListFromDatabase({
    required int id,
  }) async {

    await database
        .rawDelete('DELETE FROM orderlist WHERE id = ?', [id]).then((value) {
      getWishListDataFromDatabase(database);
      emit(DeleteOrderListDataFromDatabaseState());
    });
  }

  int quantity=1;

  void increaseQuantity(){
    quantity++;
    emit(IncreaseQuantityState());
  }
  void decreaseQuantity(){
    if(quantity > 1)
      {
        quantity--;
      }
    emit(DecreaseQuantityState());
  }
}
