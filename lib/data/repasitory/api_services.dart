import 'package:dio/dio.dart';
import '../models/rick_models.dart';

const baseUrl = "https://rickandmortyapi.com/api/character";
final dio = Dio();

class ApiServices {
  Future<CharacterResponse> getCharacterResponse({String query = ""}) async {
    try {
      final response = await dio.get(baseUrl, queryParameters: {"name": query});
      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final finalData = CharacterResponse.fromJson(data);
        return finalData;
      }
      throw Exception("Faill");
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  // Future<CharacterResponse> getSearch(String search){

  // }
}
