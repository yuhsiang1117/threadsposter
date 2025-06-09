import 'package:cloud_firestore/cloud_firestore.dart';

class QueryHistory{
  String title;
  String toneID;
  String tag;
  String style;
  String size;
  String specific_user;
  Timestamp queryTime = Timestamp.now();

  QueryHistory({
    required this.title,
    required this.toneID,
    required this.tag,
    required this.style,
    required this.size,
    required this.specific_user,
    Timestamp? queryTime,
  }) : queryTime = queryTime ?? Timestamp.now();

  @override
  String toString() {
    return 'QueryHistory(title: $title, toneID: $toneID, tag: $tag, style: $style, size: $size, specific_user: $specific_user, queryTime: ${queryTime.toDate()})';
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'tone': toneID,
      'tag': tag,
      'style': style,
      'size': size,
      'specific_user': specific_user,
      'savedAt': queryTime,
    };
  }
}