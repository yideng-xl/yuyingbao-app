import 'package:flutter/material.dart';
import '../../../core/constants/enums.dart';

class QuickRecordButtons extends StatelessWidget {
  final void Function(RecordType type) onTap;

  const QuickRecordButtons({super.key, required this.onTap});

  static const _buttons = [
    _QuickButtonData(
      type: RecordType.breastfeeding,
      icon: Icons.woman,
      color: Color(0xFFFF8A65),
    ),
    _QuickButtonData(
      type: RecordType.bottle,
      icon: Icons.local_drink,
      color: Color(0xFF4FC3F7),
    ),
    _QuickButtonData(
      type: RecordType.solid,
      icon: Icons.restaurant,
      color: Color(0xFF81C784),
    ),
    _QuickButtonData(
      type: RecordType.diaper,
      icon: Icons.baby_changing_station,
      color: Color(0xFFBA68C8),
    ),
    _QuickButtonData(
      type: RecordType.growth,
      icon: Icons.straighten,
      color: Color(0xFFFFD54F),
    ),
    _QuickButtonData(
      type: RecordType.water,
      icon: Icons.water_drop,
      color: Color(0xFF4DD0E1),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _buttons.map((btn) {
          return _QuickButton(
            data: btn,
            onTap: () => onTap(btn.type),
          );
        }).toList(),
      ),
    );
  }
}

class _QuickButtonData {
  final RecordType type;
  final IconData icon;
  final Color color;

  const _QuickButtonData({
    required this.type,
    required this.icon,
    required this.color,
  });
}

class _QuickButton extends StatelessWidget {
  final _QuickButtonData data;
  final VoidCallback onTap;

  const _QuickButton({required this.data, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: data.color.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(data.icon, color: data.color, size: 24),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          data.type.label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
      ],
    );
  }
}
