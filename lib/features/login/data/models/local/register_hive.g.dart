// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RegisterHiveAdapter extends TypeAdapter<RegisterHive> {
  @override
  final int typeId = 0;

  @override
  RegisterHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RegisterHive(
      email: fields[0] as String?,
      password: fields[1] as String?,
      name: fields[2] as String?,
      noHp: fields[3] as String?,
      id: fields[4] as String?,
      username: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, RegisterHive obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.email)
      ..writeByte(1)
      ..write(obj.password)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.noHp)
      ..writeByte(4)
      ..write(obj.id)
      ..writeByte(5)
      ..write(obj.username);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RegisterHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
