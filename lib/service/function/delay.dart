import 'dart:async';

Future<void> syncDelay({
  required int value,
  Function()? func,
}) =>
    Future.delayed(
      Duration(milliseconds: value),
      func,
    );

Timer asyncDelay({
  required int value,
  Function()? func,
}) =>
    Timer(
      Duration(milliseconds: value),
      func ?? () {},
    );
