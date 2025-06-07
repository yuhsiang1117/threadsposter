import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SavedPost extends StatefulWidget {
  const SavedPost({super.key});

  @override
  State<SavedPost> createState() => _SavedPostState();
}

class _SavedPostState extends State<SavedPost> {
  List<Map<String, String>> savedArticles = [
    {
      'title': '啊啊啊地震',
      'content': '剛剛地震超大，大家還好嗎？',
      'style': 'Emotion',
    },
    {
      'title': '測試',
      'content': '測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試測試',
      'style': 'Practical',
    },
    {
      'title': '測試2',
      'content': '測試2',
      'style': 'Identity',
    },
    {
      'title': '測試3',
      'content': '測試3',
      'style': 'Emotion',
    },
    {
      'title': '測試4',
      'content': '測試4',
      'style': 'Trend',
    },
    {
      'title': '測試5',
      'content': '測試5',
      'style': 'Practical',
    },
    {
      'title': '測試6',
      'content': '測試6',
      'style': 'Identity',
    },
    {
      'title': '測試7',
      'content': '測試7',
      'style': 'Emotion',
    },
    {
      'title': '測試8',
      'content': '測試8',
      'style': 'Trend',
    },
    {
      'title': '測試9',
      'content': '測試9',
      'style': 'Practical',
    },
    {
      'title': '測試10',
      'content': '測試10',
      'style': 'Identity',
    },
    {
      'title': '測試11',
      'content': '測試11',
      'style': 'Emotion',
    },
    {
      'title': '測試12',
      'content': '測試12',
      'style': 'Trend',
    },
  ];

  final List<String> styleOptions = const [
    '全部',
    'Emotion',
    'Practical',
    'Identity',
    'Trend',
  ];

  String selectedStyle = '全部';

  @override
  Widget build(BuildContext context) {
    final filteredArticles = selectedStyle == '全部'
        ? savedArticles
        : savedArticles.where((a) => a['style'] == selectedStyle).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '我的收藏',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Theme.of(context).colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        elevation: 2,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Row(
              children: [
                Expanded(child: Container()),
                Icon(Icons.filter_list, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                DropdownButton<String>(
                  value: selectedStyle,
                  underline: SizedBox(),
                  dropdownColor: Colors.grey[900],
                  items: styleOptions
                      .map((style) => DropdownMenuItem(
                            value: style,
                            child: Text(style, style: const TextStyle(color: Colors.white)),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        selectedStyle = value;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: filteredArticles.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.bookmark_border, size: 80, color: Theme.of(context).colorScheme.primary.withOpacity(0.2)),
                        const SizedBox(height: 16),
                        Text('尚無收藏貼文', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6))),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(20),
                    itemCount: filteredArticles.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 20),
                    itemBuilder: (context, index) {
                      final article = filteredArticles[index];
                      final realIndex = savedArticles.indexOf(article);
                      return Card(
                        elevation: 4,
                        color: Theme.of(context).colorScheme.surface,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        child: InkWell(
                          onLongPress: () {
                            final content = article['content'] ?? '';
                            Clipboard.setData(ClipboardData(text: content));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('已複製到剪貼簿')),
                            );
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              article['title'] ?? '',
                                              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface),
                                            ),
                                          ),
                                          if (article['style'] != null)
                                            Padding(
                                              padding: const EdgeInsets.only(left: 8),
                                              child: Chip(
                                                label: Text(article['style']!, style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Theme.of(context).colorScheme.onPrimary)),
                                                backgroundColor: _chipColor(article['style']),
                                                labelStyle: Theme.of(context).textTheme.labelMedium?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
                                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                    PopupMenuButton<String>(
                                      color: Theme.of(context).colorScheme.surface,
                                      onSelected: (value) {
                                        if (value == 'delete') {
                                          setState(() {
                                            savedArticles.removeAt(realIndex);
                                          });
                                        }
                                      },
                                      itemBuilder: (context) => [
                                        PopupMenuItem(
                                          value: 'delete',
                                          child: Row(
                                            children: [
                                              Icon(Icons.delete, color: Colors.red, size: 20),
                                              const SizedBox(width: 8),
                                              Text('刪除', style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.red)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.background,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.all(14),
                                  child: Text(
                                    article['content'] ?? '',
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onBackground),
                                    softWrap: true,
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Color _chipColor(String? style) {
    switch (style) {
      case 'Emotion':
        return Colors.deepPurple.shade700;
      case 'Practical':
        return Colors.teal.shade700;
      case 'Identity':
        return Colors.orange.shade700;
      case 'Trend':
        return Colors.pink.shade700;
      default:
        return Colors.grey.shade700;
    }
  }
}
