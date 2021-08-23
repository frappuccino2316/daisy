import 'package:daisy/models/calendar/calendar_event.dart';

class CalendarEventRepository {
  CalendarEventBox? _calendarEventBox;

  CalendarEventRepository(CalendarEventBox calendarEventBox) {
    _calendarEventBox = calendarEventBox;
  }

  Future<void> save(CalendarEvent calendarEvent) async {
    final box = await _calendarEventBox!.box;
    await box.add(calendarEvent);
  }

  Future<List<CalendarEvent>> fetchAll() async {
    final box = await _calendarEventBox!.box;
    List<dynamic> list = box.values.toList();
    List<CalendarEvent> calendarEventList = [];
    for (var event in list) {
      calendarEventList.add(event);
    }
    return calendarEventList;
  }
}
