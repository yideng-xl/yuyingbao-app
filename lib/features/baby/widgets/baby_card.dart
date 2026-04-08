import 'package:flutter/material.dart';
import '../../../core/database/app_database.dart';
import '../../../shared/utils/date_utils.dart';

class BabyCard extends StatelessWidget {
  final Baby baby;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const BabyCard({
    super.key,
    required this.baby,
    required this.isSelected,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isMale = baby.gender == 'male';
    final avatarColor = isMale ? Colors.blue : Colors.orange;
    final months = ageInMonths(baby.birthDate);

    return Card(
      color: isSelected ? colorScheme.primaryContainer : null,
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: avatarColor,
          foregroundColor: Colors.white,
          child: Text(
            baby.name.characters.first,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(
          baby.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isSelected ? colorScheme.onPrimaryContainer : null,
          ),
        ),
        subtitle: Text(
          '$months 个月 · 出生 ${formatDate(baby.birthDate)}',
          style: TextStyle(
            color: isSelected
                ? colorScheme.onPrimaryContainer.withValues(alpha: 0.75)
                : null,
          ),
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'edit') {
              onEdit();
            } else if (value == 'delete') {
              onDelete();
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'edit',
              child: Row(
                children: [
                  Icon(Icons.edit_outlined),
                  SizedBox(width: 8),
                  Text('编辑'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete_outline, color: Colors.red),
                  SizedBox(width: 8),
                  Text('删除', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
