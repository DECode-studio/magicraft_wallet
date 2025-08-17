import 'package:intl/intl.dart';

final idrMoney = NumberFormat("#,##0", "id_ID");
final idrMoney_2 = NumberFormat("#,##0", "id_ID");

var millionNominal = 1000000;
var billionNominal = 1000000000;

String moneyFormatter(int amount) {
  // if (amount > billionNominal) {
  //   return "IDR ${idrMoney.format(amount / billionNominal)} B";
  // } else if (amount > millionNominal) {
  //   return "IDR ${idrMoney.format(amount / millionNominal)} M";
  // } else {
  //   return "IDR ${idrMoney.format(amount)}";
  // }

  return "IDR ${idrMoney.format(amount)}";
}

String moneyFormatter_2(int amount) {
  if (amount > billionNominal) {
    return "IDR ${idrMoney.format(amount / billionNominal)} B";
  } else if (amount > millionNominal) {
    return "IDR ${idrMoney.format(amount / millionNominal)} M";
  } else {
    return "IDR ${idrMoney.format(amount)}";
  }
}

NumberFormat moneyFormatter_3 = NumberFormat.compactCurrency(
  decimalDigits: 2,
  locale: 'id_ID',
  name: 'IDR ',
);
