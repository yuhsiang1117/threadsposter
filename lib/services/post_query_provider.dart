import 'package:flutter/material.dart';
import 'package:threadsposter/models/post_query.dart';

class PostQueryProvider extends ChangeNotifier {
  final List<PostQuery> _queries = [
    PostQuery(userQuery: 'userQuery', tag: 'tag', style: 'style', withInDays: 10, size: 10, gclikes: 10, returnCount: 10, tone: 'tone', specificUser: 'null'),
    PostQuery(userQuery: 'userQuery', tag: 'tag', style: 'style', withInDays: 10, size: 10, gclikes: 10, returnCount: 10, tone: 'tone', specificUser: 'null'),
    PostQuery(userQuery: 'userQuery', tag: 'tag', style: 'style', withInDays: 10, size: 10, gclikes: 10, returnCount: 10, tone: 'tone', specificUser: 'null')
  ];

  List<PostQuery> get queries => _queries;

  void addQuery(PostQuery query) {
    _queries.add(query);
    notifyListeners();
  }

  void removeQuery(PostQuery query) {
    _queries.remove(query);
    notifyListeners();
  }

  void clearQueries() {
    _queries.clear();
    notifyListeners();
  }
}
