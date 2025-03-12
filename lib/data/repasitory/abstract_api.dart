import 'package:rick_and_morty/data/models/rick_models.dart';

class AbstractCharacter {
  Future<List<CharacterResponse>> getCharacterResponse(
      {String query = ""}) async {
    throw UnimplementedError();
  }
}
