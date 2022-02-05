import 'package:flutter/material.dart';
import 'package:shop_app/models/home_model.dart';

import 'package:shop_app/module/shop/product_screen/details.dart';

import 'package:shop_app/styles/colors.dart';

class ProductScreen extends StatelessWidget {
  final ProductsModel model;

  ProductScreen({Key? key, required this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Image(
                  fit: BoxFit.cover,
                  height: 400,
                  image: NetworkImage(model.image)),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 300,
                    child: FittedBox(
                      child: Text(
                        model.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 20,
                            ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: 50,
                    child: FittedBox(
                      child: Text(
                        '${model.price}',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: defaultColor,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Details_screen(
              model: model,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Row(
        children: [
          Expanded(
              child: Container(
            height: 60,
            child: FloatingActionButton.extended(
              onPressed: () {},
              label: Text(
                'Add to card',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              backgroundColor: Theme.of(context).backgroundColor,
              shape: BeveledRectangleBorder(borderRadius: BorderRadius.zero),
            ),
          )),
          Expanded(
              child: Container(
            height: 60,
            child: FloatingActionButton.extended(
              onPressed: () {},
              label: Text(
                'Buy now',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              shape: BeveledRectangleBorder(borderRadius: BorderRadius.zero),
            ),
          )),
        ],
      ),
    );
  }
}
