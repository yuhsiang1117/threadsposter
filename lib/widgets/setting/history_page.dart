import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:threadsposter/services/post_query_provider.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final queries = context.watch<PostQueryProvider>().queries;

    return Scaffold(
      appBar: AppBar(title: Text('所有 PostQuery')),
      body: ListView.builder(
        itemCount: queries.length,
        itemBuilder: (context, index) {
          final query = queries[index];
          return ListTile(
            title: Text(query.userQuery),
            subtitle: Text('Tag: ${query.tag}, Style: ${query.style}'),
          );
        },
      ),
    );
  }
}