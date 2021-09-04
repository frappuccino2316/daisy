import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:daisy/models/calendar/calendar_event.dart';
import 'package:daisy/view_models/calendar/calendar_event_view_models.dart';
import 'package:daisy/views/calendar/create_event_page.dart';
import 'package:daisy/views/calendar/edit_event_page.dart';
import 'package:daisy/views/widgets/page_app_bar.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  List<CalendarEvent> _eventListOfSelectedDay = [];

  final _linkedHashMapEvents = LinkedHashMap<DateTime, List<CalendarEvent>>(
    equals: isSameDay,
    hashCode: CalendarEventViewModel().getHashCode,
  )..addAll(CalendarEventViewModel().getMapOfCalendarEvent());

  final CalendarEventViewModel _calendarEventViewModel =
      CalendarEventViewModel();

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    return Scaffold(
      appBar: PageAppBar('カレンダー'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TableCalendar(
              locale: 'ja_JP',
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2100, 12, 31),
              focusedDay: _focusedDay,
              headerStyle: const HeaderStyle(formatButtonVisible: false),
              calendarFormat: _calendarFormat,
              eventLoader: (day) {
                return _calendarEventViewModel.getEventsForDay(
                    day, _linkedHashMapEvents);
              },
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) async {
                if (!isSameDay(_selectedDay, selectedDay)) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                    _eventListOfSelectedDay = _calendarEventViewModel
                        .getEventsForDay(_selectedDay!, _linkedHashMapEvents);
                  });
                } else {
                  final CalendarEvent? calendarEvent =
                      await Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CreateEventPage(_selectedDay!),
                    fullscreenDialog: true,
                  ));
                  if (calendarEvent != null) {
                    CalendarEventViewModel().addCalendarEvent(calendarEvent);
                    setState(() {
                      _eventListOfSelectedDay.add(calendarEvent);
                    });
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
                height: 385.0,
                child: ListView.builder(
                    itemCount: _eventListOfSelectedDay.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 1.0, color: Colors.black),
                          ),
                          child: ListTile(
                            title: Text(_eventListOfSelectedDay[index].title),
                            subtitle:
                                Text(_eventListOfSelectedDay[index].detail),
                            trailing: PopupMenuButton<String>(
                              onSelected: (String selected) {
                                popUpMenuSelected(
                                    selected, _selectedDay!, index);
                              },
                              itemBuilder: (BuildContext context) {
                                return <PopupMenuEntry<String>>[
                                  const PopupMenuItem(
                                    child: Text('編集'),
                                    value: '編集',
                                  ),
                                  const PopupMenuItem(
                                    child: Text('削除'),
                                    value: '削除',
                                  ),
                                ];
                              },
                            ),
                          ),
                        ),
                      );
                    }),
              )
          ],
        ),
      ),
    );
  }

  void popUpMenuSelected(String selected, DateTime day, int index) async {
    CalendarEvent _calendarEvent = _eventListOfSelectedDay[index];

    switch (selected) {
      case '編集':
        final CalendarEvent? calendarEvent =
            await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => EditEventPage(_calendarEvent),
          fullscreenDialog: true,
        ));
        if (calendarEvent != null) {
          setState(() {
            // calendarEvent.title = calendarEvent.title;
            // calendarEvent.detail = calendarEvent.detail;
            // calendarEvent.startDateTime = calendarEvent.startDateTime;
            // calendarEvent.endingDateTime = calendarEvent.endingDateTime;
            // calendarEvent.save();
            _calendarEventViewModel.editCalendarEvent(
                _selectedDay!, index, calendarEvent);
            setState(() {
              _eventListOfSelectedDay = _calendarEventViewModel.getEventsForDay(
                  _selectedDay!, _linkedHashMapEvents);
            });
          });
        }
        break;
      case '削除':
        showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: Text(_calendarEvent.title),
                  content: Text(_calendarEvent.detail),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.delete),
                      color: Colors.red,
                      onPressed: () {
                        CalendarEventViewModel()
                            .deleteCalendarEvent(_selectedDay!, index);
                        setState(() {
                          _eventListOfSelectedDay.removeAt(index);
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ));
        break;

      default:
        break;
    }
  }
}
