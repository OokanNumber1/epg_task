import 'package:epg_task/utilities/format_date_and_time.dart';
import 'package:excel/excel.dart';

class ProgramModel {
  const ProgramModel({
    required this.date,
    required this.startTime,
    required this.title,
    required this.rating,
    required this.synopsis,
    required this.logline,
    required this.theme,
  });
  final String title;
  final String date;
  final String startTime;
  final String synopsis;
  final String logline;
  final String theme;
  final String rating;

  factory ProgramModel.fromSheet(List<Data?> row) {
    return ProgramModel(
      date: FormatDateAndTime.formatDate(row[0]?.value ?? 44894) ?? "20221200",
      startTime: FormatDateAndTime.formatTime(row[1]?.value ?? 0.0) ?? "00:00",
      title: row[2]?.value.toString() ?? "Wap Movie",
      rating: row[3]?.value.toString() ?? "5",
      synopsis: row[6]?.value.toString() ?? "A Wale Adenuga Production Story",
      logline: row[14]?.value.toString() ?? "WAP",
      theme: row[15]?.value.toString() ?? "WAP",
    );
  }

  @override
  String toString() {
    return 'ProgramModel(title: $title, date: $date, startTime: $startTime, synopsis: $synopsis, logline: $logline, theme: $theme, rating: $rating)';
  }
}
