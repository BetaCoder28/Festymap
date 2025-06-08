// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EventAdapter extends TypeAdapter<Event> {
  @override
  final int typeId = 1;

  @override
  Event read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Event(
      id: fields[0] as String,
      titulo: fields[1] as String,
      lugar: fields[2] as String,
      imagen: fields[3] as String,
      calle: fields[4] as String,
      numero: fields[5] as String,
      ciudad: fields[6] as String,
      estado: fields[7] as String,
      fecha: fields[8] as String,
      hora: fields[9] as String,
      latitud: fields[10] as double,
      longitud: fields[11] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Event obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.titulo)
      ..writeByte(2)
      ..write(obj.lugar)
      ..writeByte(3)
      ..write(obj.imagen)
      ..writeByte(4)
      ..write(obj.calle)
      ..writeByte(5)
      ..write(obj.numero)
      ..writeByte(6)
      ..write(obj.ciudad)
      ..writeByte(7)
      ..write(obj.estado)
      ..writeByte(8)
      ..write(obj.fecha)
      ..writeByte(9)
      ..write(obj.hora)
      ..writeByte(10)
      ..write(obj.latitud)
      ..writeByte(11)
      ..write(obj.longitud);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
