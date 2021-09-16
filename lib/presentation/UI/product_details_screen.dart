import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khsomat/Shared/my_colors.dart';
import 'package:khsomat/business_logic/favorites_cubit/favorites_cubit.dart';
import 'package:khsomat/business_logic/favorites_cubit/favorites_states.dart';
import 'package:khsomat/business_logic/home_cubit/home_cubit.dart';
import 'package:khsomat/business_logic/home_cubit/home_state.dart';
import 'package:khsomat/data/models/products_model.dart';
import 'package:html/parser.dart' show parse;
import 'package:share/share.dart';

class ProductDetailsScreen extends StatelessWidget {
  Product? product;
  ProductDetailsScreen({this.product});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoritesCubit, FavoritesStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.teal.shade500,
            title: Text(
              product!.name ?? 'name',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Almarai',
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            foregroundColor: Colors.white,
          ),
          body: CustomScrollView(
            slivers: [
              //carouselProductImage(),
              // buildSliverAppBar(),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    carouselProductImages(),
                    // carouselProductImage(),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product!.name ?? 'name',
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
                                if (product!.prices!.salePrice!.length == 4)
                                  Text(
                                    product!.prices!.salePrice!.substring(
                                        0, 2) /*'${product!.price.round()}'*/,
                                    style: TextStyle(
                                      fontFamily: 'Almarai',
                                      fontSize: 20.0,
                                      color: defColor,
                                    ),
                                  ),
                                if (product!.prices!.salePrice!.length == 5)
                                  Text(
                                    product!.prices!.salePrice!.substring(
                                        0, 3) /*'${product!.price.round()}'*/,
                                    style: TextStyle(
                                      fontFamily: 'Almarai',
                                      fontSize: 20.0,
                                      color: defColor,
                                    ),
                                  ),
                                if (product!.prices!.salePrice!.length == 6)
                                  Text(
                                    product!.prices!.salePrice!.substring(
                                        0, 4) /*'${product!.price.round()}'*/,
                                    style: TextStyle(
                                      fontFamily: 'Almarai',
                                      fontSize: 20.0,
                                      color: defColor,
                                    ),
                                  ),
                                if (product!.prices!.salePrice!.length == 7)
                                  Text(
                                    product!.prices!.salePrice!.substring(
                                        0, 5) /*'${product!.price.round()}'*/,
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
                                Text(
                                  'بدلاً من',
                                  style: TextStyle(
                                    fontFamily: 'Almarai',
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                if (product!.onSale == true &&
                                    product!.prices!.regularPrice !=
                                        product!.prices!.salePrice &&
                                    product!.prices!.regularPrice!.length == 4)
                                  Text(
                                    product!.prices!.regularPrice!.substring(0,
                                        2) /* '${product!.oldPrice.round()}'*/,
                                    style: TextStyle(
                                      fontFamily: 'Almarai',
                                      fontSize: 18.0,
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                if (product!.onSale == true &&
                                    product!.prices!.regularPrice !=
                                        product!.prices!.salePrice &&
                                    product!.prices!.regularPrice!.length == 5)
                                  Text(
                                    product!.prices!.regularPrice!.substring(0,
                                        3) /* '${product!.oldPrice.round()}'*/,
                                    style: TextStyle(
                                      fontFamily: 'Almarai',
                                      fontSize: 18.0,
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                if (product!.onSale == true &&
                                    product!.prices!.regularPrice !=
                                        product!.prices!.salePrice &&
                                    product!.prices!.regularPrice!.length == 6)
                                  Text(
                                    product!.prices!.regularPrice!.substring(0,
                                        4) /* '${product!.oldPrice.round()}'*/,
                                    style: TextStyle(
                                      fontFamily: 'Almarai',
                                      fontSize: 18.0,
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                if (product!.onSale == true &&
                                    product!.prices!.regularPrice !=
                                        product!.prices!.salePrice &&
                                    product!.prices!.regularPrice!.length == 7)
                                  Text(
                                    product!.prices!.regularPrice!.substring(0,
                                        5) /* '${product!.oldPrice.round()}'*/,
                                    style: TextStyle(
                                      fontFamily: 'Almarai',
                                      fontSize: 18.0,
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                Spacer(),
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.grey[600],
                                  child: IconButton(
                                    onPressed: () {
                                      Share.share(
                                          ' شاهد هذا المنتج علي خصومات دوت كوم :${product!.permalink!}  ');
                                    },
                                    icon: Icon(
                                      Icons.share,
                                      color: Colors.amber,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'وصف المنتج',
                              style: TextStyle(
                                  fontFamily: 'Almarai', fontSize: 18),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            parseHtmlDescription(),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 250,
                          height: 65,
                          decoration: BoxDecoration(
                            color: Colors.teal.shade500,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_shopping_cart_outlined,
                                color: Colors.white,
                              ),
                              TextButton(
                                onPressed: () {
                                  FavoritesCubit.get(context)
                                      .insertToOrderListDatabase(
                                          id: product!.id!,
                                          text: product!.name!,
                                          image: product!.images![0].src!,
                                          regularprice:
                                              product!.prices!.regularPrice!,
                                          saleprice:
                                              product!.prices!.salePrice!,
                                          permalink: product!.permalink!);
                                },
                                style: ButtonStyle(
                                  overlayColor:
                                      MaterialStateProperty.all(Colors.black),
                                ),
                                child: Text(
                                  'إضافة إلي السلة',
                                  style: TextStyle(
                                      fontFamily: 'Almarai',
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
        background: Hero(
          tag: product!.id!,
          child: Image.network(
            product!.images![0].src!,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget parseHtmlDescription() {
    var document = parse(product!.description);
    String parsedString = parse(document.body!.text).documentElement!.text;
    print(parsedString);
    return Text(
      parsedString,
      style: TextStyle(fontFamily: 'Almarai', fontSize: 15),
    );
  }

  // Widget carouselProductImage() {
  //   return CarouselSlider(
  //     items: [
  //       if(product!.images.length >= 1)
  //       Image(image: NetworkImage(product!.images[0].src),),
  //       if(product!.images.length >= 2)
  //       Image(image: NetworkImage(product!.images[1].src),),
  //       if(product!.images.length >= 3)
  //       Image(image: NetworkImage(product!.images[2].src),),
  //       if(product!.images.length >= 4 )
  //         Image(image: NetworkImage(product!.images[3].src),),
  //       if(product!.images.length >= 5 )
  //         Image(image: NetworkImage(product!.images[4].src),),
  //       if(product!.images.length >= 6 )
  //         Image(image: NetworkImage(product!.images[5].src),),
  //       if(product!.images.length >= 7 )
  //         Image(image: NetworkImage(product!.images[6].src),),
  //       if(product!.images.length >= 8 )
  //         Image(image: NetworkImage(product!.images[7].src),),
  //       if(product!.images.length >= 9 )
  //         Image(image: NetworkImage(product!.images[8].src),),
  //       if(product!.images.length >= 10 )
  //         Image(image: NetworkImage(product!.images[9].src),),
  //     ],
  //     options: CarouselOptions(
  //       height: 250.0,
  //       initialPage: 0,
  //       viewportFraction: 1.0,
  //       enableInfiniteScroll: true,
  //       reverse: false,
  //       autoPlay: true,
  //       autoPlayInterval: Duration(seconds: 3),
  //       autoPlayAnimationDuration: Duration(seconds: 1),
  //       autoPlayCurve: Curves.fastOutSlowIn,
  //       scrollDirection: Axis.horizontal,
  //     ),
  //   );
  // }

  Widget carouselProductImages() {
    return CarouselSlider.builder(
        itemCount: product!.images!.length,
        itemBuilder: (context, index, realIndex) =>
            Image.network(product!.images![index].src!),
        options: CarouselOptions(
          initialPage: 0,
          autoPlay: true,
          height: 400,
          autoPlayCurve: Curves.fastOutSlowIn,
          scrollDirection: Axis.horizontal,
          reverse: false,
          pageSnapping: true,
          viewportFraction: 1.0,
          pauseAutoPlayOnTouch: true,
        ));
  }

  // Widget calculateDiscountPer(){
  //
  //  var discount = 100*(product!.prices.regularPrice - product!.prices.salePrice) /  product!.prices.regularPrice;
  //   return Text();
  // }
}
