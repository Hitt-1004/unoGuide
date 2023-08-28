import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:unoquide/common/NavbarItems/calendar/events.dart' as even;
import 'package:http/http.dart' as http;

class EventProvider extends ChangeNotifier {
  List<even.Events> _events = [];

  List<even.Events> get events => _events;

  void addEvent(even.Events event) {
    _events.add(event);
    notifyListeners();
  }
}
