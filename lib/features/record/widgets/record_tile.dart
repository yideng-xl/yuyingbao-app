import 'package:flutter/material.dart';
import '../../../core/constants/enums.dart';
import '../../../repositories/record_repository.dart';
import '../../../shared/utils/date_utils.dart';

class RecordTile extends StatelessWidget {
  final BabyRecord record;
  final VoidCallback? onTap;
  final VoidCallback onDelete;

  const RecordTile({
    super.key,
    required this.record,
    this.onTap,
    required this.onDelete,
  });

  RecordType get _recordType {
    return RecordType.values.firstWhere(
      (e) => e.name == record.type,
      orElse: () => RecordType.breastfeeding,
    );
  }

  IconData _iconFor(RecordType type) {
    switch (type) {
      case RecordType.breastfeeding:
        return Icons.woman;
      case RecordType.bottle:
        return Icons.local_drink;
      case RecordType.formula:
        return Icons.local_drink;
      case RecordType.solid:
        return Icons.restaurant;
      case RecordType.diaper:
        return Icons.baby_changing_station;
      case RecordType.growth:
        return Icons.straighten;
      case RecordType.water:
        return Icons.water_drop;
      case RecordType.nutrition:
        return Icons.medication;
    }
  }

  Color _colorFor(RecordType type) {
    switch (type) {
      case RecordType.breastfeeding:
        return const Color(0xFFFF8A65);
      case RecordType.bottle:
        return const Color(0xFF4FC3F7);
      case RecordType.formula:
        return const Color(0xFF4FC3F7);
      case RecordType.solid:
        return const Color(0xFF81C784);
      case RecordType.diaper:
        return const Color(0xFFBA68C8);
      case RecordType.growth:
        return const Color(0xFFFFD54F);
      case RecordType.water:
        return const Color(0xFF4DD0E1);
      case RecordType.nutrition:
        return const Color(0xFFE57373);
    }
  }

  String _subtitleFor(RecordType type) {
    switch (type) {
      case RecordType.breastfeeding:
        final side = record.breastfeedingSide != null
            ? BreastfeedingSide.values
                .firstWhere(
                  (e) => e.name == record.breastfeedingSide,
                  orElse: () => BreastfeedingSide.left,
                )
                .label
            : '';
        final duration = record.durationMin != null ? ' ${record.durationMin}分钟' : '';
        return '$side$duration'.trim();
      case RecordType.bottle:
      case RecordType.formula:
      case RecordType.water:
        if (record.amountMl != null) {
          return '${record.amountMl!.toStringAsFixed(0)}ml';
        }
        return '';
      case RecordType.solid:
        if (record.solidType != null) {
          return SolidType.values
              .firstWhere(
                (e) => e.name == record.solidType,
                orElse: () => SolidType.other,
              )
              .label;
        }
        return '';
      case RecordType.diaper:
        final parts = <String>[];
        if (record.diaperTexture != null) {
          parts.add(
            DiaperTexture.values
                .firstWhere(
                  (e) => e.name == record.diaperTexture,
                  orElse: () => DiaperTexture.normal,
                )
                .label,
          );
        }
        if (record.hasUrine == true) parts.add('有尿');
        return parts.join(' · ');
      case RecordType.growth:
        final parts = <String>[];
        if (record.heightCm != null) parts.add('${record.heightCm}cm');
        if (record.weightKg != null) parts.add('${record.weightKg}kg');
        return parts.join(' · ');
      case RecordType.nutrition:
        return record.nutritionTypes ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final type = _recordType;
    final color = _colorFor(type);
    final subtitle = _subtitleFor(type);

    return Dismissible(
      key: ValueKey(record.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Theme.of(context).colorScheme.errorContainer,
        child: Icon(
          Icons.delete_outline,
          color: Theme.of(context).colorScheme.onErrorContainer,
        ),
      ),
      onDismissed: (_) => onDelete(),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.15),
          child: Icon(_iconFor(type), color: color, size: 22),
        ),
        title: Text(type.label),
        subtitle: subtitle.isNotEmpty ? Text(subtitle) : null,
        trailing: Text(
          formatTime(record.happenedAt),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.outline,
              ),
        ),
      ),
    );
  }
}
