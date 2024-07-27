

import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CommonCalendar {

  static int calendarStartMonth = 4;
  static int yearsLength = 7;

  // static List<String> monthsList = [
  //   "July",
  //   "August",
  //   "September",
  //   "October",
  //   "November",
  //   "December",
  //   "January",
  //   "February",
  //   "March",
  //   "April",
  //   "May",
  //   "June",
  // ];

  static List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];

  static List<String> monthsList = [];
  static List<int> yearsList = [];

  static DateTime? startDate;
  static DateTime? endDate;

  static int currentYear = int.parse(DateFormat('yyyy').format(DateTime.now()));
  static int currentMonth = int.parse(DateFormat('MM').format(DateTime.now()));
  static List currentSessionYear = [];

  static String currentDate = '';
  static String yesterdayDate = '';
  static String tommorrowdayDate = '';
}

getYearsList() {
  int currentYear = DateTime.now().year;
  int yearsLength = 7;

  List<int> yearList = [];

  CommonCalendar.yearsList.clear();
  int startYear = currentYear - ((yearsLength - 1) / 2).floor();

  for (int i = 0; i < yearsLength; i++) {
    yearList.add(startYear + i);
  }
  CommonCalendar.yearsList = yearList;
  print("yearList : $yearList");
}

getCurrentSessionYear() {
  if(CommonCalendar.currentMonth >= CommonCalendar.calendarStartMonth) {
    print("enter currentSessionYear");

    CommonCalendar.currentSessionYear = [CommonCalendar.currentYear,CommonCalendar.currentYear+1];
    CommonCalendar.startDate =  DateTime(CommonCalendar.currentYear,CommonCalendar.calendarStartMonth,01);
    CommonCalendar.endDate =  DateTime(CommonCalendar.currentYear + 1,CommonCalendar.calendarStartMonth - 1,30);
    print(CommonCalendar.startDate);
    print(CommonCalendar.endDate);
  } else {
    CommonCalendar.currentSessionYear = [CommonCalendar.currentYear -1,CommonCalendar.currentYear];
    CommonCalendar.startDate =  DateTime(CommonCalendar.currentYear-1,CommonCalendar.calendarStartMonth,01);
    CommonCalendar.endDate =  DateTime(CommonCalendar.currentYear,CommonCalendar.calendarStartMonth - 1,30);
  }
}

monthAdjust() {
  List<String> modifyMonthList = [];

  for(int i = CommonCalendar.calendarStartMonth - 1; i <= 11; i++) {
   String monthName = CommonCalendar.months[i];
   modifyMonthList.add(monthName);
  }
  print("modifyMonthList $modifyMonthList");

  for(int i = 0; i <= CommonCalendar.calendarStartMonth - 2; i++) {
    String monthName = CommonCalendar.months[i];
    modifyMonthList.add(monthName);
  }
  print("modifyMonthList $modifyMonthList");
  CommonCalendar.monthsList = modifyMonthList;
}

// 7
// int selectCorrectMonthIndex(int currentMonth) {
//   if(currentMonth >= 7) {
//     print("Enter 1");
//     return currentMonth - 7;
//   } else {
//     print("Enter 0");
//     return currentMonth + 5;
//   }
// }

// 6
// int selectCorrectMonthIndex(int currentMonth) {
//   if(currentMonth >= CommonCalendar.calendarStartMonth) {
//     print("Enter 1");
//     return currentMonth - 6;
//   } else {
//     print("Enter 0");
//     return currentMonth + 6;
//   }
// }


// 4
int selectCorrectMonthIndex(int currentMonth) {
  if(currentMonth >= 4) {
    print("Enter 1");
    return currentMonth - 4;
  } else {
    print("Enter 0");
    return currentMonth + 8;
  }
}

// 7
// String selectMonthByIndex(int index) {
//   // print("Enter $index");
//
//   if(index < 6) {
//     // print("Enter 111");
//     return (index + 7).toString();
//   } else {
//     // print("Enter 000");
//     return (index - 5).toString();
//   }
// }


// 6
// String selectMonthByIndex(int index) {
//   print("Enter index $index");
//
//   if(index < CommonCalendar.calendarStartMonth + 1) {
//     print("Enter 111");
//     return (index + 6).toString();
//   } else {
//     print("Enter 000");
//     return (index - 6).toString();
//   }
// }

// 4
String selectMonthByIndex(int index) {
  print("Enter index $index");

  if(index < CommonCalendar.calendarStartMonth + 5) {
    print("Enter 111");
    return (index + 4).toString();
  } else {
    print("Enter 000");
    return (index - 8).toString();
  }
}

// int selectYearByMonth({required String month}) {
//   int curMonth = int.parse(month);
//
//   if(curMonth >= 7) {
//     print("Enter 1");
//     return CommonCalendar.currentSessionYear[0];
//   } else {
//     print("Enter 0");
//     return CommonCalendar.currentSessionYear[1];
//   }
// }


// 6
int selectYearByMonth({required String month}) {
  int curMonth = int.parse(month);
  print("curMonth : $curMonth");

  if(curMonth >= CommonCalendar.calendarStartMonth) {
    print("Enter 1");
    return CommonCalendar.currentSessionYear[0];
  } else {
    print("Enter 0");
    return CommonCalendar.currentSessionYear[1];
  }
}

getDate() {
  var currentDate = DateTime.now();
  var tomorrowDate = currentDate.add(Duration(days: 1));
  var yesterdayDate = currentDate.subtract(Duration(days: 1));

  CommonCalendar.currentDate =  "${currentDate.year}-${currentDate.month.toString().padLeft(2, '0')}-${currentDate.day.toString().padLeft(2, '0')}";
  CommonCalendar.yesterdayDate =  "${yesterdayDate.year}-${yesterdayDate.month.toString().padLeft(2, '0')}-${yesterdayDate.day.toString().padLeft(2, '0')}";
  CommonCalendar.tommorrowdayDate = "${tomorrowDate.year}-${tomorrowDate.month.toString().padLeft(2, '0')}-${tomorrowDate.day.toString().padLeft(2, '0')}";

}


List getMonthDays({required int year, required String month}) {
  int curMonth = int.parse(month);

  int numberOfDayInMonth = DateTime(year,curMonth + 1, 0).day;
  print("numberOfDayInMonth: $numberOfDayInMonth");

  List daysInMonth = List<int>.generate(numberOfDayInMonth, (i) => i + 1);
  print("Number of days in June 2024: $daysInMonth");

  return daysInMonth ;
}

//
// int selectCorrectMonthIndex(int currentMonth) {
//   if(currentMonth >= 7) {
//     print("Enter 1");
//     return currentMonth - 7;
//   } else {
//     print("Enter 0");
//     return currentMonth + 5;
//   }
// }
//
// String selectMonthByIndex(int index) {
//   // print("Enter $index");
//
//   if(index < 6) {
//     // print("Enter 111");
//     return (index + 7).toString();
//   } else {
//     // print("Enter 000");
//     return (index - 5).toString();
//   }
// }
//
// int selectYearByMonth({required String month}) {
//   int curMonth = int.parse(month);
//
//   if(curMonth >= 7) {
//     print("Enter 1");
//     return CommonCalendar.currentSessionYear[0];
//   } else {
//     print("Enter 0");
//     return CommonCalendar.currentSessionYear[1];
//   }
// }
