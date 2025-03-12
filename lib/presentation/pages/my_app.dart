import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../config/bloc/cubit/theme_cubit.dart';
import '../../config/theme.dart';
import '../widgets/bottom_nav_bar.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'RIck and Morty',
          theme: state.isDark ? darkTheme : lightTheme,
          home: const BottomNavBar(),
        );
      },
    );
  }
}
