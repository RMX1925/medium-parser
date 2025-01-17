// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_modal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ResponseBodyAdapter extends TypeAdapter<ResponseBody> {
  @override
  final int typeId = 0;

  @override
  ResponseBody read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ResponseBody(
      id: fields[0] as String,
      title: fields[4] as String,
      url: fields[5] as String,
      description: fields[6] as String,
      response: fields[1] as String,
      statusCode: fields[2] as int,
      disableJavascript: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ResponseBody obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.response)
      ..writeByte(2)
      ..write(obj.statusCode)
      ..writeByte(3)
      ..write(obj.disableJavascript)
      ..writeByte(4)
      ..write(obj.title)
      ..writeByte(5)
      ..write(obj.url)
      ..writeByte(6)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResponseBodyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
