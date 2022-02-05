import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shop_app/const_data/data.dart';
import 'package:shop_app/layout/cubit/cubit_states.dart';
import 'package:shop_app/layout/cubit/shop_cubit.dart';
import 'package:shop_app/models/home_model.dart';

import 'package:shop_app/shared/component.dart';
import 'package:shop_app/shared/const.dart';
import 'package:shop_app/styles/colors.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

var pinCode = TextEditingController();
List<double> ratings = [0.1, 0.3, 0.5, 0.7, 0.9];
int selectedIndex = 0;
List detailsTitles = ['discriptions', 'More Info', 'Reviews'];

class Details_screen extends StatefulWidget {
  final ProductsModel model;
  Details_screen({Key? key, required this.model}) : super(key: key);

  @override
  State<Details_screen> createState() => _Details_screenState();
}

class _Details_screenState extends State<Details_screen> {
  @override
  Widget build(BuildContext context) {
    List details = [
      description(context, widget.model),
      more_info(context),
      buildReveiw(context),
    ];

    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
        child: SizedBox(
          height: 25,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: detailsTitles.length,
            itemBuilder: (context, index) => buildCategory(index),
          ),
        ),
      ),
      details[selectedIndex],
    ]);
  }

  Widget buildCategory(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              detailsTitles[index],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: selectedIndex == index
                    ? defaultColor
                    : Theme.of(context).primaryColorLight,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: kDefaultPaddin / 4), //top padding 5
              height: 2,
              width: 30,
              color: selectedIndex == index
                  ? Theme.of(context).primaryColorLight
                  : Colors.transparent,
            )
          ],
        ),
      ),
    );
  }
}

Widget buildReveiw(context) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "4.5",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 48),
                      ),
                      TextSpan(
                          text: "/5",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontSize: 24)),
                    ],
                  ),
                ),
                SmoothStarRating(
                  starCount: 5,
                  rating: 4.5,
                  size: 28.0,
                  color: Colors.orange,
                  borderColor: Colors.orange,
                ),
                SizedBox(height: 16.0),
                Text("${reviewList.length} Reviews",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 20)),
              ],
            ),
            Container(
              width: 200.0,
              child: ListView.builder(
                shrinkWrap: true,
                reverse: true,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Text(
                        "${index + 1}",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 18),
                      ),
                      SizedBox(width: 4.0),
                      Icon(Icons.star, color: Colors.orange),
                      SizedBox(width: 8.0),
                      LinearPercentIndicator(
                        lineHeight: 6.0,
                        // linearStrokeCap: LinearStrokeCap.roundAll,
                        width: MediaQuery.of(context).size.width / 2.8,
                        animation: true,
                        animationDuration: 2500,
                        percent: ratings[index],
                        progressColor: Colors.orange,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      ListView.separated(
          padding: EdgeInsets.only(bottom: 8.0, top: 8.0),
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Reveiw_UI(
                context: context,
                image: reviewList[index].image!,
                name: reviewList[index].name!,
                rating: reviewList[index].rating!,
                comment: reviewList[index].comment!,
                date: reviewList[index].date!,
                onPressed: () => print("More Action $index"),
                color: Colors.orange,
                textColor: defaultColor);
          },
          separatorBuilder: (context, index) {
            return Divider(
              thickness: 2.0,
              color: Colors.grey[400],
            );
          },
          itemCount: reviewList.length),
    ],
  );
}

Widget more_info(context) {
  return Padding(
    padding: const EdgeInsets.all(100.0),
    child: Column(
      children: [],
    ),
  );
}

Widget description(context, ProductsModel model) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Text(
            model.description,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 13,
                ),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Container(
                height: 30,
                width: 150,
                child: defaultFormField(
                    controller: pinCode,
                    label: 'pincode',
                    type: TextInputType.number),
              ),
              SizedBox(
                width: 50,
              ),
              Column(
                children: [
                  Text('delivery by  '),
                  Text('delivery time  '),
                ],
              )
            ],
          )
        ],
      ),
    ),
  );
  ;
}
