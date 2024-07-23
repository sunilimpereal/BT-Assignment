import 'package:bt_assignment/config/theme.dart';
import 'package:bt_assignment/data/bloc/recipe_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Import flutter_bloc
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bt_assignment/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocProvider(
          create: (context) => RecipeBloc(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'BT Assignment App',
            // You can use the library anywhere in the app even in theme
            theme: AppTheme.lightTheme,
            home: const HomeScreen(),
          ),
        );
      },
    );
  }
}
