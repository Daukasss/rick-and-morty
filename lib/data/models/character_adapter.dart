import 'package:hive/hive.dart';

part 'character_adapter.g.dart';

@HiveType(typeId: 0)
class CharacterHive extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String status;

  @HiveField(3)
  final String species;

  @HiveField(4)
  final String image;

  CharacterHive({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.image,
  });
}
