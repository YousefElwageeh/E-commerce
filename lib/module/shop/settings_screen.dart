import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit_states.dart';
import 'package:shop_app/layout/cubit/shop_cubit.dart';
import 'package:shop_app/shared/component.dart';
import 'package:shop_app/shared/const.dart';
import 'package:shop_app/styles/colors.dart';

class SettingsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  TextEditingController UpdateNameController = TextEditingController();
  TextEditingController UpdateEmailController = TextEditingController();
  TextEditingController UpdatePhoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessGetUserDataState) {
          ShowToast(message: 'updated successfully', color: Colors.green);
        } else if (state is ShopErrorUpdateUserState) {
          ShowToast(message: state.model.message!, color: Colors.red);
        }
      },
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel;

        UpdateNameController.text = model!.data!.name;
        UpdateEmailController.text = model.data!.email;
        UpdatePhoneController.text = model.data!.phone;

        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  if (state is ShopLoadingUpdateUserState)
                    LinearProgressIndicator(),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                    BordreColor: Theme.of(context).primaryColorLight,
                    controller: UpdateNameController,
                    type: TextInputType.name,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'name must not be empty';
                      }

                      return null;
                    },
                    label: 'Name',
                    prefix: Icons.person,
                    TextColor: defaultColor,
                    IconColor: Theme.of(context).primaryColorLight,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                    BordreColor: Theme.of(context).primaryColorLight,
                    controller: UpdateEmailController,
                    type: TextInputType.emailAddress,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'email must not be empty';
                      }

                      return null;
                    },
                    label: 'Email Address',
                    prefix: Icons.email,
                    TextColor: defaultColor,
                    IconColor: Theme.of(context).primaryColorLight,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                    controller: UpdatePhoneController,
                    type: TextInputType.phone,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'phone must not be empty';
                      }

                      return null;
                    },
                    label: 'Phone',
                    prefix: Icons.phone,
                    BordreColor: Theme.of(context).primaryColorLight,
                    TextColor: defaultColor,
                    IconColor: Theme.of(context).primaryColorLight,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultButton(
                    function: () {
                      if (formKey.currentState!.validate()) {
                        ShopCubit.get(context).updateUserData(
                          name: UpdateNameController.text,
                          phone: UpdatePhoneController.text,
                          email: UpdateEmailController.text,
                        );
                      }
                    },
                    text: 'update',
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultButton(
                    function: () {
                      signOut(context);
                    },
                    text: 'Logout',
                  ),
                ],
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
