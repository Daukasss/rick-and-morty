import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:rick_and_morty/data/repasitory/abstract_api.dart';
import '../models/rick_models.dart';

const baseUrl = "https://rickandmortyapi.com/api/character";

class ApiServices implements AbstractCharacter {
  ApiServices({required this.dio});
  final Dio dio;

  @override
  Future<List<CharacterResponse>> getCharacterResponse(
      {String query = ""}) async {
    try {
      final response = await dio.get(baseUrl, queryParameters: {"name": query});

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data as Map<String, dynamic>;

        if (!data.containsKey('results') || data['results'] == null) {
          throw Exception("Ошибка: поле 'results' отсутствует или равно null");
        }

        final List<Character> characters = (data['results'] as List<dynamic>)
            .map((character) =>
                Character.fromJson(character as Map<String, dynamic>))
            .toList();

        debugPrint("Data: ${characters.length} characters loaded");
        return characters
            .map((e) =>
                CharacterResponse(info: Info(count: 1, pages: 1), results: [e]))
            .toList();
      }

      throw Exception("Ошибка запроса: код ${response.statusCode}");
    } catch (e) {
      debugPrint("Ошибка при загрузке персонажей: $e");
      throw Exception("Ошибка при загрузке персонажей: $e");
    }
  }
}
