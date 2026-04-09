import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../../../repositories/knowledge_repository.dart';

class KnowledgeDetailPage extends StatelessWidget {
  final KnowledgeItem item;

  const KnowledgeDetailPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
      ),
      body: Markdown(
        data: item.content,
        padding: const EdgeInsets.all(16),
        styleSheet: MarkdownStyleSheet.fromTheme(theme).copyWith(
          p: theme.textTheme.bodyLarge?.copyWith(height: 1.6),
          h2: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          h3: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          listBullet: theme.textTheme.bodyLarge?.copyWith(height: 1.6),
        ),
        selectable: true,
      ),
    );
  }
}
