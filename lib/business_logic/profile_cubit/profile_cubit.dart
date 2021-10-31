import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khsomat/Shared/constants.dart';
import 'package:khsomat/business_logic/profile_cubit/profile_states.dart';
import 'package:khsomat/data/models/order_model.dart';
import 'package:khsomat/data/repository/products_repository.dart';
import 'package:khsomat/data/web_services/web_services.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit(this.productRepository) : super(ProfileInitialState());
  final ProductRepository productRepository;


  static ProfileCubit get(context) => BlocProvider.of(context);

// OrderModel? orderModel;
//   void retrieveCustomerOrders() {
//     emit(RetrieveCustomerOrdersLoadingState());
//     WebServices.dio.get(
//       'wc/v3/orders',
//       queryParameters: {
//         'customer':309,
//         'Content-Type': "application/json",
//         'consumer_key': 'ck_fa054c2eea7057ed605ce37417fe5e92fb2d428b',
//         'consumer_secret': 'cs_a2bcff0feec2d96d830b08ecf93015f6de9b409e'
//       },
//     ).then((value) {
//       orderModel=OrderModel.fromJson(value.data);
//       print(value.data);
//       print(value.statusCode);
//
//       emit(RetrieveCustomerOrdersSuccessState());
//     }).catchError((error) {
//       print(error.toString());
//       emit(RetrieveCustomerOrdersErrorState(error));
//     });
//   }
// }


  List<OrderModel> orders = [];

  List<OrderModel>? getCustomerOrders() {
    emit(RetrieveCustomerOrdersLoadingState());
    productRepository.retrieveCustomerOrders().then((order) {
      orders = order;
      // print(products);
      emit(RetrieveCustomerOrdersSuccessState(order));
    }).catchError((error) {
      print('Cubit Error : ${error.toString()}');
      emit(RetrieveCustomerOrdersErrorState(error));
    });
    return orders;
  }
}