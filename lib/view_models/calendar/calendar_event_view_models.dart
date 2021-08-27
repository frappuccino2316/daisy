import 'dart:collection';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:daisy/models/calendar/calendar_event.dart';

class CalendarEventViewModel {
  final _calendarEventBox = Hive.box('calendar_event');

  List<dynamic> getAllCalendarEvents() {
    List<dynamic> _calendarEventList = _calendarEventBox.values.toList();
    return _calendarEventList;
  }

  Map<DateTime, List<CalendarEvent>> getMapOfCalendarEvent() {
    final List<dynamic> events = getAllCalendarEvents();
    Map<DateTime, List<CalendarEvent>> map = {};

    for (CalendarEvent event in events) {
      if (map.containsKey(event.startDateTime)) {
        map[event.startDateTime]!.add(event);
      } else {
        map[event.startDateTime] = [event];
      }
    }
    return map;
  }

  List<CalendarEvent> getEventsForDay(DateTime day,
      LinkedHashMap<DateTime, List<CalendarEvent>> linkedHashMapEvents) {
    return linkedHashMapEvents[day] ?? [];
  }

  void addCalendarEvent(CalendarEvent calendarEvent) async {
    await _calendarEventBox.add(calendarEvent);
  }

  void deleteCalendarEvent(int index) async {
    await _calendarEventBox.deleteAt(index);
  }

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }
}
