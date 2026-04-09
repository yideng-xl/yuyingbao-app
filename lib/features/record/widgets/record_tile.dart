import 'package:flutter/material.dart';
import 'package:yuyingbao/l10n/generated/app_localizations.dart';
import '../../../core/constants/enums.dart';
import '../../../core/l10n/l10n_extensions.dart';
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

  String _subtitleFor(RecordType type, S l10n) {
    switch (type) {
      case RecordType.breastfeeding:
        final side = record.breastfeedingSide != null
            ? BreastfeedingSide.values
                .firstWhere(
                  (e) => e.name == record.breastfeedingSide,
                  orElse: () => BreastfeedingSide.left,
                )
                .l10n(l10n)
            : '';
        final duration = record.durationMin != null ? ' ${record.durationMin}${l10n.durationMinutesUnit}' : '';
        return '$side$duration'.trim();
      case RecordType.bottle:
      case RecordType.formula:
      case RecordType.water:
        if (record.amountMl != null) {
          return '${record.amountMl!.toStringAsFixed(0)}${l10n.amountMlUnit}';
        }
        return '';
      case RecordType.solid:
        if (record.solidType != null) {
          return SolidType.values
              .firstWhere(
                (e) => e.name == record.solidType,
                orElse: () => SolidType.other,
              )
              .l10n(l10n);
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
                .l10n(l10n),
          );
        }
        if (record.hasUrine == true) parts.add(l10n.hasUrineText);
        return parts.join(' · ');
      case RecordType.growth:
        final parts = <String>[];
        if (record.heightCm != null) parts.add('${record.heightCm}${l10n.heightCmUnit}');
        if (record.weightKg != null) parts.add('${record.weightKg}${l10n.weightKgUnit}');
        return parts.join(' · ');
      case RecordType.nutrition:
        return record.nutritionTypes ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final type = _recordType;
    final color = _colorFor(type);
    final l10n = S.of(context);
    final subtitle = _subtitleFor(type, l10n);

    return Dismissible(
      key: ValueKey(record.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Theme.of(context).colorScheme.error,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.delete_outline, color: Colors.white),
            const SizedBox(width: 4),
            Text(l10n.delete, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            const SizedBox(width: 8),
          ],
        ),
      ),
      confirmDismiss: (_) async {
        return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(l10n.confirmDelete),
            content: Text(l10n.deleteRecordConfirm(type.l10n(l10n))),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(l10n.cancel),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: Text(l10n.delete),
              ),
            ],
          ),
        ) ?? false;
      },
      onDismissed: (_) => onDelete(),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: color.withValues(alpha: 0.2), width: 1.5),
          ),
          child: Icon(_iconFor(type), color: color, size: 22),
        ),
        title: Text(type.l10n(l10n), style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: subtitle.isNotEmpty
            ? Text(subtitle, style: TextStyle(color: Theme.of(context).colorScheme.outline, fontSize: 13))
            : null,
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            formatTime(record.happenedAt),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.outline,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
