

import 'package:intl/intl.dart';

class CommonCalendar {
  static List<String> monthsList = [
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
  ];

  static DateTime startDate = DateTime(2023,07,01);
  static DateTime endDate = DateTime(2024,07,01);

  static int currentYear = int.parse(DateFormat('yyyy').format(DateTime.now()));
  static int currentMonth = int.parse(DateFormat('MM').format(DateTime.now()));
  static List currentSessionYear = [];

}

getCurrentSessionYear() {
  if(CommonCalendar.currentMonth < 6) {
    CommonCalendar.currentSessionYear = [CommonCalendar.currentYear -1,CommonCalendar.currentYear];
  } else {
    CommonCalendar.currentSessionYear = [CommonCalendar.currentYear,CommonCalendar.currentYear+1];
  }
}

int selectCorrectMonthIndex(int currentMonth) {
  if(currentMonth >= 6) {
    print("Enter 1");
    return currentMonth - 7;
  } else {
    print("Enter 0");
    return currentMonth + 6;
  }
}

String selectMonthByIndex(int index) {
  if(index > 7) {
    return (index - 5).toString();
  } else {
    return (index + 7).toString();
  }
}

int selectYearByMonth({required String month}) {
  int curMonth = int.parse(month);

  if(curMonth > 7)
      {
    // print(enter);
    return CommonCalendar.currentSessionYear[0];
  } else {
    // print(enter);
    return CommonCalendar.currentSessionYear[1];
  }
}

List getMonthDays({required int year, required String month}) {
  int curMonth = int.parse(month);

  int numberOfDayInMonth = DateTime(year,curMonth + 1, 0).day;
  print("numberOfDayInMonth: $numberOfDayInMonth");

  List daysInMonth = List<int>.generate(numberOfDayInMonth, (i) => i + 1);
  print("Number of days in June 2024: $daysInMonth");

  return daysInMonth ;
}