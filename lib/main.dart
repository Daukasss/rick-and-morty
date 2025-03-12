import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/config/bloc/cubit/theme_cubit.dart';
import 'package:rick_and_morty/data/repasitory/abstract_api.dart';
import 'package:rick_and_morty/data/repasitory/api_services.dart';
import 'package:rick_and_morty/presentation/bloc/character_bloc.dart';
import 'package:rick_and_morty/presentation/pages/my_app.dart';
import 'data/models/character_adapter.dart';
import 'data/repasitory/selected_services.dart';

void main() async {
  GetIt.I.registerSingleton<AbstractCharacter>(ApiServices(dio: Dio()));
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CharacterHiveAdapter());
  await Hive.openBox<CharacterHive>('favorites');
  runApp(MultiBlocProvider(
    providers: [
      Provider<SelectedServices>(create: (_) => SelectedServices()),
      BlocProvider(
        create: (context) => CharacterBloc(GetIt.I<AbstractCharacter>()),
      ),
      BlocProvider(
        create: (context) => ThemeCubit(),
      ),
    ],
    child: const MyApp(),
  ));
}
