import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khsomat/Shared/constants.dart';
import 'package:khsomat/business_logic/favorites_cubit/favorites_states.dart';
import 'package:khsomat/data/cache_helper/cache_helper.dart';
import 'package:khsomat/data/models/new_product_model.dart';
import 'package:khsomat/data/models/order_model.dart';
import 'package:khsomat/data/models/products_model.dart';
import 'package:khsomat/data/web_services/web_services.dart';
import 'package:sqflite/sqflite.dart';

class FavoritesCubit extends Cubit<FavoritesStates> {
  FavoritesCubit() : super(FavoritesInitialState());

  static FavoritesCubit get(context) => BlocProvider.of(context);

 // late Database database;
  // late List list;

  // void checkItems(){
  //   // if(wishList.isNotEmpty&&wishList.length>=1) {
  //   //   emit(ReturnNumberWishListState());
  //   //   return wishList.length;
  //   // }
  //   emit(ReturnNumberWishList2State());
  // }


  // List<Map<dynamic, dynamic>> wishList = [];
  // List<Map<dynamic, dynamic>> orderList = [];

  // Future<void> createDatabase() async {
  //   database = await openDatabase(
  //     'wishlist.db',
  //     version: 1,
  //     onCreate: (database, version) {
  //       print('database Created Successfully !');
  //       database.execute(
  //           'CREATE TABLE wishlist (product_id INTEGER, name TEXT, image TEXT, regularprice INTEGER,saleprice INTEGER,permalink TEXT)');
  //       database.execute(
  //           'CREATE TABLE orderlist (id INTEGER PRIMARY KEY,"product_id" INTEGER, "name" TEXT, "image" TEXT, "regularprice" INTEGER,"saleprice" INTEGER,"permalink" TEXT,"quantity" INTEGER,"variation_id" INTEGER)');
  //
  //       print('table Created Successfully !');
  //       //     .catchError((error) {
  //       //   print('Error While Creating Table Wishlist : ${error.toString()}');
  //       // });
  //     },
  //     onOpen: (database) {
  //       getWishListDataFromDatabase(database);
  //       getOrderListDataFromDatabase(database);
  //       // print(productList);
  //       print('database Opened Successfully !');
  //     },
  //   );
  //   // database = value;
  //   print(wishList);
  //
  //   emit(AppCreatedDatabaseState());
  // }

  List<NewProductModel> newProducts = [];

  void getProducts(List<int> ids){
       emit(GetNewProductsLoadingState());
       WebServices.dio.get('/wc/store/products').then((value) {
         newProducts=value.data;
         print(newProducts);
         emit(GetNewProductsSuccessState(newProducts));
       }).catchError((error){
        print(error.toString());
        emit(GetNewProductsErrorState(error));
       });
     }

  Future insertToDatabase({
    required int productId,
    required String text,
    required String image,
    required int regularprice,
    required int saleprice,
    required String permalink,
  }) async {
    await database.transaction((txn) async {
      return await txn
          .rawInsert(
              'INSERT INTO wishlist("product_id","name","image","regularprice","saleprice","permalink") VALUES("$productId","$text","$image","$regularprice","$saleprice","$permalink")')
          .then((value) {
        print('$value inserted successfully');
        getWishListDataFromDatabase(database);
        print(wishList);
        // checkItems();
        emit(AppInsertedToDatabaseState());
      }).catchError((error) {
        print('Error When Inserting New Record ${error.toString()}');
      });
    });
  }

