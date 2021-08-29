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

  List<dynamic> getSelectedDayEventList(Box<dynamic> box, DateTime day) {
    Box<dynamic> _box = box;
    List<dynamic> _selectedDayEvent = [];

    for (CalendarEvent event in _box.values) {
      if (event.startDateTime == day) _selectedDayEvent.add(event);
    }

    return _selectedDayEvent;
  }

  List<CalendarEvent> getEventsForDay(DateTime day,
      LinkedHashMap<DateTime, List<CalendarEvent>> linkedHashMapEvents) {
    return linkedHashMapEvents[day] ?? [];
  }

  void addCalendarEvent(CalendarEvent calendarEvent) async {
    await _calendarEventBox.add(calendarEvent);
  }

  void editCalendarEvent(
      DateTime day, int index, CalendarEvent calendarEvent) async {
    Box<dynamic> _box = Hive.box('calendar_event');
    CalendarEvent _eventInBox = getSelectedDayEventList(_box, day)[index];
    _eventInBox.title = calendarEvent.title;
    _eventInBox.detail = calendarEvent.detail;
    _eventInBox.startDateTime = calendarEvent.startDateTime;
    _eventInBox.endingDateTime = calendarEvent.endingDateTime;
    _eventInBox.save();
  }

  void deleteCalendarEvent(DateTime day, int index) async {
    Box<dynamic> _box = Hive.box('calendar_event');
    List<dynamic> _events = getSelectedDayEventList(_box, day);
    _events[index].delete();
  }

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }
}
