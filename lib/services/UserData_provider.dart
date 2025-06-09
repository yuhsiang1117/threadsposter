import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:threadsposter/models/post_query.dart';

class UserDataProvider extends ChangeNotifier {
  String? uid;
  Map<String, dynamic>? userinfo;
  final List<PostQuery> _queries = [
    PostQuery(userQuery: 'userQuery', tag: 'tag', style: 'style', withInDays: 10, size: 10, gclikes: 10, returnCount: 10, tone: 'tone', specificUser: 'null', weight: {'relevance': 0.5714, 'traffic': 0.3333, 'recency': 0.09523}),
    PostQuery(userQuery: 'userQuery', tag: 'tag', style: 'style', withInDays: 10, size: 10, gclikes: 10, returnCount: 10, tone: 'tone', specificUser: 'null', weight: {'relevance': 0.5714, 'traffic': 0.3333, 'recency': 0.09523}),
    PostQuery(userQuery: 'userQuery', tag: 'tag', style: 'style', withInDays: 10, size: 10, gclikes: 10, returnCount: 10, tone: 'tone', specificUser: 'null', weight: {'relevance': 0.5714, 'traffic': 0.3333, 'recency': 0.09523}),
  ];

  List<PostQuery> get queries => _queries;

  void _initialize() async {
     final doc = await FirebaseFirestore.instance
      .collection("users")
      .doc(uid)
      .collection("profile")
      .doc('info')
      .get();

    userinfo = doc.data();
    if(userinfo?['weight'] == null) {
      userinfo?['weight'] = {
        'relevance': 0.5,
        'traffic': 0.3,
        'recency': 0.2
      };
      await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("profile")
        .doc('info')
        .update({
          'weight': userinfo?['weight']
      });
    }
    notifyListeners();
  }

  UserDataProvider() : uid = FirebaseAuth.instance.currentUser?.uid {
      _initialize();
  }

  void refreshData() async {
    uid = FirebaseAuth.instance.currentUser?.uid;
    final doc = await FirebaseFirestore.instance
      .collection("users")
      .doc(uid)
      .collection("profile")
      .doc('info')
      .get();

    userinfo = doc.data();
    notifyListeners();
  }

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
