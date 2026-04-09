import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../core/constants/enums.dart';
import '../../../core/theme/app_theme.dart';

class QuickRecordButtons extends ConsumerWidget {
  final void Function(RecordType type) onTap;

  const QuickRecordButtons({super.key, required this.onTap});

  static const _buttons = [
    _QuickButtonData(type: RecordType.breastfeeding, icon: Icons.woman_rounded, color: AppTheme.breastfeedingColor),
    _QuickButtonData(type: RecordType.bottle, icon: Icons.local_drink_rounded, color: AppTheme.bottleColor),
    _QuickButtonData(type: RecordType.solid, icon: Icons.restaurant_rounded, color: AppTheme.solidColor),
    _QuickButtonData(type: RecordType.diaper, icon: Icons.baby_changing_station_rounded, color: AppTheme.diaperColor),
    _QuickButtonData(type: RecordType.growth, icon: Icons.straighten_rounded, color: AppTheme.growthColor),
    _QuickButtonData(type: RecordType.water, icon: Icons.water_drop_rounded, color: AppTheme.waterColor),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final skin = ref.watch(appSkinProvider);
    final c = AppTheme.colorsFor(skin);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Container(
        decoration: AppTheme.clayCard(c),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _buttons.map((btn) {
            return _QuickButton(data: btn, onTap: () => onTap(btn.type));
          }).toList(),
        ),
      ),
    );
  }
}

class _QuickButtonData {
  final RecordType type;
  final IconData icon;
  final Color color;
  const _QuickButtonData({required this.type, required this.icon, required this.color});
}

class _QuickButton extends StatelessWidget {
  final _QuickButtonData data;
  final VoidCallback onTap;

  const _QuickButton({required this.data, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: data.color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: data.color.withValues(alpha: 0.2), width: 1.5),
            ),
            child: Icon(data.icon, color: data.color, size: 26),
          ),
          const SizedBox(height: 6),
          Text(
            data.type.label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppTheme.textMuted,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
