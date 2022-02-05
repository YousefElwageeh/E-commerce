import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_app/module/shop/Search/cubit.dart';
import 'package:shop_app/module/shop/Search/states.dart';
import 'package:shop_app/shared/component.dart';

class SearchScreen extends StatelessWidget {
  TextEditingController SearchControler = TextEditingController();
  GlobalKey formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  defaultFormField(
                      BordreColor: Theme.of(context).primaryColorLight,
                      TextColor: Theme.of(context).primaryColorLight,
                      IconColor: Theme.of(context).primaryColorLight,
                      controller: SearchControler,
                      label: 'Search',
                      prefix: Icons.search,
                      type: TextInputType.text,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'please write someThing';
                        } else {
                          return null;
                        }
                      },
                      oncahnge: (String text) {
                        SearchCubit.get(context).Search(searchText: text);
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  if (state is SearchLoadingStates) LinearProgressIndicator(),
                  const SizedBox(
                    height: 10,
                  ),
                  if (state is SearchSuccessStates)
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) => buildListProduct(
                          SearchCubit.get(context).model!.data!.data![index],
                          context,
                        ),
                        separatorBuilder: (context, index) => mydivder(),
                        itemCount:
                            SearchCubit.get(context).model!.data!.data!.length,
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
