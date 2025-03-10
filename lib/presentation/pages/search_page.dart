import 'package:flutter/material.dart';

import '../../data/models/rick_models.dart';
import '../../data/repasitory/api_services.dart';
import '../../data/repasitory/selected_services.dart';
import '../widgets/character_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final selectedServices = SelectedServices();
  final ApiServices _apiServices = ApiServices();
  Future<CharacterResponse>? _futureCharacters;
  final TextEditingController _searchController = TextEditingController();
  void _fetchCharacters([String query = ""]) {
    setState(() {
      _futureCharacters = _apiServices.getCharacterResponse(query: query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.9,
      builder: (context, scrollController) => Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: "Enter name person",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(Icons.search),
                ),
                onChanged: (query) => _fetchCharacters(query),
              ),
            ),
            Expanded(
              child: FutureBuilder<CharacterResponse>(
                future: _futureCharacters,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('misstakr: ${snapshot.error}'));
                  } else if (!snapshot.hasData ||
                      snapshot.data!.results.isEmpty) {
                    return const Center(child: Text("Not found"));
                  }
                  final characters = snapshot.data!.results;
                  return ListView.builder(
                    controller: scrollController,
                    itemCount: characters.length,
                    itemBuilder: (context, index) {
                      return CharacterCard(
                        character: characters[index],
                        selectedServices: selectedServices,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
