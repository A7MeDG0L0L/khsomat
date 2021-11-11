import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khsomat/Shared/components.dart';
import 'package:khsomat/business_logic/search_cubit/search_cubit.dart';
import 'package:khsomat/business_logic/search_cubit/search_states.dart';
import 'package:khsomat/data/models/products_model.dart';
import 'package:khsomat/data/repository/products_repository.dart';
import 'package:khsomat/data/web_services/web_services.dart';
import 'package:khsomat/presentation/UI/Widgets/product_item.dart';
import 'package:khsomat/translations/locale_keys.g.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var searchController = TextEditingController();
    late List<Product> searchedProducts;

    return BlocProvider(
      create: (BuildContext context) => SearchCubit(ProductRepository(WebServices())),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          if(state is SearchSuccessState){
            searchedProducts = state.searchProduct;
          }
          return Scaffold(
            appBar: AppBar(
              title:Text(LocaleKeys.search_for_products.tr(),style: TextStyle(fontSize: 20.sp),),
            ),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(height: 15.h,),
                    TextFormField(
                      controller: searchController,
                      keyboardType: TextInputType.text,
                      onFieldSubmitted: (String searchText){
                        if(formKey.currentState!.validate()){
                        SearchCubit.get(context).getAllSearchProducts(searchText);
                        }
                      },
                      // onChanged: (String searchText){
                      //   SearchCubit.get(context).getAllSearchProducts(searchText);
                      // },
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'إدخل كلمة للبحث عنها';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        label: Text(LocaleKeys.search.tr(),style: TextStyle(fontSize: 20.sp),),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0.h,
                    ),
                    if (state is SearchLoadingState) LinearProgressIndicator(),
                    SizedBox(
                      height: 10.0.h,
                    ),
                    if (state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) => ProductItem(product: searchedProducts[index] ),
                          separatorBuilder: (context, index) => Container(height: 1.h,
                          color: Colors.grey,),
                          itemCount:
                          searchedProducts.length,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
