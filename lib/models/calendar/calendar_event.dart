import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'calendar_event.g.dart';

@HiveType(typeId: 2)
class CalendarEvent extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String detail;

  @HiveField(2)
  DateTime startDateTime;

  @HiveField(3)
  DateTime endingDateTime;

  CalendarEvent(
      this.title, this.detail, this.startDateTime, this.endingDateTime);

  String toDateStartDateTime() {
    initializeDateFormatting('ja');
    DateFormat format = DateFormat.yMMMd('ja');
    String startDate = format.format(startDateTime);
    return startDate;
  }

  String toDateEndingDateTime() {
    initializeDateFormatting('ja');
    DateFormat format = DateFormat.yMMMd('ja');
    String endingDate = format.format(endingDateTime);
    return endingDate;
  }

  String toHourMinuteStartDateTime() {
    initializeDateFormatting('ja');
    DateFormat format = DateFormat.Hm('ja');
    String startTime = format.format(startDateTime);
    return startTime;
  }

  String toHourMinuteEndingDateTime() {
    initializeDateFormatting('ja');
    DateFormat format = DateFormat.Hm('ja');
    String endingTime = format.format(endingDateTime);
    return endingTime;
  }
}
