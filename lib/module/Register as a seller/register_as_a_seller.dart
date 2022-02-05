// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:shop_app/module/Register%20as%20a%20seller/cubit/cubit.dart';
import 'package:shop_app/module/Register%20as%20a%20seller/cubit/states.dart';
import 'package:shop_app/shared/component.dart';
import 'package:shop_app/styles/colors.dart';

final ImagePicker _picker = ImagePicker();
var pickedFile;

class Regster_as_a_Seller extends StatelessWidget {
  bool ButtomClick = false;
  var SecoundNameController = TextEditingController();

  var FirstNameController = TextEditingController();

  var EmailController = TextEditingController();

  var StoreName = TextEditingController();

  var StoreLocation = TextEditingController();

  var PasswordController = TextEditingController();

  var PhoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Register_As_cubit(),
      child: BlocConsumer<Register_As_cubit, Shop_Register_AS_States>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = Register_As_cubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(30.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'Register as a seller',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 30,
                          ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    defaultFormField(
                      BordreColor: Theme.of(context).primaryColorLight,
                      TextColor: defaultColor,
                      IconColor: Theme.of(context).primaryColorLight,
                      controller: FirstNameController,
                      type: TextInputType.name,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'please enter your first  First name';
                        }
                      },
                      label: 'First name',
                      prefix: Icons.person,
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    defaultFormField(
                        BordreColor: Theme.of(context).primaryColorLight,
                        TextColor: defaultColor,
                        IconColor: Theme.of(context).primaryColorLight,
                        controller: SecoundNameController,
                        type: TextInputType.name,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'please enter your family name';
                          }
                        },
                        label: 'family name',
                        prefix: Icons.family_restroom),
                    const SizedBox(
                      height: 30.0,
                    ),
                    defaultFormField(
                      BordreColor: Theme.of(context).primaryColorLight,
                      TextColor: defaultColor,
                      IconColor: Theme.of(context).primaryColorLight,
                      controller: EmailController,
                      type: TextInputType.name,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'please enter your Email';
                        }
                      },
                      label: 'Email',
                      prefix: Icons.email,
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    defaultFormField(
                      BordreColor: Theme.of(context).primaryColorLight,
                      TextColor: defaultColor,
                      IconColor: Theme.of(context).primaryColorLight,
                      controller: StoreName,
                      type: TextInputType.name,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'please enter your Store name';
                        }
                      },
                      label: 'Store name',
                      prefix: Icons.store,
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    defaultFormField(
                      BordreColor: Theme.of(context).primaryColorLight,
                      TextColor: defaultColor,
                      IconColor: Theme.of(context).primaryColorLight,
                      controller: StoreLocation,
                      type: TextInputType.name,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'please enter your Store location';
                        }
                      },
                      label: 'Store location',
                      prefix: Icons.gps_fixed,
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    defaultFormField(
                      BordreColor: Theme.of(context).primaryColorLight,
                      TextColor: defaultColor,
                      IconColor: Theme.of(context).primaryColorLight,
                      controller: PasswordController,
                      type: TextInputType.visiblePassword,
                      suffix: IconButton(
                        color: Theme.of(context).primaryColorLight,
                        icon: Icon(Register_As_cubit.get(context).suffix),
                        onPressed: () {
                          Register_As_cubit.get(context)
                              .changePasswordVisibility();
                        },
                      ),
                      ontap: () {},
                      isPassword: Register_As_cubit.get(context).isPassword,
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
                      controller: StoreLocation,
                      type: TextInputType.name,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'please enter your phone number';
                        }
                      },
                      label: 'phone number',
                      prefix: Icons.phone,
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    defaultFormField(
                      BordreColor: Theme.of(context).primaryColorLight,
                      TextColor: defaultColor,
                      IconColor: Theme.of(context).primaryColorLight,
                      controller: StoreLocation,
                      type: TextInputType.name,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'please enter your address';
                        }
                      },
                      label: 'address',
                      prefix: Icons.door_front_door,
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Row(
                      children: [
                        ConditionalBuilder(
                          condition: cubit.imageFile == null,
                          builder: (context) => FlatButton(
                            onPressed: () {
                              takePhoto(context);
                            },
                            child: Text('uplode photo'),
                            color: defaultColor,
                          ),
                          fallback: (context) => imageProfile(context),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        FlatButton(
                          onPressed: () {
                            Choose_the_country(context);
                          },
                          child: Text('Choose a country'),
                          color: defaultColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget imageProfile(context) {
  return Center(
    child: Stack(children: <Widget>[
      CircleAvatar(
        radius: 80.0,
        backgroundImage:
            FileImage(File(Register_As_cubit.get(context).imageFile!.path)),
      ),
      Positioned(
        bottom: 20.0,
        right: 20.0,
        child: IconButton(
          icon: Icon(
            Icons.upload_rounded,
            color: defaultColor,
            size: 30.0,
          ),
          onPressed: () {
            takePhoto(context);
          },
        ),
      ),
      Positioned(
        bottom: 20.0,
        left: 20.0,
        child: IconButton(
          icon: Icon(
            Icons.delete,
            color: Colors.red,
            size: 30.0,
          ),
          onPressed: () {
            Register_As_cubit.get(context).delete_photo();
          },
        ),
      ),
    ]),
  );
}

void takePhoto(context) async {
  pickedFile = await _picker.getImage(
    source: ImageSource.gallery,
  );
  Register_As_cubit.get(context).take_photo();
}

enum SingingCharacter { egypt, US }
SingingCharacter? character = SingingCharacter.egypt;
Widget makeOption(
    {required context,
    required String text,
    required SingingCharacter country}) {
  return RadioListTile<SingingCharacter>(
    title: Text(
      'egypt',
      style: Theme.of(context).textTheme.bodyText1,
    ),
    value: country,
    groupValue: character,
    onChanged: (SingingCharacter? value) {
      //  _character = value;
    },
  );
}

void Choose_the_country(context) {
  return showCountryPicker(
    context: context,
    showPhoneCode: true, // optional. Shows phone code before the country name.
    onSelect: (Country country) {
      print('Select country: ${country.displayName}');
    },
    countryListTheme: CountryListThemeData(
      backgroundColor: Theme.of(context).backgroundColor,
      textStyle: Theme.of(context).textTheme.bodyText1,
      inputDecoration: InputDecoration(
        labelStyle: Theme.of(context).textTheme.bodyText1,
        hintStyle: Theme.of(context).textTheme.bodyText1,
        helperStyle: Theme.of(context).textTheme.bodyText1,
        counterStyle: Theme.of(context).textTheme.bodyText1,
        labelText: 'Search',
        hintText: 'Start typing to search',
        prefixIcon: Icon(
          Icons.search,
          color: Theme.of(context).primaryColorLight,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColorLight,
          ),
        ),
      ),
    ),
  );
}
