// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:salla_app/manager/cubits/home_cubit/home_cubit.dart';
import 'package:salla_app/manager/cubits/login_cubit/bloc_observer.dart';
import 'package:salla_app/network/local/cache_helper.dart';
import 'package:salla_app/network/remote/dio_helper.dart';
import 'package:salla_app/modules/onboarding/screen/onboarding_screen.dart';
import 'package:salla_app/manager/provider/theme_provider.dart';
import 'package:salla_app/modules/user/home/screen/home_screen.dart';
import 'package:salla_app/core/consts/theme_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  var onBoarding = CacheHelper.getData(key: 'OnBoardingScreen');
  String? token = CacheHelper.getData(key: 'token');
  print('token is ${token}');

  Widget widget;
  if (token != null) {
    widget = const HomeScreen();
  } else {
    widget = const OnBoardingScreen();
  }

  // if (onBoarding != null) {
  //   if (token != null) {
  //     widget = const
  // ();
  //   } else {
  //     widget = const ShopLoginScreen();
  //   }
  // } else {
  //   widget = const OnBoardingScreen();
  // }
  print(widget);
  // ignore: avoid_print
  print(onBoarding);
  runApp(SallaApp(
    startWidget: widget,
  ));
}

class SallaApp extends StatelessWidget {
  // widget
  final Widget startWidget;
  const SallaApp({
    super.key,
    required this.startWidget,
  });

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit(),
        ),
        BlocProvider(
          create: (context) => HomeCubit()
            ..HomeData()
            ..categoryData()
            ..fetchFavourite()
            ..getProfile()
            ..getDetails(),
        ),
      ],
      child: ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, child) {
        final provider = Provider.of<ThemeProvider>(context);

          return MaterialApp(
          home: startWidget,
          theme: ThemeStyle.lightTheme,
          darkTheme: ThemeStyle.darkTheme,
          themeMode: provider.themeMode,
          // initialRoute: startWidget.toString(),
          debugShowCheckedModeBanner: false,
        );
        },
      ),
    );
  }
}
