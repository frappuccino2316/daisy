// import 'dart:collection';
// import 'package:table_calendar/table_calendar.dart';

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
    // list.forEach((model) => recordList.add(CalendarEvent(model)));
    for (var event in list) {
      calendarEventList.add(event);
    }
    return calendarEventList;
  }
}

// final _calendarEvent = Hive.box('calendar_event');

// final calendarEvents = LinkedHashMap<DateTime, List<CalendarEvent>>(
//   equals: isSameDay,
//   hashCode: getHashCode,
//   // calendarEventSourceはhiveから取得する
// )..addAll(calendarEventSource);

// final _kEventSource = Map.fromIterable(List.generate(50, (index) => index),
//     key: (item) => DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5),
//     value: (item) => List.generate(
//         item % 4 + 1, (index) => CalendarEvent('CalendarEvent $item | ${index + 1}')))
//   ..addAll({
//     kToday: [
//       CalendarEvent('Today\'s CalendarEvent 1'),
//       CalendarEvent('Today\'s CalendarEvent 2'),
//     ],
//   });

// int getHashCode(DateTime key) {
//   return key.day * 1000000 + key.month * 10000 + key.year;
// }

// final kToday = DateTime.now();
// final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
// final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
