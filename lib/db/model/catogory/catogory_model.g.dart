// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catogory_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CatogoryModelAdapter extends TypeAdapter<CatogoryModel> {
  @override
  final int typeId = 0;

  @override
  CatogoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CatogoryModel(
      id: fields[0] as String,
      name: fields[1] as String,
      type: fields[3] as CatogoryType,
      isDeleted: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, CatogoryModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.isDeleted)
      ..writeByte(3)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CatogoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CatogoryTypeAdapter extends TypeAdapter<CatogoryType> {
  @override
  final int typeId = 1;

  @override
  CatogoryType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return CatogoryType.income;
      case 1:
        return CatogoryType.expense;
      case 2:
        return CatogoryType.undifined;
      default:
        return CatogoryType.income;
    }
  }

  @override
  void write(BinaryWriter writer, CatogoryType obj) {
    switch (obj) {
      case CatogoryType.income:
        writer.writeByte(0);
        break;
      case CatogoryType.expense:
        writer.writeByte(1);
        break;
      case CatogoryType.undifined:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CatogoryTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
