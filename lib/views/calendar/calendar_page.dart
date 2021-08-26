import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:daisy/models/calendar/calendar_event.dart';
import 'package:daisy/view_models/calendar/calendar_event_view_models.dart';
import 'package:daisy/views/calendar/create_event_page.dart';
import 'package:daisy/views/widgets/page_app_bar.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final _linkedHashMapevents = LinkedHashMap<DateTime, List<CalendarEvent>>(
    equals: isSameDay,
    hashCode: CalendarEventViewModel().getHashCode,
  )..addAll(CalendarEventViewModel().getMapOfCalendarEvent());

  List<CalendarEvent> _getEventsForDay(DateTime day) {
    return _linkedHashMapevents[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    return Scaffold(
      appBar: PageAppBar('カレンダー'),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2100, 12, 31),
            focusedDay: _focusedDay,
            headerStyle: const HeaderStyle(formatButtonVisible: false),
            calendarFormat: _calendarFormat,
            eventLoader: (day) {
              return _getEventsForDay(day);
            },
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) async {
              if (!isSameDay(_selectedDay, selectedDay)) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              } else {
                final CalendarEvent? calendarEvent =
                    await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CreateEventPage(),
                  fullscreenDialog: true,
                ));
                if (calendarEvent != null) {
                  CalendarEventViewModel().addCalendarEvent(calendarEvent);
                  setState(() {});
                }
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            calendarBuilders: CalendarBuilders(
              dowBuilder: (context, day) {
                if (day.weekday == DateTime.saturday) {
                  final text = DateFormat.E().format(day);
                  return Center(
                    child: Text(
                      text,
                      style: const TextStyle(color: Colors.blue),
                    ),
                  );
                }

                if (day.weekday == DateTime.sunday) {
                  final text = DateFormat.E().format(day);
                  return Center(
                    child: Text(
                      text,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }
              },
            ),
          ),
          if (_selectedDay != null)
            SizedBox(
              height: 200.0,
              child: ListView.builder(
                  itemCount: _getEventsForDay(_selectedDay!).length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 1.0, color: Colors.black),
                        ),
                        child: ListTile(
                          title: Text(
                              _getEventsForDay(_selectedDay!)[index].title),
                          subtitle: Text(
                              _getEventsForDay(_selectedDay!)[index].detail),
                          // Todo POPupMenuButtonをコンポーネント化して別PRで作る
                          // trailing: PopupMenuButton<String>(
                          //   onSelected: (String selected) {
                          //     popUpMenuSelected(selected, index);
                          //   },
                          //   itemBuilder: (BuildContext context) {
                          //     return <PopupMenuEntry<String>>[
                          //       const PopupMenuItem(
                          //         child: Text('編集'),
                          //         value: '編集',
                          //       ),
                          //       const PopupMenuItem(
                          //         child: Text('削除'),
                          //         value: '削除',
                          //       ),
                          //     ];
                          //   },
                          // ),
                        ),
                      ),
                    );
                  }),
            )
        ],
      ),
    );
  }
}
