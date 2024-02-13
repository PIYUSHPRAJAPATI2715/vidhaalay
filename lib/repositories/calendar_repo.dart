
int selectCorrectMonthIndex(int currentMonth) {
  if(currentMonth < 4) {
    return currentMonth + 9;
  } else {
    return currentMonth - 4;
  }
}

String selectMonthByIndex(int index) {
  if(index > 8) {
    return (index - 8).toString();
  } else {
    return (index + 4).toString();
  }
}

int selectYearByMonth({required String month,required List currentSessionYear}) {
  int curMonth = int.parse(month);

  if(curMonth > 3)
  // if(curMonth > 8)
  {
    // print(enter);
    return currentSessionYear[0];
  } else {
    // print(enter);
    return currentSessionYear[1];
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