import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../core/database/app_database.dart';
import '../../features/baby/providers/baby_providers.dart';

/// A tappable baby avatar + name for AppBar, opens a bottom sheet to switch babies.
class BabySwitcher extends ConsumerWidget {
  const BabySwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final baby = ref.watch(selectedBabyProvider);
    final babiesAsync = ref.watch(babiesProvider);

    if (baby == null) return const SizedBox.shrink();

    return GestureDetector(
      onTap: () {
        final babies = babiesAsync.valueOrNull ?? [];
        if (babies.length <= 1) return;
        _showSwitcher(context, ref, babies, baby.id);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 14,
            backgroundColor: baby.gender == 'male'
                ? const Color(0xFF81D4FA)
                : const Color(0xFFFFB74D),
            child: Text(
              baby.name.characters.first,
              style: const TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
          const SizedBox(width: 6),
          Text(baby.name, style: Theme.of(context).textTheme.titleMedium),
          if ((babiesAsync.valueOrNull?.length ?? 0) > 1)
            const Icon(Icons.arrow_drop_down, size: 20),
        ],
      ),
    );
  }

  void _showSwitcher(BuildContext context, WidgetRef ref, List<Baby> babies, String currentId) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text('切换宝宝', style: Theme.of(context).textTheme.titleMedium),
              ),
              ...babies.map((baby) {
                final isSelected = baby.id == currentId;
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: baby.gender == 'male'
                        ? const Color(0xFF81D4FA)
                        : const Color(0xFFFFB74D),
                    child: Text(
                      baby.name.characters.first,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(baby.name),
                  trailing: isSelected ? const Icon(Icons.check, color: Color(0xFFFFB74D)) : null,
                  onTap: () {
                    ref.read(selectedBabyIdProvider.notifier).state = baby.id;
                    Navigator.pop(context);
                  },
                );
              }),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }
}
