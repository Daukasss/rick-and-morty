import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/presentation/pages/search_page.dart';
import 'package:rick_and_morty/presentation/widgets/character_card.dart';

import '../../data/repasitory/selected_services.dart';
import '../bloc/character_bloc.dart';

class CharacterPage extends StatefulWidget {
  const CharacterPage({super.key});

  @override
  State<CharacterPage> createState() => _CharacterPageState();
}

class _CharacterPageState extends State<CharacterPage> {
  final selectedServices = SelectedServices();

  @override
  void initState() {
    super.initState();
    context.read<CharacterBloc>().add(LoadCharacters());
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
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: BlocBuilder<CharacterBloc, CharacterState>(
        builder: (context, state) {
          if (state is CharacterLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CharacterLoaded) {
            final characters =
                state.data.expand((response) => response.results).toList();

            return ListView.builder(
              itemCount: state.data.length,
              itemBuilder: (context, index) {
                return CharacterCard(
                  character: characters[index],
                  selectedServices: selectedServices,
                );
              },
            );
          } else if (state is CharacterError) {
            return Center(child: Text(state.error));
          }
          return const Center(child: Text('No data available'));
        },
      ),
    );
  }
}
