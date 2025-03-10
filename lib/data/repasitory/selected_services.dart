// ignore: depend_on_referenced_packages
import 'package:hive/hive.dart';
import '../models/character_adapter.dart';

class SelectedServices {
  final Box<CharacterHive> _box = Hive.box('favorites');
  void addToFavorites(CharacterHive character) {
    _box.put(character.id, character);
  }

  void removeFromFavorites(int id) {
    _box.delete(id);
  }

  List<CharacterHive> getFavorites() {
    return _box.values.toList();
  }

  bool isFavorite(int id) {
    return _box.containsKey(id);
  }
}
