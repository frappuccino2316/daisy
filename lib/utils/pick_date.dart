import 'package:flutter/material.dart';

void pickDate(BuildContext context, setStateFunc, DateTime dateTimeState,
    [DateTime? deadLine]) async {
  DateTime initial;
  if (deadLine == null) {
    initial = DateTime.now();
  } else {
    initial = deadLine;
  }

  final DateTime? selected = await showDatePicker(
    context: context,
    initialDate: initial,
    firstDate: DateTime(2021),
    lastDate: DateTime(2050),
  );
  if (selected != null) {
    setStateFunc(() {
      dateTimeState = selected;
    });
  }
}
