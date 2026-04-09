import 'package:flutter/material.dart';
import 'package:yuyingbao/l10n/generated/app_localizations.dart';
import '../../../repositories/knowledge_repository.dart';

class KnowledgeCard extends StatelessWidget {
  final KnowledgeItem item;
  final VoidCallback onTap;

  const KnowledgeCard({
    super.key,
    required this.item,
    required this.onTap,
  });

  String _categoryLabel(String category, S s) {
    switch (category) {
      case 'feeding':
        return s.knowledgeCategoryFeeding;
      case 'health':
        return s.knowledgeCategoryHealth;
      case 'development':
        return s.knowledgeCategoryDevelopment;
      case 'solid':
        return s.knowledgeCategorySolid;
      default:
        return category;
    }
  }

  Color _categoryColor(String category) {
    switch (category) {
      case 'feeding':
        return Colors.blue;
      case 'health':
        return Colors.green;
      case 'development':
        return Colors.orange;
      case 'solid':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final label = _categoryLabel(item.category, s);
    final color = _categoryColor(item.category);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        title: Text(
          item.title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          item.content,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: Colors.black54),
        ),
        trailing: Chip(
          label: Text(
            label,
            style: TextStyle(color: color, fontSize: 12),
          ),
          backgroundColor: color.withValues(alpha: 0.1),
          side: BorderSide(color: color.withValues(alpha: 0.3)),
          padding: const EdgeInsets.symmetric(horizontal: 4),
        ),
        onTap: onTap,
      ),
    );
  }
}
