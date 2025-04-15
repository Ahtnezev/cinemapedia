import 'package:intl/intl.dart';

class HumanFormats {

  static String number(double number, int decimals) {
    final formatterNumber = NumberFormat.compactCurrency(
      decimalDigits: decimals,
      symbol: '',
      locale: 'es'
    ).format(number);

    return formatterNumber;
  }

}