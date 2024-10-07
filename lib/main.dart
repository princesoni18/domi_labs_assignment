import 'package:domi_labs/features/home/bloc/home_bloc.dart';
import 'package:domi_labs/features/home/home_screen.dart';
import 'package:domi_labs/utils/themes/bloc/theme_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(MultiBlocProvider(

    providers: [

    BlocProvider(create: (context) => ThemeBloc(),),
    BlocProvider(create: (context) => HomeBloc(),)
    ],
    
    child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(374, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        title: 'Domi labs task by Prince Soni',
        debugShowCheckedModeBanner: false,
        theme: BlocProvider.of<ThemeBloc>(context,listen: true).themeData,
        home:  const HomeScreen(),
      ),
    );
  }
}

