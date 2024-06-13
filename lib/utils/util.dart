import 'package:flutter/material.dart';

class Util {
  static String formatDate(DateTime date) {
    return "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  static String formatTime(TimeOfDay time) {
    String period = time.period == DayPeriod.am ? "am" : "pm";
    return "${time.hourOfPeriod.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}$period";
  }
}
