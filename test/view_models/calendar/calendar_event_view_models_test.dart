import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:daisy/models/calendar/calendar_event.dart';
import 'package:daisy/view_models/calendar/calendar_event_view_models.dart';

void main() async {
  await initialiseHive();

  group('Test CalendarEventViewModel', () {
    tearDown(() async {
      // 最後に必ずクリア
      await Hive.deleteFromDisk();
    });

    test('CalendarEventViewModel can create in hive', () async {
      await Hive.openBox('calendar_event');
      CalendarEventViewModel _viewModel = CalendarEventViewModel();

      CalendarEvent _calendarEvent = CalendarEvent('test1', 'detail test 1',
          DateTime.utc(1996, 2, 15), DateTime.utc(1999, 8, 22));
      _viewModel.addCalendarEvent(_calendarEvent);

      List _calendarEventList = _viewModel.getAllCalendarEvents();
      expect(_calendarEventList, [_calendarEvent]);
    });

    test('CalendarEventViewModel can update in hive', () async {
      await Hive.openBox('calendar_event');
      CalendarEventViewModel _viewModel = CalendarEventViewModel();

      CalendarEvent _calendarEvent = CalendarEvent('test1', 'detail test 1',
          DateTime.utc(1996, 2, 15), DateTime.utc(1999, 8, 22));
      _viewModel.addCalendarEvent(_calendarEvent);

      CalendarEvent _calendarEventFirst = _viewModel.getAllCalendarEvents()[0];
      _calendarEventFirst.title = 'test2';
      _calendarEventFirst.detail = 'detail test 2';
      _calendarEventFirst.startDateTime = DateTime.utc(2000, 1, 1);
      _calendarEventFirst.endingDateTime = DateTime.utc(2000, 12, 31);
      _calendarEventFirst.save();

      // CalendarEvent _calendarEventSecond = CalendarEvent(
      //     'test2',
      //     'detail test 2',
      //     DateTime.utc(1993, 8, 22),
      //     DateTime.utc(1994, 3, 13));
      // _calendarEventList[0] = _calendarEventSecond;

      expect(_viewModel.getAllCalendarEvents()[0].title, 'test2');
      expect(_viewModel.getAllCalendarEvents()[0].detail, 'detail test 2');
      expect(_viewModel.getAllCalendarEvents()[0].startDateTime,
          DateTime.utc(2000, 1, 1));
      expect(_viewModel.getAllCalendarEvents()[0].endingDateTime,
          DateTime.utc(2000, 12, 31));
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
