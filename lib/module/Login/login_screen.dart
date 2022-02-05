// ignore_for_file: avoid_print

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/generated/l10n.dart';
import 'package:shop_app/generated/l10n.dart';
import 'package:shop_app/generated/l10n.dart';
import 'package:shop_app/layout/cubit/shop_cubit.dart';
import 'package:shop_app/layout/layout_screen.dart';
import 'package:shop_app/module/Login/cubit/app_cubit.dart';
import 'package:shop_app/module/Login/cubit/cubit_states.dart';
import 'package:shop_app/module/Register%20as%20a%20seller/register_as_a_seller.dart';
import 'package:shop_app/module/Verify%20Email/verify_email.dart';
import 'package:shop_app/module/forget%20passward/forget_passward.dart';
import 'package:shop_app/module/register/register_screen.dart';

import 'package:shop_app/shared/component.dart';
import 'package:shop_app/shared/const.dart';

import 'package:shop_app/shared/shared%20prefance/cath_helper.dart';
import 'package:shop_app/styles/colors.dart';

class LoginScreen extends StatelessWidget {
  var emailControler = TextEditingController();
  var passControler = TextEditingController();
  var keyform = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var t = S.of(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          if (state.loginModel.status) {
            print(state.loginModel.status);
            ShowToast(color: Colors.green, message: state.loginModel.message);
            SharedHelper.saveData(
                    key: 'token', value: state.loginModel.data.token)
                .then((value) {
              token = state.loginModel.data.token;

              navigateAndFinish(
                context,
                LayoutScreen(),
              );
              ShopCubit.get(context).getUserData();
            });
          }
          if (!state.loginModel.status) {
            ShowToast(color: Colors.red, message: state.loginModel.message);
            print(state.loginModel.status);
          }
        }
        if (state is LoginError) {
          ShowToast(color: Colors.red, message: state.loginModel.message);
          print(state.loginModel.status);
        }
      },
      builder: (context, state) {
        print(token);
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: keyform,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(t.Login,
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 30,
                                  )),
                      Text(t.login_title,
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 15,
                                  )),
                      const SizedBox(
                        height: 30,
                      ),
                      defaultFormField(
                        BordreColor: Theme.of(context).primaryColorLight,
                        TextColor: defaultColor,
                        IconColor: Theme.of(context).primaryColorLight,
                        type: TextInputType.emailAddress,
                        controller: emailControler,
                        label: t.email,
                        prefix: Icons.email,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'please enter your email address';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      defaultFormField(
                          BordreColor: Theme.of(context).primaryColorLight,
                          TextColor: defaultColor,
                          IconColor: Theme.of(context).primaryColorLight,
                          isPassword: cubit.isPASS,
                          type: TextInputType.visiblePassword,
                          controller: passControler,
                          label: t.passward,
                          prefix: Icons.lock,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'password is too short';
                            }
                          },
                          suffix: IconButton(
                              color: Theme.of(context).primaryColorLight,
                              onPressed: () {
                                cubit.changeVisablityToPass();
                              },
                              icon: Icon(
                                cubit.isPASS
                                    ? Icons.visibility_sharp
                                    : Icons.visibility_off_sharp,
                              ))),
                      Row(
                        children: [
                          TextButton(
                              onPressed: () {
                                navigateTo(context, Forgot_Password());
                              },
                              child: Text(
                                t.forgot_password,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      color: defaultColor,
                                      fontSize: 16,
                                    ),
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ConditionalBuilder(
                        condition: state is LoginLoading,
                        builder: (context) =>
                            Center(child: CircularProgressIndicator()),
                        fallback: (context) => defaultButton(
                            function: () {
                              if (keyform.currentState!.validate()) {
                                cubit.login(
                                    email: emailControler.text,
                                    pass: passControler.text);
                              }
                            },
                            text: t.Login,
                            background: defaultColor),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text(t.if_you_dont_have_account,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontSize: 15,
                                  )),
                          TextButton(
                              onPressed: () {
                                navigateTo(context, ShopRegisterScreen());
                              },
                              child: Text(t.Register_now)),
                        ],
                      ),
                      TextButton(
                          onPressed: () {
                            navigateTo(context, Regster_as_a_Seller());
                          },
                          child: Text(t.Register_as_a_seller)),
                      Container(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            defaultButton(
                              function: () {
                                ShopCubit.get(context).changelang();
                              },
                              text: t.lang,
                              width: 100,
                              background: Theme.of(context).backgroundColor,
                              text_style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
