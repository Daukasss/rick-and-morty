// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CharacterHiveAdapter extends TypeAdapter<CharacterHive> {
  @override
  final int typeId = 0;

  @override
  CharacterHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CharacterHive(
      id: fields[0] as int,
      name: fields[1] as String,
      status: fields[2] as String,
      species: fields[3] as String,
      image: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CharacterHive obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.status)
      ..writeByte(3)
      ..write(obj.species)
      ..writeByte(4)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CharacterHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
