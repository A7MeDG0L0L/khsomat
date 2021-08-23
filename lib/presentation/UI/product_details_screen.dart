import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khsomat/Shared/my_colors.dart';
import 'package:khsomat/business_logic/home_cubit/home_cubit.dart';
import 'package:khsomat/business_logic/home_cubit/home_state.dart';
import 'package:khsomat/data/models/products_model.dart';
import 'package:html/parser.dart' show parse;


class ProductDetailsScreen extends StatelessWidget {
  final Product product;
  const ProductDetailsScreen({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              buildSliverAppBar(),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: TextStyle(
                                fontFamily: 'Almarai',
                                fontSize: 24,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: <Widget>[

                                if (product.prices.salePrice.length == 4)
                                  Text(
                                    product.prices.salePrice.substring(0, 2)
                                    /*'${product.price.round()}'*/,
                                    style: TextStyle(
                                      fontFamily: 'Almarai',
                                      fontSize: 20.0,
                                      color: defColor,
                                    ),
                                  ),
                                if (product.prices.salePrice.length == 5)
                                  Text(
                                    product.prices.salePrice.substring(0, 3)
                                    /*'${product.price.round()}'*/,
                                    style: TextStyle(
                                      fontFamily: 'Almarai',
                                      fontSize: 20.0,
                                      color: defColor,
                                    ),
                                  ),
                                if (product.prices.salePrice.length == 6)
                                  Text(
                                    product.prices.salePrice.substring(0, 4)
                                    /*'${product.price.round()}'*/,
                                    style: TextStyle(
                                      fontFamily: 'Almarai',
                                      fontSize: 20.0,
                                      color: defColor,
                                    ),
                                  ),
                                if (product.prices.salePrice.length == 7)
                                  Text(
                                    product.prices.salePrice.substring(0, 5)
                                    /*'${product.price.round()}'*/,
                                    style: TextStyle(
                                      fontFamily: 'Almarai',
                                      fontSize: 20.0,
                                      color: defColor,
                                    ),
                                  ),
                                Text(
                                  'جنية مصري',
                                  style: TextStyle(
                                    fontFamily: 'Almarai',
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                if (product.onSale == true &&
                                    product.prices.regularPrice !=
                                        product.prices.salePrice &&
                                    product.prices.regularPrice.length == 4)
                                  Text(
                                    product.prices.regularPrice.substring(0, 2)
                                    /* '${product.oldPrice.round()}'*/,
                                    style: TextStyle(
                                      fontFamily: 'Almarai',
                                      fontSize: 18.0,
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                if (product.onSale == true &&
                                    product.prices.regularPrice !=
                                        product.prices.salePrice &&
                                    product.prices.regularPrice.length == 5)
                                  Text(
                                    product.prices.regularPrice.substring(0, 3)
                                    /* '${product.oldPrice.round()}'*/,
                                    style: TextStyle(
                                      fontFamily: 'Almarai',
                                      fontSize: 18.0,
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                if (product.onSale == true &&
                                    product.prices.regularPrice !=
                                        product.prices.salePrice &&
                                    product.prices.regularPrice.length == 6)
                                  Text(
                                    product.prices.regularPrice.substring(0, 4)
                                    /* '${product.oldPrice.round()}'*/,
                                    style: TextStyle(
                                      fontFamily: 'Almarai',
                                      fontSize: 18.0,
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                if (product.onSale == true &&
                                    product.prices.regularPrice !=
                                        product.prices.salePrice &&
                                    product.prices.regularPrice.length == 7)
                                  Text(
                                    product.prices.regularPrice.substring(0, 5)
                                    /* '${product.oldPrice.round()}'*/,
                                    style: TextStyle(
                                      fontFamily: 'Almarai',
                                      fontSize: 18.0,
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                              ],
                            ),
                            SizedBox(height: 30,),
                            SizedBox(height: 20,),
                            Text(
                              'وصف المنتج',
                              style: TextStyle(fontFamily: 'Almarai',fontSize: 18),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),
                            parseHtmlDescription(),

                            Container(width: double.infinity , height: 70 ,child: RaisedButton(onPressed: (){},child: Text('إضافة في السلة'),color: defColor,)),

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 400,
      pinned: true,
      stretch: true,
      backgroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          product.name,
          style: TextStyle(color: Colors.amber),
        ),
        background: Hero(
          tag: product.id,
          child: Image.network(
            product.images[0].src,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget parseHtmlDescription(){
    var document= parse(product.description);
    String parsedString = parse(document.body!.text).documentElement!.text;
    print(parsedString);
    return Text(parsedString,style: TextStyle(fontFamily: 'Almarai',
    fontSize: 15),);
  }
}
