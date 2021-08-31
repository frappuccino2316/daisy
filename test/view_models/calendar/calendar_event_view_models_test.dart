import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:daisy/models/calendar/calendar_event.dart';
import 'package:daisy/view_models/calendar/calendar_event_view_models.dart';

void main() async {
  await initialiseHive();
  await Hive.openBox('calendar_event');
  group('Test CalendarEventViewModel', () {
    CalendarEventViewModel viewModel = CalendarEventViewModel();

    tearDown(() async {
      // 最後に必ずクリア
      await Hive.deleteFromDisk();
    });

    test('CalendarEventViewModel can write in hive', () {
      CalendarEvent _calendarEvent = CalendarEvent('test1', 'detail test 1',
          DateTime.utc(1996, 2, 15), DateTime.utc(1999, 8, 22));
      viewModel.addCalendarEvent(_calendarEvent);

      List _calendarEventList = viewModel.getAllCalendarEvents();
      expect(_calendarEventList, [_calendarEvent]);
    });
  });
}

Future<void> initialiseHive() async {
  final path = Directory.current.path;
  Hive
    ..init(path)
    ..registerAdapter(CalendarEventAdapter());

  Hive.deleteFromDisk(); // 常に空の状態で開始する
}
