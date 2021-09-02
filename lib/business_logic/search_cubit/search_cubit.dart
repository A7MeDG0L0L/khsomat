import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khsomat/business_logic/search_cubit/search_states.dart';
import 'package:khsomat/data/models/products_model.dart';
import 'package:khsomat/data/repository/products_repository.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit(this.productRepository) : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);
  final ProductRepository productRepository;


  List<Product> searchProducts = [];

  List<Product>? getAllSearchProducts(String searchText) {
    emit(SearchLoadingState());
    productRepository.getAllSearchProducts(searchText).then((product) {
      searchProducts = product;
      print(searchProducts);
      emit(SearchSuccessState(product));
    }).catchError((error) {
      print('Cubit Error : ${error.toString()}');
      emit(SearchErrorState(error));
    });
    return searchProducts;
  }


//   Product? model;
//
//   void search(String text) {
//     emit(SearchLoadingState());
//
//     DioHelper.postData(
//       url: SEARCH,
//       token: token,
//       data: {
//         'text': text,
//       },
//     ).then((value)
//     {
//       model = SearchModel.fromJson(value.data);
//
//       emit(SearchSuccessState());
//     }).catchError((error)
//     {
//       print(error.toString());
//       emit(SearchErrorState());
//     });
//   }
// }


}