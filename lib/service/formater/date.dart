import 'package:intl/intl.dart';
import 'package:universal_io/io.dart';

String dateDayTimeFormater(time) {
  var dateFormat = DateFormat('EE, dd MMMM yyyy HH:mm', Platform.localeName);

  if (time.runtimeType == DateTime) {
    return dateFormat.format(time);
  } else {
    return dateFormat.format(DateTime.parse(time));
  }
}

String dateDayFormater(time) {
  var dateFormat = DateFormat('EE, dd MMMM yyyy', Platform.localeName);

  if (time.runtimeType == DateTime) {
    return dateFormat.format(time);
  } else {
    return dateFormat.format(DateTime.parse(time));
  }
}

String dateDayFullFormater(time) {
  var dateFormat = DateFormat('EE, dd MMMM yyyy', Platform.localeName);

  if (time.runtimeType == DateTime) {
    return dateFormat.format(time);
  } else {
    return dateFormat.format(DateTime.parse(time));
  }
}

String dateDayFormaterHalf(time) {
  var dateFormat = DateFormat('EE, dd MMM yyyy', Platform.localeName);

  if (time.runtimeType == DateTime) {
    return dateFormat.format(time);
  } else {
    return dateFormat.format(DateTime.parse(time));
  }
}

String dateFormater(time) {
  var dateFormat = DateFormat('dd MMMM yyyy', Platform.localeName);

  if (time.runtimeType == DateTime) {
    return dateFormat.format(time);
  } else {
    return dateFormat.format(DateTime.parse(time));
  }
}

String monotonDateFormater(time) {
  var dateFormat = DateFormat('yyyy-MM-dd', Platform.localeName);

  if (time.runtimeType == DateTime) {
    return dateFormat.format(time);
  } else {
    return dateFormat.format(DateTime.parse(time));
  }
}

String dateTimeFormater(time) {
  var dateFormat = DateFormat('dd/MM/yyyy HH:mm', Platform.localeName);

  if (time.runtimeType == DateTime) {
    return dateFormat.format(time);
  } else {
    return dateFormat.format(DateTime.parse(time));
  }
}

String dayToTimeFormater(time_1, time_2) {
  var dateFormat_1 = DateFormat('EEEE HH:mm', Platform.localeName);
  var dateFormat_2 = DateFormat('EEEE HH:mm', Platform.localeName);

  return '${dateFormat_1.format(time_1)} - ${dateFormat_2.format(time_2)}';
}

String datetoDateFormater(time_1, time_2) {
  var dateFormat_1 = DateFormat('dd/MM/yyyy');
  var dateFormat_2 = DateFormat('dd/MM/yyyy');

  return '${dateFormat_1.format(time_1)} - ${dateFormat_2.format(time_2)}';
}

String monthToMonthYearFormater(time_1, time_2) {
  var dateFormat = DateFormat('MMMM yyyy');

  return '${dateFormat.format(time_1)} - ${dateFormat.format(time_2)}';
}

String datetoDateFormater_2(time_1, time_2) {
  var dateFormat_1 = DateFormat('EE, dd MMM yyyy', Platform.localeName);
  var dateFormat_2 = DateFormat('EE, dd MMM yyyy', Platform.localeName);

  return '${dateFormat_1.format(time_1)} - ${dateFormat_2.format(time_2)}';
}

String datetoDateFormater_2_newLine(time_1, time_2) {
  var dateFormat_1 = DateFormat('dd MMM', Platform.localeName);
  var dateFormat_2 = DateFormat('dd MMM yyyy', Platform.localeName);

  return '${dateFormat_1.format(time_1)} - ${dateFormat_2.format(time_2)}';
}

String datetoDateFormater_3(time_1, time_2) {
  var dateFormat_1 = DateFormat('EE, dd MMM yyyy  HH:mm', Platform.localeName);
  var dateFormat_2 = DateFormat('EE, dd MMM yyyy  HH:mm', Platform.localeName);

  return '${dateFormat_1.format(time_1)} - ${dateFormat_2.format(time_2)}';
}

String timeFormater(time) {
  var dateFormat = DateFormat('HH:mm', Platform.localeName);

  if (time.runtimeType == DateTime) {
    return dateFormat.format(time);
  } else {
    return dateFormat.format(DateTime.parse(time));
  }
}

String dayFormater(time) {
  var dateFormat = DateFormat('dd', Platform.localeName);

  if (time.runtimeType == DateTime) {
    return dateFormat.format(time);
  } else {
    return dateFormat.format(DateTime.parse(time));
  }
}

String monthFullFormater(time) {
  var dateFormat = DateFormat('MMMM', Platform.localeName);

  if (time.runtimeType == DateTime) {
    return dateFormat.format(time);
  } else {
    return dateFormat.format(DateTime.parse(time));
  }
}

String monthFormater(time) {
  var dateFormat = DateFormat('MMM', Platform.localeName);

  if (time.runtimeType == DateTime) {
    return dateFormat.format(time);
  } else {
    return dateFormat.format(DateTime.parse(time));
  }
}

String monthYearFormater(time) {
  var dateFormat = DateFormat('MMM yy', Platform.localeName);

  if (time.runtimeType == DateTime) {
    return dateFormat.format(time);
  } else {
    return dateFormat.format(DateTime.parse(time));
  }
}

String dayMonthFormater(time) {
  var dateFormat = DateFormat('dd MMM', Platform.localeName);

  if (time.runtimeType == DateTime) {
    return dateFormat.format(time);
  } else {
    return dateFormat.format(DateTime.parse(time));
  }
}

String yearFormater(time) {
  var dateFormat = DateFormat('yyyy', Platform.localeName);

  if (time.runtimeType == DateTime) {
    return dateFormat.format(time);
  } else {
    return dateFormat.format(DateTime.parse(time));
  }
}
