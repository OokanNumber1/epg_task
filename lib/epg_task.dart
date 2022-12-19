import 'dart:io';

import 'package:epg_task/model/program_model.dart';
import 'package:epg_task/utilities/convert_xlsx_to_dart_list.dart';
import 'package:epg_task/utilities/enums.dart';

import 'utilities/response_helper.dart';

/* Tasks
- provide console menu (fetch program for any time of any day of available months of any year)
- convert file into index of programs per day per month
- user should be able to extract a list of programs available within a time range on any given date
- search for programs based on the log line and theme
*/

void displayConsoleMenu() async {
  // this is to reduce number of times the file
  // will be interacted with (Performance).
  List<ProgramModel> listOfParsedPrograms =
      await convertXlsxToDartList("../lib/file/decEPG.xlsx");
  print("""
=====Kindly enter number of selected option below ;======
1. Fetch program of any time of today.
2. Fetch program of any time of any day (of this month).
3. Fetch program of any time of any day (of any month).
4. Fetch all programs in a particular day.
5. Fetch all programs in the current month.
6. Fetch programs within a given time range in a day.
7. Fetch program based on logline and theme.
8. Exit program.""");
  final selectedMenuOption = stdin.readLineSync();
  switch (selectedMenuOption) {
    case "1":
      fetchProgram(FetchType.today, listOfParsedPrograms);
      break;
    case "2":
      fetchProgram(FetchType.thisMonth, listOfParsedPrograms);
      break;
    case "3":
      fetchProgram(FetchType.anyday, listOfParsedPrograms);
      break;
    case "4":
      fetchAllProgramsOfADay(listOfParsedPrograms);
      break;
    case "5":
      fetchAllProgramsOfTheCurrentMonth(listOfParsedPrograms);
      break;
    case "6":
      fetchProgramsWithinATimeRange(listOfParsedPrograms);
      break;
    case "7":
      fetchProgramWithLoglineAndTheme(listOfParsedPrograms);
      break;
    case "8":
      print("Thanks for using the program, Bye!");
      return;
    default:
      print("Invalid option type.");
      return;
  }
}

void fetchProgram(FetchType type, List<ProgramModel> parsedPrograms) async {
  final now = DateTime.now();
  if (type == FetchType.today) {
    final programDate =
        now.year.toString() + now.month.toString() + now.day.toString();
    print("Enter the time of the program in 24hour format (20:00 or 06:00);");
    final time = stdin.readLineSync();

    final response = parsedPrograms
        .where((program) =>
            program.date == programDate && program.startTime == time)
        .toList();
    responseHelper(response, true);
  } else if (type == FetchType.thisMonth) {
    print(
        "Enter day of the program you want to fetch below in this format{02 or 12};");
    final queryDay = stdin.readLineSync();
    print("Enter the time of the program in 24hour format (20:00 or 06:00);");
    final queryTime = stdin.readLineSync();
    final programDate = now.year.toString() + now.month.toString() + queryDay!;
    final response = parsedPrograms
        .where((program) =>
            program.date == programDate && program.startTime == queryTime)
        .toList();
    responseHelper(response, true);
  } else if (type == FetchType.anyday) {
    print(
        "Enter date of the program you want to fetch below in this format {YearMonthDay => 20220409};");
    final queryDate = stdin.readLineSync();
    print("Enter the time of the program in 24hour format (20:00 or 06:00);");
    final queryTime = stdin.readLineSync();
    final response = parsedPrograms
        .where((program) =>
            program.date == queryDate && program.startTime == queryTime)
        .toList();
    responseHelper(response, true);
  }
}

void fetchAllProgramsOfADay(List<ProgramModel> parsedPrograms) async {
  print(
      "Enter date you want to fetch all programs from below in this format {YearMonthDay => 20220409};");
  final queryDate = stdin.readLineSync();
  final response =
      parsedPrograms.where((program) => program.date == queryDate).toList();

  responseHelper(response, false);
}

void fetchAllProgramsOfTheCurrentMonth(List<ProgramModel> parsedPrograms) {
  final now = DateTime.now();
  final currentMonth = now.year.toString() + now.month.toString();
  final response = parsedPrograms
      .where((program) => program.date.contains(currentMonth))
      .toList();

  responseHelper(response, false);
}

void fetchProgramsWithinATimeRange(List<ProgramModel> parsedPrograms) async {
  List<ProgramModel> response = [];
  print(
      "Enter date of the program you want to fetch below in this format {YearMonthDay => 20220409};");
  final queryDate = stdin.readLineSync();
  print("Enter the lower time of the range in 24hour format (20:00 or 06:00);");
  final lowerQueryTime = stdin.readLineSync();
  print("Enter the upper time of the range in 24hour format (20:00 or 06:00);");
  final upperQueryTime = stdin.readLineSync();

  final queryDateResponse =
      parsedPrograms.where((program) => program.date == queryDate).toList();
  int indexOfLowerQueryTime = queryDateResponse
      .indexWhere((program) => program.startTime == lowerQueryTime);
  final indexOfUpperQueryTime = queryDateResponse
      .indexWhere((program) => program.startTime == upperQueryTime);
  while (indexOfLowerQueryTime != indexOfUpperQueryTime) {
    response.add(queryDateResponse[indexOfLowerQueryTime]);
    indexOfLowerQueryTime += 1;
  }
  responseHelper(response, false);
}

void fetchProgramWithLoglineAndTheme(
    List<ProgramModel> parsedPrograms) async {
  print("""
=====Kindly enter number of selected option below ;======
1. Fetch program with logline.
2. Fetch program with theme.""");
  final query = stdin.readLineSync();
  if (query == "1") {
    print("Enter logline text of the program to be fetched;");
    final loglineQuery = stdin.readLineSync();

    final response = parsedPrograms
        .where((program) =>
            program.logline.toLowerCase().contains(loglineQuery!.toLowerCase()))
        .toList();

    responseHelper(response, false);
  } else if (query == "2") {
    print("Enter theme text of the program to be fetched;");
    final themeQuery = stdin.readLineSync();

    final response = parsedPrograms
        .where((program) =>
            program.theme.toLowerCase().contains(themeQuery!.toLowerCase()))
        .toList();

    responseHelper(response, false);
  } else {
    print("XXXXX Invalid Option Entered XXXXX");
  }
}
