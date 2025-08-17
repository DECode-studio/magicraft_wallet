import 'dart:async';

import 'package:get/get.dart';

RxString timeStatus() {
  var currentTime = DateTime.now().obs;
  var text = ''.obs;

  Timer.periodic(
    const Duration(seconds: 30),
    (_) => currentTime.value = DateTime.now(),
  );

  if (currentTime.value.hour >= 3 && currentTime.value.hour <= 10) {
    text.value = 'Good Morning';
  } else if (currentTime.value.hour >= 11 && currentTime.value.hour <= 14) {
    text.value = 'Good Day';
  } else if (currentTime.value.hour >= 15 && currentTime.value.hour <= 18) {
    text.value = 'Good Afternoon';
  } else {
    text.value = 'Good Night';
  }

  return '$text, have a nice day!'.obs;
}

bool isWeekend() {
  var date = DateTime.now();
  return date.weekday == DateTime.saturday || date.weekday == DateTime.sunday;
}

bool isOutOfWorkHours() {
  var time = DateTime.now();
  return time.hour >= 17 || time.hour < 8;
}
