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

  int _currentPage = 0;
  int get currentPage => _currentPage;
  set currentPage(int value) {
    if (_currentPage != value) {
      _currentPage = value;
      notifyListeners();
    }
  }

  String _customToneDisplay = '';
  String get customToneDisplay => _customToneDisplay.isEmpty ? '尚未自訂角色' : _customToneDisplay;
  set customToneDisplay(String value) {
    if (_customToneDisplay != value) {
      _customToneDisplay = value;
      notifyListeners();
    }
  }

  Future<void> fetchTones() async {
    _toneOptions = await updateToneOptions();
    notifyListeners();
  }

  String nameToId(String name) {
    for (int i = 0; i < _toneOptions.length; i++) {
      if (_toneOptions[i].name == name) {
        return _toneOptions[i].id;
      }
    }
    return ''; // 如果找不到，返回空字串
  }

  String idToName(String id) {
    for (int i = 0; i < _toneOptions.length; i++) {
      if (_toneOptions[i].id == id) {
        return _toneOptions[i].name;
      }
    }
    return id; // 如果找不到，返回 id 本身(custom)
  }

  int nameToIndex(String name) {
    for (int i = 0; i < _toneOptions.length; i++) {
      if (_toneOptions[i].name == name) {
        return i;
      }
    }
    return _toneOptions.length - 1; // 如果找不到，返回最後一個索引(custom)
  }

  int idToIndex(String id) {
    for (int i = 0; i < _toneOptions.length; i++) {
      if (_toneOptions[i].id == id) {
        return i;
      }
    }
    return 0; // 如果找不到，返回 0
  }
}

List<ToneOption> defaultToneOptions = [
  ToneOption('none', '管家', '你是一位能完美完成所下達任務的管家'),
  ToneOption('boss', '霸道總裁', '是一位霸道總裁，說話風 格具有自信、愛用命令句，語氣十分的霸氣，且對自己的女人有強烈的保護慾'),
  ToneOption('simp', '暈船仔', '是一位重度暈船仔，講話時常會有小劇場，情感豐沛但壓抑不敢說破'),
  ToneOption('custom', '自訂角色', '自訂帳號風格'),
];

Future<List<ToneOption>> updateToneOptions() async {
  List<Map<String, dynamic>> tonesResponse = [];
  try{
    debugPrint('[lib/models/data_lists.dart] Searching tone options...');
    tonesResponse = await getAvailableTones().timeout(const Duration(seconds: 5));
    debugPrint('[lib/models/data_lists.dart] Fetched tones: $tonesResponse');
  } catch (e) {
    debugPrint('[lib/models/data_lists.dart] Cannot connect to server : $e');
  }
  List<ToneOption> toneOptions =[];
  if (tonesResponse.isEmpty) {
    debugPrint('[lib/models/data_lists.dart] No tones found, using default options');
    return defaultToneOptions;
  }
  for (var tone in tonesResponse){
    toneOptions.add(ToneOption(tone['id'], tone['name'], tone['description']));
  }
  toneOptions.add(ToneOption('custom', '自訂角色', '自訂帳號風格'));
  return toneOptions;
}
const List<String> styleOptions = [
  'Emotion',
  'Practical',
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