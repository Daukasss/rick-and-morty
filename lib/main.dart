import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rick_and_morty/presentation/pages/my_app.dart';
import 'data/models/character_adapter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CharacterHiveAdapter());
  await Hive.openBox<CharacterHive>('favorites');
  runApp(const MyApp());
}
