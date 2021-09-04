import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khsomat/Shared/components.dart';
import 'package:khsomat/business_logic/search_cubit/search_cubit.dart';
import 'package:khsomat/business_logic/search_cubit/search_states.dart';
import 'package:khsomat/data/models/products_model.dart';
import 'package:khsomat/data/repository/products_repository.dart';
import 'package:khsomat/data/web_services/web_services.dart';
import 'package:khsomat/presentation/UI/Widgets/product_item.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var searchController = TextEditingController();
    late List<Product> searchedProducts;

    return BlocProvider(
      create: (BuildContext context) => SearchCubit(ProductRepository(ProductsWebServices())),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          if(state is SearchSuccessState){
            searchedProducts = state.searchProduct;
          }
          return Scaffold(
            appBar: AppBar(
              title:Text('أبحث عن المنتجات'),
            ),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultFormField(
                      controller: searchController,
                      type: TextInputType.text,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'enter text to search';
                        }

                        return null;
                      },
                      onSubmit: (String searchText) {
                        SearchCubit.get(context).getAllSearchProducts(searchText);
                      },
                      label: 'Search',
                      prefix: Icons.search,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    if (state is SearchLoadingState) LinearProgressIndicator(),
                    SizedBox(
                      height: 10.0,
                    ),
                    if (state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) => ProductItem(product: searchedProducts[index] ),
                          separatorBuilder: (context, index) => Container(height: 1,
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
