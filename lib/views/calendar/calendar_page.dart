import 'package:daisy/view_models/calendar/calendr_event_view_models.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:daisy/views/widgets/page_app_bar.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  // List<dynamic> events = CalendarEventViewModel().getCalendarEvents();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    return Scaffold(
      appBar: PageAppBar('カレンダー'),
      body: TableCalendar(
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2100, 12, 31),
        focusedDay: _focusedDay,
        headerStyle: const HeaderStyle(formatButtonVisible: false),
        calendarFormat: _calendarFormat,
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          if (!isSameDay(_selectedDay, selectedDay)) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) => SimpleDialog(
                  title: Text(DateFormat.yMMMd('ja').format(_selectedDay!)),
                  children: <Widget>[
                    SimpleDialogOption(
                      onPressed: () {},
                      child: const Text('Test1'),
                    ),
                    SimpleDialogOption(
                      onPressed: () {},
                      child: const Text('Test2'),
                    ),
                  ]),
            );
          }
        },
        // onFormatChanged: (format) {
        //   if (_calendarFormat != format) {
        //     setState(() {
        //       _calendarFormat = format;
        //     });
        //   }
        // },
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },
      ),
    );
  }
}
