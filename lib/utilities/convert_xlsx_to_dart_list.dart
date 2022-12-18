import 'dart:io';
import 'dart:async';

import 'package:epg_task/model/program_model.dart';
import 'package:excel/excel.dart';

Future<List<ProgramModel>> convertXlsxToDartList(String xlsxPath) async {
  File data = File(xlsxPath);

  final bytes = await data.readAsBytes();

  final excel = Excel.decodeBytes(bytes);
  final programs = excel.tables["Sheet1"]!.rows.sublist(1);
  List<ProgramModel> listOfPrograms = [];
  for (var row in programs) {
    listOfPrograms.add(ProgramModel.fromSheet(row));
  }
  return listOfPrograms;
}
