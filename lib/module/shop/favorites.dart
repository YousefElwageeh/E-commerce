import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit_states.dart';
import 'package:shop_app/layout/cubit/shop_cubit.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/component.dart';
import 'package:shop_app/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavoritesState &&
              state is! ShopChangeFavorites,
          builder: (context) => ListView.separated(
            itemBuilder: (context, index) => ConditionalBuilder(
                condition: ShopCubit.get(context).favoritesModel != null,
                builder: (context) => buildListProduct(
                      ShopCubit.get(context)
                          .favoritesModel!
                          .data!
                          .data![index]
                          .product,
                      context,
                    ),
                fallback: (context) => Center(
                        child: Text(
                      'no favorite product yet',
                      style: TextStyle(color: Colors.black12),
                    ))),
            separatorBuilder: (context, index) => mydivder(),
            itemCount:
                ShopCubit.get(context).favoritesModel!.data!.data!.length,
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
