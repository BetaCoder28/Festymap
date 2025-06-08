import 'package:hive/hive.dart';

part 'event_model.g.dart';

@HiveType(typeId: 1)
class Event {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String titulo;

  @HiveField(2)
  final String lugar;

  @HiveField(3)
  final String imagen;

  @HiveField(4)
  final String calle;

  @HiveField(5)
  final String numero;

  @HiveField(6)
  final String ciudad;

  @HiveField(7)
  final String estado;

  @HiveField(8)
  final String fecha;

  @HiveField(9)
  final String hora;

  @HiveField(10)
  final double latitud;

  @HiveField(11)
  final double longitud;

  Event({
    required this.id,
    required this.titulo,
    required this.lugar,
    required this.imagen,
    required this.calle,
    required this.numero,
    required this.ciudad,
    required this.estado,
    required this.fecha,
    required this.hora,
    required this.latitud,
    required this.longitud,
  });
}
