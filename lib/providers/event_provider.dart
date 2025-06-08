import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/event_model.dart';

class EventProvider with ChangeNotifier {
  late Box<Event> _eventsBox;

  EventProvider() {
    _initBox();
  }

  Future<void> _initBox() async {
    _eventsBox = Hive.box<Event>('events');
  }

  List<Event> get eventos => _eventsBox.values.toList();

  Future<void> agregarEvento(Event evento) async {
    await _eventsBox.put(evento.id, evento);
    notifyListeners();
  }
}
