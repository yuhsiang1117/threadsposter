import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:threadsposter/models/data_lists.dart';
import 'package:threadsposter/models/query_history.dart';
import 'package:threadsposter/services/UserData_provider.dart';
import 'package:threadsposter/services/navigation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<QueryHistory> queryHistorys = [];

  void loadHistory(String uid) async {

    final query = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('history')
        .get();

    setState(() {
      debugPrint('[HistoryPage] Loaded ${query.docs.length} query for user $uid');
      queryHistorys.clear();
      for (var doc in query.docs) {
        final data = doc.data();
        queryHistorys.add(QueryHistory(
          title: data['title'] ?? 'No Title',
          toneID: data['tone'] ?? 'No Tone',
          tag: data['tag'] ?? 'No Tag',
          style: data['style'] ?? 'No Style',
          size: data['size'] ?? 'No Size',
          specific_user: data['specific_user'] ?? '',
          queryTime: data['savedAt'] ?? Timestamp.now(),
        ));
        queryHistorys.sort((a, b) => b.queryTime.compareTo(a.queryTime));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    final uid = Provider.of<UserDataProvider>(context, listen: false).uid;
    loadHistory(uid!);
  }

  @override
  Widget build(BuildContext context) {
    final queries = context.watch<UserDataProvider>().queries;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    final toneProvider = Provider.of<ToneProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainer,
      appBar: AppBar(
        title: Text(
                '歷史紀錄',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 2,
      ),
      body: queryHistorys.isEmpty
      ? Center(
        child: Text(
          '沒有歷史紀錄',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      )
      : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: queryHistorys.length,
        itemBuilder: (context, index) {
          final query = queryHistorys[index];

          return Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                final navigationService = Provider.of<NavigationService>(context, listen: false);
                toneProvider.currentPage = toneProvider.idToIndex(query.toneID);
                debugPrint('[HistoryPage] Navigating to post with query: ${query.toString()}');
                navigationService.goPost(toneID: query.toneID, fromHistory: true, query: query);
                Navigator.pop(context);
              },
              child: Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('文章主題：',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text(query.title),
                      const SizedBox(height: 8),
                      Text('角色： ${toneProvider.idToName(query.toneID)}'),
                      Text('內容概述： ${query.tag}', style: TextStyle(color: Colors.grey[700])),
                      Text('文章風格： ${query.style}', style: TextStyle(color: Colors.grey[700])),
                      Text('文章長度： ${query.size}', style: TextStyle(color: Colors.grey[700])),
                      if (query.specific_user != '')
                        Text(
                          '特定使用者： ${query.specific_user}',
                          style: TextStyle(color: Colors.grey[700])
                        ),
                      Text(
                          '生成時間： ${DateFormat('yyyy/MM/dd HH:mm').format(query.queryTime.toDate())}', // UTC+0轉UTC+8
                          style: TextStyle(color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}