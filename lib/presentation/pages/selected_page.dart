import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../config/bloc/cubit/theme_cubit.dart';
import '../../data/repasitory/selected_services.dart';

class SelectedPage extends StatefulWidget {
  const SelectedPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SelectedPageState createState() => _SelectedPageState();
}

class _SelectedPageState extends State<SelectedPage> {
  final SelectedServices _favoriteService = SelectedServices();

  @override
  Widget build(BuildContext context) {
    final favorites = _favoriteService.getFavorites();
    final isDark = context.watch<ThemeCubit>().state.isDark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Selected person'),
        actions: [
          Switch(
            value: isDark,
            onChanged: (value) {
              _setTheme(context, value);
            },
            focusColor: Colors.grey,
            activeColor: const Color.fromARGB(255, 0, 205, 7),
          )
        ],
      ),
      body: favorites.isEmpty
          ? const Center(child: Text("NOt selected person"))
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final character = favorites[index];
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  elevation: 5,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(character.image,
                          height: 50, width: 50, fit: BoxFit.cover),
                    ),
                    title: Text(character.name),
                    subtitle: Text(character.species),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          _favoriteService.removeFromFavorites(character.id);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }

  void _setTheme(BuildContext context, bool value) {
    context
        .read<ThemeCubit>()
        .setTheme(value ? Brightness.dark : Brightness.light);
  }
}
