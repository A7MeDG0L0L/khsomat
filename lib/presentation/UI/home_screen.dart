import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:khsomat/Shared/my_colors.dart';
import 'package:khsomat/business_logic/home_cubit/home_cubit.dart';
import 'package:khsomat/business_logic/home_cubit/home_state.dart';
import 'package:khsomat/data/models/products_model.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatelessWidget {
  List<Widget> carouselItems = [
    Image(
      image: AssetImage('assets/images/test3.jpg'),
    ),
    Image(
      image: AssetImage('assets/images/bannertest.jpg'),
    ),
    Image(
      image: AssetImage('assets/images/bannertest2.jpg'),
    ),
    Image(
      image: AssetImage('assets/images/test.jpg'),
    ),
    Image(
      image: AssetImage('assets/images/test2.jpg'),
    ),
  ];

  List<Widget> productItems = [
    Image(
      image: AssetImage('assets/images/testproduct.jpg'),
    ),
    Image(
      image: AssetImage('assets/images/testproduct.jpg'),
    ),
    Image(
      image: AssetImage('assets/images/testproduct.jpg'),
    ),
    Image(
      image: AssetImage('assets/images/testproduct.jpg'),
    ),
  ];

  late List<Product>?allProducts;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if(state is GetProductsSuccessState) {
          allProducts = state.products;
          return builderWidget(context);
        }else{
          return loadingIndicator();
        }
      },
    );
  }

//Conditional.single(context: context,
//         conditionBuilder: (context) => HomeCubit.get(context).products== null ,
//         widgetBuilder: (context) => builderWidget(context),
//         fallbackBuilder: (context) => Center(
//           child: Container(
//               height: 150,
//               width: 200,
//               child: Lottie.asset('assets/loading/loading.json')),
//         ),);


  Widget builderWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: carouselItems,
              options: CarouselOptions(
                height: 250.0,
                initialPage: 0,
                viewportFraction: 1.0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'الأقسام',
              style: TextStyle(
                fontFamily: 'Almarai',
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 150,
              child: ListView.separated(
                  padding: EdgeInsets.all(9.0),
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => buildCatItem(),
                  separatorBuilder: (context, index) => myDivider(),
                  itemCount: 20),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'المنتجات الجديدة',
              style: TextStyle(
                fontFamily: 'Almarai',
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            GridView.count(
              physics: BouncingScrollPhysics(),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1 / 1.7,
              crossAxisCount: 2,
              shrinkWrap: true,
              children: List.generate(
                30,
                (index) => buildGridProduct(
                    HomeCubit.get(context).products![index]), //TODO: Error here<
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'الأقسام',
              style: TextStyle(
                fontFamily: 'Almarai',
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            GridView.count(
              physics: BouncingScrollPhysics(),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1 / 1,
              crossAxisCount: 3,
              shrinkWrap: true,
              children: List.generate(
                30,
                (index) => buildLargeCatItem(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCatItem() {
    return Container(
      height: 100,
      child: Column(
        children: [
          Container(
            height: 100,
            width: 100,
            child: Image.asset('assets/images/kidscat.jpg'),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            'أزياء أطفال',
            style: TextStyle(
              fontFamily: 'Almarai',
            ),
          ),
        ],
      ),
    );
  }

  Widget myDivider() {
    return SizedBox(
      width: 10,
    );
  }

  Widget buildGridProduct( Product model) => InkWell(
        onTap: () {},
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(model.images[0].src),
                    width: double.infinity,
                    height: 200.0,
                  ),
                  if (model.onSale == true)
                    Container(
                      color: Colors.red,
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.0,
                      ),
                      child: Text(
                        'DISCOUNT',
                        style: TextStyle(
                          fontSize: 8.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.0,
                        height: 1.3,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          model.prices.price
                          /*'${model.price.round()}'*/,
                          style: TextStyle(
                            fontSize: 12.0,
                            color: defColor,
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        if (/*model.discount*/ 1 != 0)
                          Text(
                            model.prices.salePrice
                            /* '${model.oldPrice.round()}'*/,
                            style: TextStyle(
                              fontSize: 10.0,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            /*  ShopCubit.get(context).changeFavorites(model.id);
                            print(model.id);*/
                          },
                          icon: CircleAvatar(
                            radius: 15.0,
                            backgroundColor:
                                /*ShopCubit
                                .get(context)
                                .favorites[model.id]
                                ? defaultColor
                                :*/
                                Colors.grey,
                            child: Icon(
                              Icons.favorite_border,
                              size: 14.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildLargeCatItem() {
    return InkWell(
      onTap: () {},
      child: Container(
        color: Colors.white,
        child: Image(
          image: NetworkImage(
              'https://khsomat.com/wp-content/uploads/2021/05/%D8%A3%D8%B2%D9%8A%D9%80%D8%A7%D8%A1-%D8%B1%D8%AC%D8%A7%D9%84%D9%8A.jpg'),
        ),
      ),
    );
  }
  Widget loadingIndicator(){
    return  Center(
          child: Container(
              height: 150,
              width: 200,
              child: Lottie.asset('assets/loading/loading.json')),
        );
  }
}
