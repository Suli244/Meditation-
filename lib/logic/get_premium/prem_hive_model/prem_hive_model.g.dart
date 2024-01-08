// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prem_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NewPosterModelAdapter extends TypeAdapter<NewPosterModel> {
  @override
  final int typeId = 0;

  @override
  NewPosterModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NewPosterModel(
      secondUrl: fields[0] as String,
      isOpen: fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, NewPosterModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.secondUrl)
      ..writeByte(1)
      ..write(obj.isOpen);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewPosterModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
