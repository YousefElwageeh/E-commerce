import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/module/Login/login_screen.dart';

import 'package:shop_app/module/register/cubit/register_cubit.dart';
import 'package:shop_app/module/register/cubit/register_cubit_states.dart';
import 'package:shop_app/module/register/register_screen.dart';
import 'package:shop_app/shared/component.dart';
import 'package:shop_app/styles/colors.dart';

class Forgot_Password extends StatelessWidget {
  TextEditingController PasswordController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController CodeControler = TextEditingController();
  bool button_clicked = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
      listener: (context, state) {
        if (state is SendCodeSuccess && state.verifyemailmodel.status!) {
          ShowToast(
              message: state.verifyemailmodel.message!, color: Colors.green);
        } else if (state is SendCodeError) {
          ShowToast(
              message: state.verifyemailmodel.message!, color: Colors.red);
        }
        if (state is ResetPasswardSuccess) {
          ShowToast(message: state.model.message!, color: Colors.green);
          navigateAndFinish(context, LoginScreen());
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
                        'Enter your email and write code that you have recived',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 18,
                              height: 3,
                            )),
                    defaultFormField(
                      BordreColor: Theme.of(context).primaryColorLight,
                      TextColor: defaultColor,
                      IconColor: Theme.of(context).primaryColorLight,
                      controller: EmailController,
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
                      condition: button_clicked,
                      builder: (context) => Column(
                        children: [
                          defaultFormField(
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
                          const SizedBox(
                            height: 30,
                          ),
                          defaultFormField(
                            BordreColor: Theme.of(context).primaryColorLight,
                            TextColor: defaultColor,
                            IconColor: Theme.of(context).primaryColorLight,
                            controller: PasswordController,
                            type: TextInputType.visiblePassword,
                            suffix: IconButton(
                              color: Theme.of(context).primaryColorLight,
                              icon: Icon(ShopRegisterCubit.get(context).suffix),
                              onPressed: () {
                                ShopRegisterCubit.get(context)
                                    .changePasswordVisibility();
                              },
                            ),
                            ontap: () {},
                            isPassword:
                                ShopRegisterCubit.get(context).isPassword,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'password is too short';
                              }
                            },
                            label: 'Password',
                            prefix: Icons.lock_outline,
                          ),
                        ],
                      ),
                      fallback: (context) => const SizedBox(),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ConditionalBuilder(
                      condition: !button_clicked,
                      builder: (context) => defaultButton(
                        function: () {
                          cubit.sendCode(Email: EmailController.text);
                          button_clicked = !button_clicked;
                        },
                        text: 'SendCode',
                      ),
                      fallback: (context) => defaultButton(
                        function: () {
                          cubit.reset_passward(
                            code: CodeControler.text,
                            email: EmailController.text,
                            password: PasswordController.text,
                          );
                          button_clicked = !button_clicked;
                        },
                        text: 'verify',
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
