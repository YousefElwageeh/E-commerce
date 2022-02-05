// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/generated/l10n.dart';

import 'package:shop_app/layout/cubit/cubit_states.dart';
import 'package:shop_app/layout/cubit/shop_cubit.dart';
import 'package:shop_app/layout/layout_screen.dart';
import 'package:shop_app/module/Login/cubit/app_cubit.dart';
import 'package:shop_app/module/Login/cubit/bloc_observer.dart';

import 'package:shop_app/module/boarding_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shop_app/module/Login/login_screen.dart';
import 'package:shop_app/module/register/cubit/register_cubit.dart';
import 'package:shop_app/module/shop/Search/cubit.dart';
import 'package:shop_app/shared/const.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shop_app/shared/dio/dio_helper.dart';
import 'package:shop_app/shared/shared%20prefance/cath_helper.dart';
import 'package:shop_app/styles/themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await SharedHelper.init();
  await DioHelper.init();
  bool? darkmode = SharedHelper.getData(key: 'isDark');

  token = SharedHelper.getData(key: 'token');
  bool? Applang = SharedHelper.getData(key: 'lang');
  bool? isboarding = SharedHelper.getData(key: 'onBoarding');
  String? islogin = SharedHelper.getData(key: 'token');

  Widget startScreen;
  if (isboarding != null) {
    if (islogin != null)
      startScreen = LayoutScreen();
    else
      startScreen = LoginScreen();
  } else
    startScreen = OnBoardingScreen();

  runApp(MyApp(
    startScreen: startScreen,
    darkmode: darkmode,
    Applang: Applang,
  ));
}

class MyApp extends StatelessWidget {
  final Widget? startScreen;
  final bool? darkmode;
  final bool? Applang;
  MyApp({this.startScreen, this.darkmode, this.Applang});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AppCubit(),
          ),
          BlocProvider(
              create: (context) => ShopCubit()
                ..ShopGetData()
                ..GetCategoriesData()
                ..getFavorites()
                ..getUserData()
                ..ChangeAppTheme(fromShared: darkmode)
                ..changelang(DL: Applang)),
          BlocProvider(
            create: (context) => SearchCubit(),
          ),
          BlocProvider(
            create: (BuildContext context) => ShopRegisterCubit(),
          ),
        ],
        child: BlocConsumer<ShopCubit, ShopStates>(
          listener: (context, state) {},
          builder: (context, state) => MaterialApp(
            title: 'Localizations Sample App',
            locale: ShopCubit.get(context).arabic ? Locale("ar") : Locale("en"),
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            debugShowCheckedModeBanner: false,
            theme: lightTheme(),
            darkTheme: darkTheme(),
            themeMode: ShopCubit.get(context).isdark
                ? ThemeMode.dark
                : ThemeMode.light,
            home: startScreen,
          ),
        ));
  }
}
