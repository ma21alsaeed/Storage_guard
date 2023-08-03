import 'package:intl/intl.dart';
// import 'package:timeago/timeago.dart' as timeago;

import '../constants/date_time_constants.dart';

extension DateTimeHelper on DateTime {
  static DateTime get today => DateTime.now().dateOnly;
  DateTime get dateOnly => DateTime(year, month, day);

  bool get isToday => isSameDate(today);

  bool isSameDate(DateTime other) =>
      year == other.year && month == other.month && day == other.day;

  DateTime shift({
    int? years,
    int? months,
    int? days,
    int? hours,
    int? minutes,
    int? seconds,
    int? milliseconds,
    int? microseconds,
  }) =>
      DateTime(
        year + (years ?? 0),
        month + (months ?? 0),
        day + (days ?? 0),
        hour + (hours ?? 0),
        minute + (minutes ?? 0),
        second + (seconds ?? 0),
        millisecond + (milliseconds ?? 0),
        microsecond + (microseconds ?? 0),
      );

  // String get agoDate {
  //   final now = today;
  //   if (isSameDate(now)) {
  //     return 'اليوم';
  //   } else if (isSameDate(now.shift(days: 1))) {
  //     return 'غداً';
  //   } else if (isSameDate(now.shift(days: -1))) {
  //     return 'البارحة';
  //   }

  //   final ago = agoFrom(now);
  //   if (ago == 'منذ يوم') {
  //     return 'منذ يومين';
  //   }
  //   return ago;
  // }

  // String agoFrom([DateTime? date]) =>
  //     timeago.format(this, allowFromNow: true, clock: date);

  String get formattedDate =>
      DateFormat(DateTimeConstants.dateFormat, 'en').format(this);
  String get formattedDate2 =>
      DateFormat(DateTimeConstants.dateFormat2, 'en').format(this);
  String get formattedDate3 =>
      DateFormat(DateTimeConstants.dateFormat3, 'en').format(this);
  String get formattedDateandTime =>
      DateFormat(DateTimeConstants.dateFormat3WithoutYear, 'en').format(this) +", "+
      DateFormat(DateTimeConstants.timeFormat, 'en').format(this);
  String get formattedTime =>
      DateFormat(DateTimeConstants.timeFormat, 'en').format(this);
  String get formattedDateTime =>
      DateFormat(DateTimeConstants.dateTimeFormat, 'en').format(this);
}
