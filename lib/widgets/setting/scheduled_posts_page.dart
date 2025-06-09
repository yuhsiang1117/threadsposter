import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:threadsposter/services/UserData_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ScheduledPostsPage extends StatefulWidget {
  const ScheduledPostsPage({super.key});

  @override
  State<ScheduledPostsPage> createState() => _ScheduledPostsPageState();
}

class _ScheduledPostsPageState extends State<ScheduledPostsPage> with TickerProviderStateMixin { // 修正多 ticker bug
  late AnimationController _animationController;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _tabController = TabController(length: 2, vsync: this);
    // 移除 listener，改用 TabBar onTap
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    return Scaffold(
      appBar: AppBar(
        title: Text('已排程發文', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Theme.of(context).colorScheme.onPrimary)),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: userId == null
          ? Center(child: Text('請先登入'))
          : StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('schedule')
                  .orderBy('scheduledTime', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('發生錯誤: \n${snapshot.error}'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('目前沒有排程發文'));
                }
                for(var change in snapshot.data!.docChanges) {
                  if (change.type == DocumentChangeType.added) {
                    debugPrint('新增排程: ${change.doc.data()}');
                  } else if (change.type == DocumentChangeType.modified) {
                    debugPrint('修改排程: ${change.doc.data()}');
                  } else if (change.type == DocumentChangeType.removed) {
                    debugPrint('刪除排程: ${change.doc.data()}');
                  }
                }
                final posts = snapshot.data!.docs;
                for (final post in posts) {
                  final data = post.data() as Map<String, dynamic>;
                  debugPrint(data.toString());
                }
                final pendingPosts = posts.where((post) {
                  final data = post.data() as Map<String, dynamic>;
                  return (data['status'] ?? 'pending') == 'pending';
                }).toList();
                final expiredPosts = posts.where((post) {
                  final data = post.data() as Map<String, dynamic>;
                  return data['status'] == 'expired';
                }).toList();
                return DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      TabBar(
                        controller: _tabController,
                        onTap: (_) => _animationController.forward(from: 0), // 立即觸發動畫
                        tabs: [
                          Tab(text: '已排程'),
                          Tab(text: '已過期'),
                        ],
                        labelColor: Theme.of(context).colorScheme.primary,
                        unselectedLabelColor: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            // 已排程
                            _buildScheduledList(context, pendingPosts, animationController: _animationController),
                            // 已取消
                            _buildScheduledList(context, expiredPosts, isExpired: true, animationController: _animationController),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  // 修改 _buildScheduledList，加入 animationController 參數
  Widget _buildScheduledList(BuildContext context, List<QueryDocumentSnapshot> posts, {bool isExpired = false, required AnimationController animationController}) {
    if (posts.isEmpty) {
      return Center(child: Text(isExpired ? '目前沒有已過期排程' : '目前沒有排程發文'));
    }
    return ListView.separated(
      itemCount: posts.length,
      separatorBuilder: (_, __) => const SizedBox(height: 4),
      itemBuilder: (context, index) {
        final post = posts[index];
        final data = post.data() as Map<String, dynamic>;
        final content = data['content'] ?? '';
        final scheduledTime = (data['scheduledTime'] as Timestamp?)?.toDate();
        // 動畫部分
        final double singleDuration = 0.4; // 每個 row 動畫佔總時長的 50%
        final double overlap = 0.1; // 下一個在前一個 10% 時就開始
        final double start = (index+1) * overlap;
        final double end = (start + singleDuration).clamp(0.0, 1.0);
        final animation = Tween<Offset>(
          begin: const Offset(0, 5),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(
            parent: animationController,
            curve: Interval(start, end, curve: Curves.easeOutCubic),
          ),
        );
        return SlideTransition(
          position: animation,
          child: Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('發文內容'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(content, style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 16),
                        Text(
                          scheduledTime != null
                            ? '預定發文時間：${scheduledTime.toLocal()}'
                            : '無時間',
                          style: const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('關閉'),
                      ),
                    ],
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            content,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        if (!isExpired)
                          IconButton(
                            icon: Icon(Icons.cancel, color: Theme.of(context).colorScheme.error),
                            tooltip: '取消排程',
                            onPressed: () async {
                              final confirm = await showDialog<bool>(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('確認取消排程'),
                                  content: const Text('確定要取消這則排程發文嗎？此動作無法復原。'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context, false),
                                      child: const Text('取消'),
                                    ),
                                    TextButton(
                                      onPressed: () => Navigator.pop(context, true),
                                      child: const Text('確定'),
                                    ),
                                  ],
                                ),
                              );
                              if (confirm == true) {
                                await post.reference.delete();
                              }
                            },
                          ),
                        if (isExpired)
                          IconButton(
                            icon: Icon(Icons.refresh, color: Theme.of(context).colorScheme.primary),
                            tooltip: '重新排程',
                            onPressed: () async {
                              final picked = await showDateTimePicker(context, scheduledTime);
                              if (picked != null) {
                                await post.reference.update({
                                  'scheduledTime': Timestamp.fromDate(picked),
                                  'status': 'pending',
                                });
                              }
                            },
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      scheduledTime != null ? '預定發文時間：${scheduledTime.toLocal()}' : '無時間',
                      style: const TextStyle(color: Colors.blue),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      isExpired ? '此排程已過期' : '點擊查看完整文章內容',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<DateTime?> showDateTimePicker(BuildContext context, DateTime? initialTime) async {
    final now = DateTime.now();
    final firstDate = now;
    final initial = (initialTime != null && initialTime.isAfter(firstDate)) ? initialTime : firstDate;
    final date = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: firstDate,
      lastDate: DateTime(now.year + 2),
    );
    if (date == null) return null;
    final time = await showTimePicker(
      context: context,
      initialTime: initialTime != null && initialTime.isAfter(firstDate)
          ? TimeOfDay(hour: initialTime.hour, minute: initialTime.minute)
          : TimeOfDay.now(),
    );
    if (time == null) return null;
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }
}
