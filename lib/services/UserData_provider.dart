import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:threadsposter/models/post_query.dart';

class UserDataProvider extends ChangeNotifier {
  String? uid;
  Map<String, dynamic>? userinfo;
  final List<PostQuery> _queries = [
    PostQuery(userQuery: 'userQuery', tag: 'tag', style: 'style', withInDays: 10, size: 10, gclikes: 10, returnCount: 10, tone: 'tone', specificUser: 'null'),
    PostQuery(userQuery: 'userQuery', tag: 'tag', style: 'style', withInDays: 10, size: 10, gclikes: 10, returnCount: 10, tone: 'tone', specificUser: 'null'),
    PostQuery(userQuery: 'userQuery', tag: 'tag', style: 'style', withInDays: 10, size: 10, gclikes: 10, returnCount: 10, tone: 'tone', specificUser: 'null')
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