  Future insertToOrderListDatabase({
    required String productName,
    required int productId,
    required String image,
    required int regularprice,
    required int saleprice,
    required String permalink,
    required int quantity,
    int? variationId,
  }) async {
    await database.transaction((txn) async {
      return await txn
          .rawInsert(
              'INSERT INTO orderlist(product_id,name,image,regularprice,saleprice,permalink,quantity,variation_id) VALUES("$productId","$productName","$image","$regularprice","$saleprice","$permalink","$quantity","$variationId")')
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
    wishList=[];
    emit(AppGetWishListDatabaseLoadingState());

    await database.rawQuery('SELECT * FROM wishlist').then((value) {
      value.forEach((product) {
        wishList.add(product);
        // checkItems();
        print(wishList);
      });
      emit(GetWishListFromDataBaseState());
    });
  }

  // void getOrderListDataFromDatabase(database) async {
  //   //productList = [];
  //   emit(AppGetOrderListDatabaseLoadingState());
  //
  //   await database.rawQuery('SELECT * FROM orderlist').then((value) {
  //     value.forEach((product) {
  //       //  orderList.add(product);
  //       orderList.add(Map.of(product));
  //       print(orderList);
  //     });
  //     emit(GetOrderListFromDataBaseState());
  //   });
  // }

  void deleteItemWishListFromDatabase({
    required int id,
  }) async {
    await database.rawDelete(
        'DELETE FROM wishlist WHERE product_id = ?', [id]).then((value) {
      getWishListDataFromDatabase(database);
      // checkItems();
      emit(DeleteWishListDataFromDatabaseState());
    });
  }

  // void deleteItemOrderListFromDatabase({
  //   required int id,
  // }) async {
  //   await database.rawDelete(
  //       'DELETE FROM orderlist WHERE product_id = ?', [id]).then((value) {
  //     getWishListDataFromDatabase(database);
  //     emit(DeleteOrderListDataFromDatabaseState());
  //   });
  // }

  void deleteAllItemsFromWishList() async {
    await database.rawDelete('DELETE FROM wishlist').then((value) {
      //  getWishListDataFromDatabase(database);
      emit(DeleteAllItemsFromWishlistState());
    });
  }

  void deleteAllItemsFromOrderList() async {
    await database.rawDelete('DELETE FROM orderlist');
    emit(DeleteAllItemsFromOrderlistState());

    // await database.rawDelete('DELETE FROM orderlist').then((value) {
    //   //  getWishListDataFromDatabase(database);
    //   emit(DeleteAllItemsFromOrderlistState());
    // });
  }

  Product? product;
  //
  // int quantity = product!.quantityLimit!;
  //var quantity2= database.rawQuery('SELECT quantity from orderlist');

  int quantity = 1;

  // void increaseQuantity(index) async {
  //   // List<Map<dynamic, dynamic>> modifiedQuantity =
  //   //     await database.rawQuery('SELECT * FROM orderlist');
  //   //
  //   // Map<dynamic, dynamic> quantity = modifiedQuantity[index];
  //   // dynamic modifyQuantity = Map<dynamic, dynamic>.from(quantity);
  //   // modifyQuantity = (await database.rawUpdate(
  //   //     'UPDATE orderlist SET quantity = ${orderList[index][quantity]++} WHERE id = ${index + 1};'));
  //   // modifyQuantity['quantity']++;
  //   // print('$modifyQuantity and index : $index');
  //   // print(modifiedQuantity);
  //
  //   //  var modifiedQuantity = orderList[index]['quantity'];
  //   // modifiedQuantity++;
  //
  //   //  orderList[index]['quantity']++;
  //   var quantity = ++orderList[index]['quantity'];
  //   database.rawUpdate(
  //       'UPDATE orderlist SET quantity = $quantity WHERE id = ${index + 1};');
  //   print(orderList[index]['quantity']);
  //   total=0;
  //   // print(orderList[1]);
  //   // print(orderList);
  //   emit(IncreaseQuantityState());
  // }
  //
  // void decreaseQuantity(index) {
  //   if (orderList[index]['quantity'] > 1) {
  //     //orderList[index]['quantity']--;
  //     var quantity = --orderList[index]['quantity'];
  //     database.rawUpdate(
  //         'UPDATE orderlist SET quantity = $quantity WHERE id = ${index + 1};');
  //   }
  //   //  print(orderList);
  //   print(orderList[index]['quantity']);
  //   total=0;
  //   emit(DecreaseQuantityState());
  // }

  bool checkItemWishList(int? productId) {
    for(var element in wishList) {
      if (element['product_id'] == productId) {
        print('Item already in the wishList');
        return true;
      }
    }
    return false;
  }




  bool checkItemOrderList(int? productId) {
    for(var element in orderList) {
      if (element['product_id'] == productId) {
        print('Item already in the orderList');
        return true;
      }
    }
    return false;
  }

  dynamic orderListToJson() async {
   // await createDatabase();

    List<Map<dynamic, dynamic>> copyList =
        await database.rawQuery('SELECT * FROM orderlist');
    copyList.forEach((element) {
      element.remove('id');
    });
    json.encode(copyList);
    print(json.encode(copyList));
    //getOrderListDataFromDatabase(database);
    //print(orderList);
    //  dynamic copyList = json.encode(orderList);
    // dynamic dynamicList = copyList;
    //print(dynamicList);
    return json.encode(copyList);
  }



  Future<dynamic> copyList() async {
    //await createDatabase();
    // getOrderListDataFromDatabase(database);
    // getOrderListDataFromDatabase(database);
    // print('CO$orderList');
    // print('Create Order Print for encoding orderList${json.encode(orderList)}');
    // List<Map<dynamic, dynamic>> copyList = [
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

    //await createDatabase();
    List<Map<dynamic, dynamic>> copyList =
        await database.rawQuery('SELECT * FROM orderlist');
    //copyList = await database.rawQuery('ALTER TABLE orderlist DROP id;');
    print('this is copylist before encoding it : $copyList');

    var encodedList = json.encode(copyList);
    List list = json.decode(encodedList);

    list.forEach((element) {
      element.remove('id');
    });
    print(list);
    return list;
  }

  dynamic total=0;
  int totalPrice()   {

    // await createDatabase();
    //  List<Map<dynamic, dynamic>> copyList =
    //      await database.rawQuery('SELECT * FROM orderlist');
    // dynamic list=copyList();
   //  print("total price copyList #####>> :  ${copyList}");
//dynamic list=copyList();
  total=0;
    for(int i=0 ; orderList.length>i;i++){
     total += (orderList[i]['quantity']*orderList[i]['saleprice']);
    print(total);
  }
    CacheHelper.saveData(key: 'total', value: total);
    print(total);
    return total;

  //   orderList.forEach((element) {
  //     total += (element['quantity'])*(element['saleprice']);
  //   });
  //   print(total);
  //   return total;
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

    //  required dynamic itemsList,
  }) async {
    emit(CreatingOrderLoadingState());
   // await createDatabase();
    // getOrderListDataFromDatabase(database);
    // print('CO$orderList');
    // print('Create Order Print for encoding orderList${json.encode(orderList)}');
    // List<Map<dynamic, dynamic>> copyList = [
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
    List<Map<dynamic, dynamic>> copyList =
        await database.rawQuery('SELECT * FROM orderlist');
    //copyList = await database.rawQuery('ALTER TABLE orderlist DROP id;');
    print('this is copylist before encoding it : $copyList');

    var encodedList = json.encode(copyList);
    List list = json.decode(encodedList);

    list.forEach((element) {
      element.remove('id');
    });

    print(list);
    WebServices.dio.post(
      'wc/v3/orders',
      data: {
        "customer_id":id,
        "parent_id":0,
       // "total": totalPrice(),
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
        "payment_method_title": "الدفع نقدًا عند الإستلام",
        "customer_note": customerNote,
        "line_items": list
        // "line_items": [
        //   {
        //     "name": "عوامة الفلامنجو",
        //     "product_id": 48079,
        //     "quantity":1
        //   }
        // ]
      },
      queryParameters: {
        'Content-Type': "application/json",
        'consumer_key': 'ck_fa054c2eea7057ed605ce37417fe5e92fb2d428b',
        'consumer_secret': 'cs_a2bcff0feec2d96d830b08ecf93015f6de9b409e'
      },
    ).then((value) {
      orderModel = OrderModel.fromJson(value.data);
      print(value.data);
      print(orderModel);

      ///TODO:....
      emit(CreatingOrderSuccessState());
    }).catchError((error) {
      print('error while creating order: $error');
      emit(CreatingOrderErrorState(error));
    });
  }
}
