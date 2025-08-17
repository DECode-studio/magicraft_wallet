import 'package:magicraft_wallet/service/formater/date.dart';

DateTime minuteOnlyBefore(DateTime date) {
  var time =
      DateTime(date.year, date.month, date.day, date.hour, date.minute - 1);
  return time;
}

DateTime minuteOnlyAfter(DateTime date) {
  var time =
      DateTime(date.year, date.month, date.day, date.hour, date.minute + 1);
  return time;
}

DateTime dateOnly(DateTime date) {
  var time = DateTime(date.year, date.month, date.day);
  return time;
}

DateTime dateOnlyBefore(DateTime date) {
  var time = DateTime(date.year, date.month, date.day - 1);
  return time;
}

DateTime dateOnlyAfter(DateTime date) {
  var time = DateTime(date.year, date.month, date.day + 1);
  return time;
}

String monthYear(dynamic data) {
  var date = monthYearFormater(DateTime.parse(data));
  return date;
}

DateTime? nearestDateTime_1(List<DateTime> dateTimeList) {
  if (dateTimeList.isEmpty) return null;

  DateTime now = DateTime.now();
  return dateTimeList.reduce((a, b) =>
      (a.difference(now).abs().compareTo(b.difference(now).abs()) <= 0)
          ? a
          : b);
}

DateTime nearestDateTime_2(List<DateTime> dateTimeList) {
  DateTime now = DateTime.now();
  DateTime nearest = dateTimeList.first;
  int diff = (nearest.difference(now)).inMilliseconds.abs();

  for (DateTime dt in dateTimeList) {
    int newDiff = (dt.difference(now)).inMilliseconds.abs();
    if (newDiff < diff) {
      diff = newDiff;
      nearest = dt;
    }
  }

  return nearest;
}

DateTime stringToDate(String raw) {
  var data = raw.split('/');
  var date = DateTime(
    int.parse(data[2]),
    int.parse(data[1]),
    int.parse(data[0]),
  );

  return date;
}

int calculateDaysDifference(DateTime targetDate) {
  DateTime now = DateTime.now();
  Duration difference = targetDate.difference(now);
  return difference.inDays + 1;
}
