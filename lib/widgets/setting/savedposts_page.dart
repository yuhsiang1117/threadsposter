import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:threadsposter/models/save_post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:threadsposter/services/UserData_provider.dart';

class SavedPostPage extends StatefulWidget {
  const SavedPostPage({super.key});

  @override
  State<SavedPostPage> createState() => _SavedPostPageState();
}

class _SavedPostPageState extends State<SavedPostPage> {
  List<SavedPost> savedArticles = [];
  void loadFavorites(String uid) async {

    final query = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('favorites')
        .get();

    setState(() {
      debugPrint('[SavedPostPage] Loaded ${query.docs.length} saved articles for user $uid');
      savedArticles.clear();
      for (var doc in query.docs) {
        final data = doc.data();
        savedArticles.add(SavedPost(
          title: data['title'],
          content: data['content'],
          style: data['style'],
        ));
      }
    });
  }

  void removeFavoriteDB(String uid, SavedPost content) async {

    final query = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('favorites')
        .where('title', isEqualTo: content.title)
        .where('content', isEqualTo: content.content)
        .where('style', isEqualTo: content.style)
        .get();

    for (var doc in query.docs) {
      await doc.reference.delete();
    }
  }

  final List<String> styleOptions = const [
    '全部',
    'Emotion',
    'Practical',
    'Identity',
    'Trend',
  ];

  String selectedStyle = '全部';

  @override
  void initState() {
    super.initState();
    final uid = Provider.of<UserDataProvider>(context, listen: false).uid;
    loadFavorites(uid!);
  }

  @override
  Widget build(BuildContext context) {
    final filteredArticles = selectedStyle == '全部'
        ? savedArticles
        : savedArticles.where((a) => a.style == selectedStyle).toList();

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
      backgroundColor: Theme.of(context).colorScheme.surface,
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
                  dropdownColor: Theme.of(context).colorScheme.onPrimary,
                  items: styleOptions
                      .map((style) => DropdownMenuItem(
                            value: style,
                            child: Text(style, style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface)),
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
                        Text('尚無收藏貼文', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6))),
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
                            final content = article.content ?? '';
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
                                              article.title ?? '',
                                              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface),
                                            ),
                                          ),
                                          if (article.style != null)
                                            Padding(
                                              padding: const EdgeInsets.only(left: 8),
                                              child: Chip(
                                                label: Text(article.style!, style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Theme.of(context).colorScheme.onPrimary)),
                                                backgroundColor: _chipColor(article.style),
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
                                            removeFavoriteDB(
                                              Provider.of<UserDataProvider>(context, listen: false).uid!,
                                              savedArticles[realIndex],
                                            );
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
                                    color: Theme.of(context).colorScheme.surface,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.all(14),
                                  child: Text(
                                    article.content ?? '',
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface),
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
