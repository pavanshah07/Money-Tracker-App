// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_preferences.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SavedPreferencesAdapter extends TypeAdapter<SavedPreferences> {
  @override
  final int typeId = 1;

  @override
  SavedPreferences read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SavedPreferences(
      fields[0] as String,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SavedPreferences obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.defaultOp)
      ..writeByte(1)
      ..write(obj.currency);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavedPreferencesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
