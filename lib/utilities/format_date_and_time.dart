class FormatDateAndTime {
 static String? formatDate(int daysFrom1900) {
    final date = DateTime(1900, 1, 1).add(Duration(days: daysFrom1900-2));

    if (date.month <= 9) {
      if (date.day <= 9) {
        return "${date.year}0${date.month}0${date.day}";
      }
      return "${date.year}0${date.month}${date.day}";
    } else if (date.day <= 9) {
      return "${date.year}${date.month}0${date.day}";
    }
    return "${date.year}${date.month}${date.day}";
  }

 static String? formatTime(double time) {
    final timeIn24hrsFormat = (24 * time).toString();
    final listOfTimeComponents = timeIn24hrsFormat.split("."); //hour:minute

    if (listOfTimeComponents[1] == "0") {
      if (listOfTimeComponents[0].length < 2) {
        return "0${listOfTimeComponents[0]}:00";
      } else {
        return "${listOfTimeComponents[0]}:00";
      }
    } else {
      int minute = ((double.tryParse("0.${listOfTimeComponents[1]}") ?? 0.1) * 60).ceil();
      if (minute >= 59) {
        listOfTimeComponents[0] = ((int.tryParse(listOfTimeComponents[0]) ?? 6) + 1).toString();
        minute = 0;
      }
      if (listOfTimeComponents[0].length < 2) {
        if (minute == 0) {
          return "0${listOfTimeComponents[0]}:00";
        }
        return "0${listOfTimeComponents[0]}:$minute";
      } else {
        if (minute == 0) {
          return "0${listOfTimeComponents[0]}:00}";
        }
        return "${listOfTimeComponents[0]}:$minute";
      }
    }
  }
}
