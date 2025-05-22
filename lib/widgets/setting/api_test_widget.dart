import 'package:flutter/material.dart';
import 'package:threadsposter/api.dart';

class ApiTestWidget extends StatefulWidget {
  const ApiTestWidget({super.key});

  @override
  State<ApiTestWidget> createState() => _ApiTestWidgetState();
}

class _ApiTestWidgetState extends State<ApiTestWidget> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String _errorMessage = '';
  List<GeneratedPost> _generatedPosts = [];

  // Form field controllers
  final _userQueryController = TextEditingController(text: 'Flutter 开发');
  final _tagController = TextEditingController(text: 'tech');
  final _styleController = TextEditingController(text: 'Emotion');
  final _withindaysController = TextEditingController(text: '30');
  final _sizeController = TextEditingController(text: '5');
  final _gclikesController = TextEditingController(text: '10');
  final _topKController = TextEditingController(text: '3');

  @override
  void dispose() {
    _userQueryController.dispose();
    _tagController.dispose();
    _styleController.dispose();
    _withindaysController.dispose();
    _sizeController.dispose();
    _gclikesController.dispose();
    _topKController.dispose();
    super.dispose();
  }

  Future<void> _testApi() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = '';
      _generatedPosts = [];
    });

    try {
      final posts = await generatePost(
        userquery: _userQueryController.text,
        tag: _tagController.text,
        style: _styleController.text,
        withindays: int.parse(_withindaysController.text),
        size: int.parse(_sizeController.text),
        gclikes: int.parse(_gclikesController.text),
        topK: int.parse(_topKController.text),
      );

      setState(() {
        _generatedPosts = posts;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API 測試工具'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Input fields
              TextFormField(
                controller: _userQueryController,
                decoration: const InputDecoration(
                  labelText: '用戶查詢 (userquery)',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '請輸入用戶查詢';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _tagController,
                decoration: const InputDecoration(
                  labelText: '標籤 (tag)',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '請輸入標籤';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _styleController,
                decoration: const InputDecoration(
                  labelText: '風格 (style)',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '請輸入風格';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _withindaysController,
                      decoration: const InputDecoration(
                        labelText: '天數 (withindays)',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '請輸入天數';
                        }
                        if (int.tryParse(value) == null) {
                          return '請輸入有效的數字';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _sizeController,
                      decoration: const InputDecoration(
                        labelText: '大小 (size)',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '請輸入大小';
                        }
                        if (int.tryParse(value) == null) {
                          return '請輸入有效的數字';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _gclikesController,
                      decoration: const InputDecoration(
                        labelText: '最低點贊數 (gclikes)',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '請輸入點贊數';
                        }
                        if (int.tryParse(value) == null) {
                          return '請輸入有效的數字';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _topKController,
                      decoration: const InputDecoration(
                        labelText: '返回數量 (topK)',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '請輸入返回數量';
                        }
                        if (int.tryParse(value) == null) {
                          return '請輸入有效的數字';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isLoading ? null : _testApi,
                child: _isLoading
                    ? const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          ),
                          SizedBox(width: 12),
                          Text('處理中...'),
                        ],
                      )
                    : const Text('發送請求'),
              ),
              if (_errorMessage.isNotEmpty) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '錯誤: $_errorMessage',
                    style: TextStyle(color: Colors.red.shade800),
                  ),
                ),
              ],
              if (_generatedPosts.isNotEmpty) ...[
                const SizedBox(height: 24),
                const Text(
                  '生成結果:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                ..._generatedPosts.map((post) => Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              post.content,
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  '得分: ${post.score.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )),
              ],
            ],
          ),
        ),
      ),
    );
  }
} 