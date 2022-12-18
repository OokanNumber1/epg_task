import 'package:epg_task/epg_task.dart';
import 'package:epg_task/utilities/convert_xlsx_to_dart_list.dart';

void main() {
  displayConsoleMenu();
  // convertXlsxToDartList("../lib/file/decEPG.xlsx").then(
  //   (value) => print(value),
  // );
}


// String formatDouble(double toBeFormatted){
//   final strList = toBeFormatted.toString().split(".");
//   if (strList[1] == "0") {
//     if (strList[0].length < 2) {
//       return "0${strList[0]}:00";
//     } else {
//       return "${strList[0]}:00";
//     }
//   }else {
//       final minute = ((double.tryParse("0.${strList[1]}") ?? 0.1) * 60).ceil();
//       return "${strList[0]}:$minute";
//     }
// }