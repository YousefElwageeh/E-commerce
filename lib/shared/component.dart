import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/cubit/shop_cubit.dart';
import 'package:shop_app/shared/const.dart';

import 'package:shop_app/styles/colors.dart';

Widget mydivder() => Container(
      height: 1,
      color: Colors.grey,
    );

Widget defaultFormField(
        {required TextEditingController controller,
        required String label,
        IconData? prefix,
        void Function()? ontap,
        required TextInputType? type,
        Widget? suffix,
        var function,
        var validator,
        bool isPassword = false,
        var oncahnge,
        Function(String value)? validate,
        Color BordreColor = Colors.black,
        Color? TextColor,
        Color? IconColor}) =>
    TextFormField(
      validator: validator,
      onTap: ontap,
      onChanged: oncahnge,
      obscureText: isPassword,
      keyboardType: type,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: TextColor,
        ),
        prefixIcon: Icon(
          prefix,
          color: IconColor,
        ),
        suffixIcon: suffix,
        suffixStyle: TextStyle(
          color: TextColor,
        ),
        enabledBorder: OutlineInputBorder(
          // width: 0.0 produces a thin "hairline" border
          borderSide: BorderSide(color: BordreColor, width: 1.0),
        ),
      ),
      style: TextStyle(
        color: TextColor,
      ),
    );

Widget defaultTextButton({
  required void Function()? function,
  required var text,
}) =>
    TextButton(
      onPressed: function,
      child: Text(
        text.toUpperCase(),
      ),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
void navigateAndFinish(
  context,
  widget,
) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) {
        return false;
      },
    );

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  TextStyle? text_style,
  bool isUpperCase = true,
  double radius = 3.0,
  required void Function()? function,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: text_style ??
              const TextStyle(
                color: Colors.white,
              ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );
void ShowToast({
  required String message,
  required Color color,
}) =>
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 5,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

Widget buildListProduct(
  model,
  context,
) =>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120.0,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image),
                  width: 120.0,
                  height: 120.0,
                ),
                if (model.discount != 0)
                  Container(
                    color: Colors.red,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    child: const Text(
                      'DISCOUNT',
                      style: TextStyle(
                        fontSize: 8.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 14.0,
                          height: 1.3,
                        ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        model.price.toString(),
                        style: TextStyle(
                          fontSize: 12.0,
                          color: defaultColor,
                        ),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      if (model.discount != 0)
                        Text(model.oldPrice.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    fontSize: 10.0,
                                    decoration: TextDecoration.lineThrough)),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopCubit.get(context).ChangeFavorites(model.id!);
                          print(model.id);
                        },
                        icon: CircleAvatar(
                          radius: 15.0,
                          backgroundColor:
                              ShopCubit.get(context).favorites[model.id]!
                                  ? defaultColor
                                  : Colors.grey,
                          child: Icon(
                            Icons.favorite,
                            size: 14.0,
                            color: ShopCubit.get(context).favorites[model.id]!
                                ? Colors.red
                                : Colors.white,
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

Widget Reveiw_UI({
  required String image,
  required String name,
  required String date,
  required String comment,
  required double rating,
  required void Function()? onPressed,
  required Color color,
  required Color textColor,
  required context,
}) {
  return Container(
    padding: EdgeInsets.only(
      top: 2.0,
      bottom: 2.0,
      left: 16.0,
      right: 0.0,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              height: 45.0,
              width: 45.0,
              margin: EdgeInsets.only(right: 16.0),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(image),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(44.0),
              ),
            ),
            Expanded(
              child: Text(name,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 20)),
            ),
            IconButton(
              onPressed: onPressed,
              icon: Icon(Icons.more_vert),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Row(
          children: [
            RatingBar.builder(
                itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: color,
                    ),
                onRatingUpdate: (rating) {
                  print(rating);
                }),
            const SizedBox(width: kFixPadding),
            Text(
              date,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        GestureDetector(
          onTap: () {},
          child: Text(
            comment,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 18.0,
              color: textColor,
            ),
          ),
        ),
      ],
    ),
  );
  ;
}
