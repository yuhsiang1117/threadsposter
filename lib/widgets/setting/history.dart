import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:threadsposter/services/post_query_provider.dart';
import 'package:threadsposter/services/navigation.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final queries = context.watch<PostQueryProvider>().queries;

    return Scaffold(
      appBar: AppBar(
        title: const Text('所有 PostQuery'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: queries.length,
        itemBuilder: (context, index) {
          final query = queries[index];

          return Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                final navigationService = Provider.of<NavigationService>(context, listen: false);
                navigationService.goPost(tone:query.tone);
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
                      Text('使用者輸入：',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text(query.userQuery),
                      const SizedBox(height: 8),
                      Text('標籤（Tag）： ${query.tag}', style: TextStyle(color: Colors.grey[700])),
                      Text('風格（Style）： ${query.style}', style: TextStyle(color: Colors.grey[700])),
                      if (query.tone != null)
                        Text('語氣（Tone）： ${query.tone}'),
                      
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