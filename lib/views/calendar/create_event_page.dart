import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:daisy/models/calendar/calendar_event.dart';
import 'package:daisy/utils/pick_date.dart';
import 'package:daisy/views/widgets/page_app_bar.dart';

class CreateEventPage extends StatefulWidget {
  @override
  _CreateEventPage createState() => _CreateEventPage();
}

class _CreateEventPage extends State<CreateEventPage> {
  String _title = '';
  String _detail = '';
  DateTime _startDateTime = DateTime.now();
  DateTime _endingDateTime = DateTime.now();

  bool _isError = false;

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    return Scaffold(
        appBar: PageAppBar('作成'),
        body: Container(
            padding: const EdgeInsets.all(40.0),
            child: Center(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                    decoration: const InputDecoration(
                      labelText: 'タイトル',
                    ),
                    onChanged: (String text) => _title = text),
                TextField(
                    decoration: const InputDecoration(
                      labelText: '詳細',
                    ),
                    onChanged: (String detail) => _detail = detail),
                Container(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 30.0),
                    // child: Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     Text(DateFormat.yMMMd('ja').format(_startDateTime)),
                    //     ElevatedButton(
                    //       child: const Text('期限を選択'),
                    //       onPressed: () async {
                    //         final _selected = await pickDate(context);
                    //         if (_selected != null) {
                    //           setState(() => _startDateTime = _selected);
                    //         }
                    //       },
                    //     ),
                    //     Text(DateFormat.yMMMd('ja').format(_endingDateTime)),
                    //     ElevatedButton(
                    //       child: const Text('期限を選択'),
                    //       onPressed: () async {
                    //         final _selected = await pickDate(context);
                    //         if (_selected != null) {
                    //           setState(() => _endingDateTime = _selected);
                    //         }
                    //       },
                    //     ),
                    //   ],
                    // ),
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
                  child: const Text('追加'),
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
