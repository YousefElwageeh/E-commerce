import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit_states.dart';
import 'package:shop_app/layout/cubit/shop_cubit.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/shared/component.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
          itemBuilder: (context, index) => buildCatItem(
              ShopCubit.get(context).categoriesData!.data!.data![index],
              context),
          separatorBuilder: (context, index) => mydivder(),
          itemCount: ShopCubit.get(context).categoriesData!.data!.data!.length,
        );
      },
    );
  }

  Widget buildCatItem(DataModel model, context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(model.image!),
              width: 80.0,
              height: 80.0,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              width: 20.0,
            ),
            Text(model.name!,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 20,
                    )),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).primaryColorLight,
            ),
          ],
        ),
      );
}
