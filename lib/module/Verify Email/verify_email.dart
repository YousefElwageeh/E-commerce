import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/module/Login/login_screen.dart';
import 'package:shop_app/module/register/cubit/register_cubit.dart';
import 'package:shop_app/module/register/cubit/register_cubit_states.dart';
import 'package:shop_app/module/register/register_screen.dart';

import 'package:shop_app/shared/component.dart';
import 'package:shop_app/shared/const.dart';
import 'package:shop_app/shared/shared%20prefance/cath_helper.dart';

import 'package:shop_app/styles/colors.dart';

class VerifyEmail extends StatelessWidget {
  var CodeControler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
      listener: (context, state) {
        if (state is SendCodeSuccess && state.verifyemailmodel.status!) {
          ShowToast(
              message: state.verifyemailmodel.message!, color: Colors.green);
        } else if (state is SendCodeError &&
            !(state.verifyemailmodel.status!)) {
          ShowToast(
              message: state.verifyemailmodel.message!, color: Colors.red);
        }
        if (state is VerifyCodeSuccess) {
          ShowToast(message: 'correct code ', color: Colors.green);
          navigateAndFinish(context, ShopRegisterScreen());
        } else if (state is VerifyCodeError) {
          ShowToast(message: 'Wrong code ', color: Colors.red);
        }
      },
      builder: (context, state) {
        var cubit = ShopRegisterCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'Enter your email and write code that you have recived   ',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 20,
                              height: 3,
                            )),
                    defaultFormField(
                      BordreColor: Theme.of(context).primaryColorLight,
                      TextColor: defaultColor,
                      IconColor: Theme.of(context).primaryColorLight,
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'please enter your email address';
                        }
                      },
                      label: 'Email Address',
                      prefix: Icons.email_outlined,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ConditionalBuilder(
                      condition: state is SendCodeSuccess,
                      builder: (context) => defaultFormField(
                        BordreColor: Theme.of(context).primaryColorLight,
                        TextColor: defaultColor,
                        IconColor: Theme.of(context).primaryColorLight,
                        controller: CodeControler,
                        label: 'code',
                        prefix: Icons.code,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'write your code that you have recived ';
                          } else {
                            return null;
                          }
                        },
                        type: TextInputType.number,
                      ),
                      fallback: (context) => const SizedBox(),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ConditionalBuilder(
                      condition: state is ResetPasswardLoading ||
                          state is SendCodeLoading,
                      builder: (context) =>
                          const Center(child: CircularProgressIndicator()),
                      fallback: (context) => defaultButton(
                        function: () {
                          state is SendCodeSuccess
                              ? cubit.VerfiyCode(
                                  code: CodeControler.text,
                                  email: emailController.text)
                              : cubit.sendCode(Email: emailController.text);
                        },
                        text: state is SendCodeSuccess ? 'verify' : 'SendCode',
                      ),
                    )
                  ]),
            ),
          ),
        );
      },
    );
  }
}
