import 'package:hive_flutter/hive_flutter.dart';

import 'package:daisy/models/calendar/calendar_event.dart';

class CalendarEventViewModel {
  final _calendarEventBox = Hive.box('calendar_event');

  List<dynamic> getCalendarEvents() {
    List<dynamic> _calendarEventList = _calendarEventBox.values.toList();
    return _calendarEventList;
  }
}
