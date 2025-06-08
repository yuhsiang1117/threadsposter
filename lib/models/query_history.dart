import 'package:cloud_firestore/cloud_firestore.dart';

class QueryHistory{
  String title = 'title';
  String tone = 'tone';
  String tag = 'tag';
  String style = 'style';
  String size = 'size';
  String specific_user = '';
  Timestamp queryTime = Timestamp.now();

  QueryHistory({
    required this.title,
    required this.tone,
    required this.tag,
    required this.style,
    required this.size,
    this.specific_user = '',
    Timestamp? queryTime,
  }) : queryTime = queryTime ?? Timestamp.now();
}