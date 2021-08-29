import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:daisy/models/calendar/calendar_event.dart';
import 'package:daisy/utils/pick_date.dart';
import 'package:daisy/views/widgets/page_app_bar.dart';

class EditEventPage extends StatefulWidget {
  final CalendarEvent calendarEvent;

  const EditEventPage(this.calendarEvent);

  @override
  _EditEventPage createState() => _EditEventPage();
}

class _EditEventPage extends State<EditEventPage> {
  String _title = '';
  String _detail = '';
  DateTime _startDateTime = DateTime.now();
  DateTime _endingDateTime = DateTime.now();

  bool _isError = false;

  @override
  void initState() {
    super.initState();
    _title = widget.calendarEvent.title;
    _detail = widget.calendarEvent.detail;
    _startDateTime = widget.calendarEvent.startDateTime;
    _endingDateTime = widget.calendarEvent.endingDateTime;
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    return Scaffold(
        appBar: PageAppBar('編集'),
        body: Container(
            padding: const EdgeInsets.all(40.0),
            child: Center(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                    controller:
                        TextEditingController(text: widget.calendarEvent.title),
                    decoration: const InputDecoration(
                      labelText: 'タイトル',
                    ),
                    onChanged: (String text) => _title = text),
                TextField(
                    controller: TextEditingController(
                        text: widget.calendarEvent.detail),
                    decoration: const InputDecoration(
                      labelText: '詳細',
                    ),
                    onChanged: (String detail) => _detail = detail),
                Container(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 30.0),
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(DateFormat.yMMMd('ja').format(_startDateTime)),
                          ElevatedButton(
                            child: const Text('期限を選択'),
                            onPressed: () async {
                              final _selected = await pickDate(context);
                              if (_selected != null) {
                                setState(() => _startDateTime = _selected);
                              }
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(DateFormat.yMMMd('ja').format(_endingDateTime)),
                          ElevatedButton(
                            child: const Text('期限を選択'),
                            onPressed: () async {
                              final _selected = await pickDate(context);
                              if (_selected != null) {
                                setState(() => _endingDateTime = _selected);
                              }
                            },
                          ),
                        ],
                      )
                    ])),
                if (_isError) const Text('全ての項目を設定してください'),
                ElevatedButton(
                  child: const Text('更新'),
                  onPressed: () {
                    if (_title == '' || _detail == '') {
                      setState(() => _isError = true);
                    } else {
                      Navigator.pop(
                          context,
                          CalendarEvent(_title, _detail, _startDateTime,
                              _endingDateTime));
                    }
                  },
                ),
              ],
            ))));
  }
}
