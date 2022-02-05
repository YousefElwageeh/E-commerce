import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/module/Login/login_screen.dart';

import 'package:shop_app/module/register/cubit/register_cubit.dart';
import 'package:shop_app/module/register/cubit/register_cubit_states.dart';

import 'package:shop_app/shared/component.dart';
import 'package:shop_app/shared/const.dart';

import 'package:shop_app/styles/colors.dart';

class ShopRegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();

  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
      if (state is ShopRegisterSuccessState) {
        if (state.loginModel.status!) {
          ShowToast(message: state.loginModel.message!, color: Colors.green);
          navigateAndFinish(context, LoginScreen());
        } else {
          ShowToast(message: state.loginModel.message!, color: Colors.red);
        }
      } else if (state is ShopRegisterErrorState) {
        ShowToast(message: state.loginModel.message!, color: Colors.red);
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'REGISTER',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 30,
                          ),
                    ),
                    Text(
                      'Register now to browse our hot offers',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 15,
                          ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    defaultFormField(
                      BordreColor: Theme.of(context).primaryColorLight,
                      TextColor: defaultColor,
                      IconColor: Theme.of(context).primaryColorLight,
                      controller: nameController,
                      type: TextInputType.name,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'please enter your name';
                        }
                      },
                      label: 'User Name',
                      prefix: Icons.person,
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
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
                      height: 30.0,
                    ),
                    defaultFormField(
                      BordreColor: Theme.of(context).primaryColorLight,
                      TextColor: defaultColor,
                      IconColor: Theme.of(context).primaryColorLight,
                      controller: passwordController,
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
                      isPassword: ShopRegisterCubit.get(context).isPassword,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'password is too short';
                        }
                      },
                      label: 'Password',
                      prefix: Icons.lock_outline,
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    defaultFormField(
                      BordreColor: Theme.of(context).primaryColorLight,
                      TextColor: defaultColor,
                      IconColor: Theme.of(context).primaryColorLight,
                      controller: phoneController,
                      type: TextInputType.phone,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'please enter your phone number';
                        }
                      },
                      label: 'Phone',
                      prefix: Icons.phone,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ConditionalBuilder(
                      condition: state is ShopRegisterLoadingState,
                      builder: (context) =>
                          const Center(child: CircularProgressIndicator()),
                      fallback: (context) => defaultButton(
                        function: () {
                          if (formKey.currentState!.validate()) {
                            ShopRegisterCubit.get(context).userRegister(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                phone: phoneController.text);
                          }
                        },
                        text: 'register',
                        isUpperCase: true,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
