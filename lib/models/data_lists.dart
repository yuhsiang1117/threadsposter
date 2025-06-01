import 'package:flutter/material.dart';
import 'package:threadsposter/services/api.dart';

class ToneOption {
  String id;
  String name;
  final String description;

  ToneOption(this.id, this.name, this.description);
}

class ToneProvider with ChangeNotifier {
  List<ToneOption> _toneOptions = [];
  List<ToneOption> get tones => _toneOptions;

  Future<void> fetchTones() async {
    _toneOptions = await updateToneOptions();
    notifyListeners();
  }
}

List<ToneOption> options = [
  ToneOption('None', '無', '無特定角色'),
  ToneOption('Boss', '總裁', '老闆風格，權威且直接'),
  ToneOption('Simp', '暈船仔', '討好型，溫柔且諂媚'),
  ToneOption('Custom', '', '自訂帳號風格'),
];

Future<List<ToneOption>> updateToneOptions() async {
  debugPrint('[lib/models/data_lists.dart] Updating tone options...');
  final tones = await getAvailableTones();
  debugPrint('[lib/models/data_lists.dart] Fetched tones: $tones');
  // toneOptions = tones
  //     .map<ToneOption>((tone) => ToneOption())
  //     .toList();
  return options;
}
const List<String> styleOptions = [
  'Emotion',
  'Practicle',
  'Identity',
  'Trend',
];

const List<String> size = [
  'Short',
  'Medium',
  'Long',
];

const List<String> tagOptions = [
  "#地震",
  "#颱風",
  "#大雨",
  "#大雪",
  "#大霧",
  "#大風",
  "#大火",
];