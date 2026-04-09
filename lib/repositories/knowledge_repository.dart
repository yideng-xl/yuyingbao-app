import 'dart:convert';
import 'package:flutter/services.dart';

class KnowledgeItem {
  final String id;
  final String ageRange;
  final String category;
  final String title;
  final String content;
  final int sortOrder;

  KnowledgeItem({
    required this.id,
    required this.ageRange,
    required this.category,
    required this.title,
    required this.content,
    required this.sortOrder,
  });

  factory KnowledgeItem.fromJson(Map<String, dynamic> json) {
    return KnowledgeItem(
      id: json['id'] as String,
      ageRange: json['ageRange'] as String,
      category: json['category'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      sortOrder: json['sortOrder'] as int,
    );
  }
}

class KnowledgeRepository {
  final String _langCode;

  KnowledgeRepository({String langCode = 'zh'}) : _langCode = langCode;

  List<KnowledgeItem>? _cache;

  Future<List<KnowledgeItem>> getAll() async {
    _cache ??= await _loadFromAssets();
    return _cache!;
  }

  Future<List<KnowledgeItem>> getByAgeRange(String ageRange) async {
    final all = await getAll();
    return all.where((k) => k.ageRange == ageRange).toList();
  }

  Future<List<KnowledgeItem>> search(String query) async {
    final all = await getAll();
    final lower = query.toLowerCase();
    return all
        .where((k) =>
            k.title.toLowerCase().contains(lower) ||
            k.content.toLowerCase().contains(lower))
        .toList();
  }

  Future<List<KnowledgeItem>> _loadFromAssets() async {
    // Try locale-specific file first, fall back to default (zh)
    final suffix = _langCode == 'zh' ? '' : '_$_langCode';
    final path = 'assets/knowledge/knowledge_data$suffix.json';
    String jsonStr;
    try {
      jsonStr = await rootBundle.loadString(path);
    } catch (_) {
      // Fallback to Chinese
      jsonStr = await rootBundle.loadString('assets/knowledge/knowledge_data.json');
    }
    final List<dynamic> jsonList = json.decode(jsonStr) as List<dynamic>;
    return jsonList
        .map((j) => KnowledgeItem.fromJson(j as Map<String, dynamic>))
        .toList()
      ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
  }
}
