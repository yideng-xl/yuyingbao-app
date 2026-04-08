import 'package:flutter/material.dart';
import '../../../repositories/knowledge_repository.dart';

class KnowledgeDetailPage extends StatelessWidget {
  final KnowledgeItem item;

  const KnowledgeDetailPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Text(
          item.content,
          style: const TextStyle(fontSize: 16, height: 1.6),
        ),
      ),
    );
  }
}
