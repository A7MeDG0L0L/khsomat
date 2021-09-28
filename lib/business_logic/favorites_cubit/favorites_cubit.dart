import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khsomat/business_logic/favorites_cubit/favorites_states.dart';
import 'package:khsomat/data/models/order_model.dart';
import 'package:khsomat/data/models/products_model.dart';
import 'package:khsomat/data/web_services/web_services.dart';
import 'package:sqflite/sqflite.dart';

class FavoritesCubit extends Cubit<FavoritesStates> {
  FavoritesCubit() : super(FavoritesInitialState());

  static FavoritesCubit get(context) => BlocProvider.of(context);

  late Database database;

  List<Map<dynamic, dynamic>> wishList = [];
  List<Map<dynamic, dynamic>> orderList = [];
  List<Map<dynamic, dynamic>> copyList = [];

  Future<void> createDatabase() async {
    database = await openDatabase(
      'wishlist.db',
      version: 1,
      onCreate: (database, version) {
        print('database Created Successfully !');
        database.execute(
            'CREATE TABLE wishlist (id INTEGER PRIMARY KEY, product_id INTEGER, name TEXT, image TEXT, regularprice TEXT,saleprice TEXT,permalink TEXT)');
        database.execute(
            'CREATE TABLE orderlist (id INTEGER PRIMARY KEY, product_id INTEGER, name TEXT, image TEXT, regularprice TEXT,saleprice TEXT,permalink TEXT,quantity INTEGER)');

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
    required int productId,
    required String text,
    required String image,
    required String regularprice,
    required String saleprice,
    required String permalink,
  }) async {
    await database.transaction((txn) async {
      return await txn
          .rawInsert(
              'INSERT INTO wishlist(product_id,name,image,regularprice,saleprice,permalink) VALUES("$productId","$text","$image","$regularprice","$saleprice","$permalink")')
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
    required String productName,
    required int productId,
    required String image,
    required String regularprice,
    required String saleprice,
    required String permalink,
    required int quantity,
  }) async {
    await database.transaction((txn) async {
      return await txn
          .rawInsert(
              'INSERT INTO orderlist(product_id,name,image,regularprice,saleprice,permalink,quantity) VALUES("$productId","$productName","$image","$regularprice","$saleprice","$permalink","$quantity")')
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
        //  orderList.add(product);
        orderList.add(Map.of(product));
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
      getWishListDataFromDatabase(database);
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

  void deleteAllItemsFromWishList() async {
    await database.rawDelete('DELETE FROM wishlist').then((value) {
      //  getWishListDataFromDatabase(database);
      emit(DeleteAllItemsFromWishlistState());
    });
  }

  Product? product;
  //
  // int quantity = product!.quantityLimit!;
  //var quantity2= database.rawQuery('SELECT quantity from orderlist');

  int quantity = 1;

  void increaseQuantity(index) async {
    // List<Map<dynamic, dynamic>> modifiedQuantity =
    //     await database.rawQuery('SELECT * FROM orderlist');
    //
    // Map<dynamic, dynamic> quantity = modifiedQuantity[index];
    // dynamic modifyQuantity = Map<dynamic, dynamic>.from(quantity);
    // modifyQuantity = (await database.rawUpdate(
    //     'UPDATE orderlist SET quantity = ${orderList[index][quantity]++} WHERE id = ${index + 1};'));
    // modifyQuantity['quantity']++;
    // print('$modifyQuantity and index : $index');
    // print(modifiedQuantity);

    //  var modifiedQuantity = orderList[index]['quantity'];
    // modifiedQuantity++;
    orderList[index]['quantity']++;
    print(orderList[index]['quantity']);
    emit(IncreaseQuantityState());
  }

  void decreaseQuantity(index) {
    if (orderList[index]['quantity'] > 1) {
      orderList[index]['quantity']--;
    }
    emit(DecreaseQuantityState());
  }

  OrderModel? orderModel;
  void createOrder({
    required String firstname,
    required String lastname,
    required String address,
    required String city,
    required String email,
    required String phone,
    required String customerNote,
    //  required List itemsList,
  }) {
    emit(CreatingOrderLoadingState());
    WebServices.dio.post(
      'wc/v3/orders',
      data: {
        "currency": "EGP",
        "billing": {
          "first_name": firstname,
          "last_name": lastname,
          "address_1": address,
          "city": city,
          "country": "Egypt",
          "email": email,
          "phone": phone
        },
        "shipping": {
          "first_name": firstname,
          "last_name": lastname,
          "address_1": address,
          "city": city,
          "country": "Egypt",
        },
        "payment_method": "cod",
        "customer_note": customerNote,
        "line_items": [
          {
            "name": "عوامة الفلامنجو",
            "product_id": 48079,
            "quantity":1
          }
        ]
      },
      queryParameters: {
        'Content-Type': "application/json",
        'consumer_key': 'ck_9eb0aa4e0a0bc07c15549d30051ee9ec90ef2710',
        'consumer_secret': 'cs_135d3231db48637c464000067a4606147eec301c'
      },
    ).then((value) {
      orderModel = OrderModel.fromJson(value.data);
      print(orderModel);

      ///TODO:....
      emit(CreatingOrderSuccessState());
    }).catchError((error) {
      print('error while creating order: $error');
      emit(CreatingOrderErrorState(error));
    });
  }
}
