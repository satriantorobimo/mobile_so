import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GeneralUtil {
  static String convertToIdr(dynamic number, int decimalDigit) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(number.abs());
  }

  void showSnackBarError(BuildContext context, String msg) {
    final snackBar = SnackBar(
      content: Text(msg),
      backgroundColor: Colors.redAccent,
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showSnackBarSuccess(BuildContext context, String msg) {
    final snackBar = SnackBar(
      content: Text(msg),
      backgroundColor: Colors.green,
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static String dateConvert(String data) {
    DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(data);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('yyyy-MM-dd');
    var outputDate = outputFormat.format(inputDate);

    return outputDate;
  }

  static String dateConvertNow(String data) {
    DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(data);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('yyyy-MM-dd');
    var outputDate = outputFormat.format(inputDate);

    return outputDate;
  }

  static String dateConvertCalendar(String data) {
    DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss.sss'Z'").parse(data);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('yyyy-MM-dd');
    var outputDate = outputFormat.format(inputDate);

    return outputDate;
  }
}
