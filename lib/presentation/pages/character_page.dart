import 'package:flutter/material.dart';
import 'package:rick_and_morty/data/repasitory/api_services.dart';
import 'package:rick_and_morty/presentation/pages/search_page.dart';
import 'package:rick_and_morty/presentation/widgets/character_card.dart';

import '../../data/models/rick_models.dart';
import '../../data/repasitory/selected_services.dart';

class CharacterPage extends StatefulWidget {
  const CharacterPage({super.key});

  @override
  State<CharacterPage> createState() => _CharacterPageState();
}

late Future<CharacterResponse> futureCharacter;

class _CharacterPageState extends State<CharacterPage> {
  ApiServices apiServices = ApiServices();
  final selectedServices = SelectedServices();

  @override
  void initState() {
    futureCharacter = apiServices.getCharacterResponse();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List of character"),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => const SearchPage(),
              );
            },
            icon: const Icon(
              Icons.search,
            ),
          )
        ],
      ),
      body: FutureBuilder<CharacterResponse>(
        future: futureCharacter,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            var data = snapshot.data!.results;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return CharacterCard(
                  character: data[index],
                  selectedServices: selectedServices,
                );
              },
            );
          } else {
            return const Center(child: Text('No data'));
          }
        },
      ),
    );
  }
}
