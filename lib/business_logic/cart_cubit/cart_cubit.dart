import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khsomat/Shared/constants.dart';
import 'package:khsomat/data/models/customer_model.dart';
import 'package:khsomat/data/models/new_product_model.dart';
import 'package:khsomat/data/web_services/web_services.dart';

import 'cart_states.dart';

class CartCubit extends Cubit<CartStates>{
  CartCubit() : super(CartInitialState());

  static CartCubit get(context)=>BlocProvider.of(context);

void getOrderListDataFromDatabase(database) async {
  //productList = [];
  orderList=[];
  emit(AppGetOrderListDatabaseLoadingState());

  await database.rawQuery('SELECT * FROM orderlist').then((value) {
    value.forEach((product) {
      //  orderList.add(product);
      orderList.add(Map.of(product));
      print(orderList);
     //  printWrapped(orderList.toString());
    });
    emit(GetOrderListFromDataBaseState());
  });
}

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

    //  orderList[index]['quantity']++;
    var quantity = ++orderList[index]['quantity'];
    database.rawUpdate(
        'UPDATE orderlist SET quantity = $quantity WHERE id = ${index + 1};');
    print(orderList[index]['quantity']);
    print(orderList[index]);
    print(orderList);
    total=0;
    // print(orderList[1]);
    // print(orderList);
    emit(IncreaseQuantityState());
  }

  void decreaseQuantity(index) {
    if (orderList[index]['quantity'] > 1) {
      //orderList[index]['quantity']--;
      var quantity = --orderList[index]['quantity'];
      database.rawUpdate(
          'UPDATE orderlist SET quantity = $quantity WHERE id = ${index + 1};');
    }
    //  print(orderList);
    print(orderList[index]['quantity']);
    total=0;
    emit(DecreaseQuantityState());
  }

  void deleteItemOrderListFromDatabase({
    required int id,
  }) async {
    await database.rawDelete(
        'DELETE FROM orderlist WHERE product_id = ?', [id]).then((value) {
      getOrderListDataFromDatabase(database);
      emit(DeleteOrderListDataFromDatabaseState());
    });
  }

CustomerModel? customerModel;
  void retrieveCustomer() {
    emit(RetrieveCustomerByIDLoadingState());
    WebServices.dio.get(
      'wc/v3/customers/$id',
      queryParameters: {
        'Content-Type': "application/json",
        'consumer_key': 'ck_fa054c2eea7057ed605ce37417fe5e92fb2d428b',
        'consumer_secret': 'cs_a2bcff0feec2d96d830b08ecf93015f6de9b409e'
      },
    ).then((value) {
      customerModel=CustomerModel.fromJson(value.data);
      print(value.data);
      print(value.statusCode);

      emit(RetrieveCustomerByIDSuccessState(customerModel!));
    }).catchError((error) {
      print(error.toString());
      emit(RetrieveCustomerByIDErrorState(error,customerModel!));
    });
  }


}