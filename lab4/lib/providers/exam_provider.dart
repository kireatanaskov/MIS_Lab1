import 'package:flutter/foundation.dart';

import '../models/exam.dart';

class ExamProvider with ChangeNotifier {
  final List<Exam> _events = [];

  List<Exam> get events => _events;

  void addEvent(Exam event) {
    _events.add(event);
    notifyListeners();
  }

  List<Exam> getEventsForDay(DateTime day) {
    return _events
        .where((event) =>
            event.dateTime.year == day.year &&
            event.dateTime.month == day.month &&
            event.dateTime.day == day.day)
        .toList();
  }
}
