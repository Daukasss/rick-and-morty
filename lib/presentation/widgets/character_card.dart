import 'package:flutter/material.dart';
import '../../data/models/character_adapter.dart';
import '../../data/models/rick_models.dart';
import '../../data/repasitory/selected_services.dart';

class CharacterCard extends StatefulWidget {
  final Character character;
  final SelectedServices selectedServices;
  const CharacterCard({
    super.key,
    required this.character,
    required this.selectedServices,
  });
  @override
  // ignore: library_private_types_in_public_api
  _CharacterCardState createState() => _CharacterCardState();
}

class _CharacterCardState extends State<CharacterCard> {
  late bool isFavorite;
  @override
  void initState() {
    super.initState();
    isFavorite = widget.selectedServices.isFavorite(widget.character.id);
  }

  void _saveFavorite() {
    setState(() {
      if (isFavorite) {
        widget.selectedServices.removeFromFavorites(widget.character.id);
      } else {
        widget.selectedServices.addToFavorites(CharacterHive(
          id: widget.character.id,
          name: widget.character.name,
          status: widget.character.status,
          species: widget.character.species,
          image: widget.character.image,
        ));
      }
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(
                widget.character.image,
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.character.name,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.circle,
                          color: _getStatusColor(widget.character.status),
                          size: 10),
                      const SizedBox(width: 6),
                      Text(widget.character.status),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red),
              onPressed: _saveFavorite,
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "alive":
        return Colors.green;
      case "dead":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
