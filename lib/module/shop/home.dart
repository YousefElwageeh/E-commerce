// ignore_for_file: non_constant_identifier_names, use_key_in_widget_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit_states.dart';
import 'package:shop_app/layout/cubit/shop_cubit.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/module/shop/product_screen/product_screen.dart';
import 'package:shop_app/shared/component.dart';

import 'package:shop_app/styles/colors.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopChangeFavoritesSuccess) {
          if (!state.model.status) {
            ShowToast(message: state.model.message, color: Colors.red);
          }
        }
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);

        return ConditionalBuilder(
            condition: cubit.homeData != null && cubit.categoriesData != null,
            builder: (context) =>
                ProductBuilder(cubit.homeData, cubit.categoriesData!, context),
            fallback: (context) {
              return Center(child: CircularProgressIndicator());
            });
      },
    );
  }

  Widget ProductBuilder(
      HomeModel? models, CategoriesModel categoriesModel, context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
              items: models!.data!.banners
                  .map((e) => Image(
                        image: NetworkImage(e.image!),
                        width: double.infinity,
                      ))
                  .toList(),
              options: CarouselOptions(
                height: 250,
                autoPlay: true,
                initialPage: 0,
                autoPlayCurve: Curves.fastOutSlowIn,
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayInterval: Duration(seconds: 3),
                reverse: false,
                enableInfiniteScroll: true,
                scrollDirection: Axis.horizontal,
                viewportFraction: 1,
              )),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Categorise',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 25,
                      ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 130,
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => bulidCategoriesItems(
                          categoriesModel.data!.data![index], context),
                      separatorBuilder: (context, index) => const SizedBox(
                            width: 15,
                          ),
                      itemCount: categoriesModel.data!.data!.length),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'News Products',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 25,
                      ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          Container(
            child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
                childAspectRatio: 1 / 1.58,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(
                  models.data!.products.length,
                  (index) =>
                      buildGridProduct(models.data!.products[index], context),
                )),
          )
        ],
      ),
    );
  }

  Widget buildGridProduct(ProductsModel model, context) => Container(
          child: Column(
        children: [
          InkWell(
            onTap: () {
              navigateTo(
                  context,
                  ProductScreen(
                    model: model,
                  ));
            },
            child:
                Stack(alignment: AlignmentDirectional.bottomStart, children: [
              Image(
                image: NetworkImage(model.image),
                width: double.infinity,
                height: 200.0,
              ),
              if (model.discount != 0)
                Container(
                  color: Colors.red,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5.0,
                    vertical: 5,
                  ),
                  child: const Text(
                    'DISCOUNT',
                    style: TextStyle(
                      fontSize: 8.0,
                      color: Colors.white,
                    ),
                  ),
                ),
            ]),
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
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 14,
                        height: 1.3,
                      ),
                ),
                Row(
                  children: [
                    Text(
                      '${model.price.round()}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        color: defaultColor,
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    if (model.discount != 0)
                      Text(
                        '${model.oldPrice.round()}',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 10.0,
                              decoration: TextDecoration.lineThrough,
                            ),
                        // style: const TextStyle(
                        //   fontSize: 10.0,
                        //   color: Colors.grey,
                        //   decoration: TextDecoration.lineThrough,
                        // ),
                      ),
                    const Spacer(),
                    Container(
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor:
                            ShopCubit.get(context).favorites[model.id]!
                                ? defaultColor
                                : Colors.grey,
                        child: IconButton(
                          icon: Icon(
                            Icons.favorite,
                            size: 14.0,
                            color: ShopCubit.get(context).favorites[model.id]!
                                ? Colors.red
                                : Colors.white,
                          ),
                          onPressed: () {
                            ShopCubit.get(context).ChangeFavorites(model.id);
                            print(model.id);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ));

  Widget bulidCategoriesItems(DataModel model, context) {
    return Column(
      children: [
        Container(
          height: 100,
          width: 100,
          child: Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.image!),
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          model.name!,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 15,
              ),
        ),
      ],
    );
  }
}
