import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yuyingbao/l10n/generated/app_localizations.dart';
import '../../core/database/app_database.dart';
import '../../core/theme/app_theme.dart';
import '../../features/baby/providers/baby_providers.dart';

class BabySwitcher extends ConsumerWidget {
  const BabySwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final baby = ref.watch(selectedBabyProvider);
    final babiesAsync = ref.watch(babiesProvider);
    final skin = ref.watch(appSkinProvider);
    final c = AppTheme.colorsFor(skin);

    if (baby == null) return const SizedBox.shrink();

    final hasMultiple = (babiesAsync.valueOrNull?.length ?? 0) > 1;

    return GestureDetector(
      onTap: hasMultiple
          ? () => _showSwitcher(context, ref, babiesAsync.valueOrNull ?? [], baby.id, c)
          : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: c.border, width: 1.5),
          boxShadow: [
            BoxShadow(color: c.shadowTint, offset: const Offset(0, 2), blurRadius: 6),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: baby.gender == 'male' ? c.avatarGradientBoy : c.avatarGradientGirl,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  baby.name.characters.first,
                  style: const TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              baby.name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppTheme.textPrimary),
            ),
            if (hasMultiple) ...[
              const SizedBox(width: 2),
              const Icon(Icons.keyboard_arrow_down_rounded, size: 20, color: AppTheme.textMuted),
            ],
          ],
        ),
      ),
    );
  }

  void _showSwitcher(BuildContext context, WidgetRef ref, List<Baby> babies, String currentId, SkinColors c) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        final s = S.of(context);
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              Container(
                width: 36, height: 4,
                decoration: BoxDecoration(
                  color: c.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(s.switchBaby, style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                )),
              ),
              ...babies.map((baby) {
                final isSelected = baby.id == currentId;
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                  decoration: isSelected ? AppTheme.clayCardSelected(c) : null,
                  child: ListTile(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: baby.gender == 'male' ? c.avatarGradientBoy : c.avatarGradientGirl,
                        ),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Center(
                        child: Text(
                          baby.name.characters.first,
                          style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    title: Text(baby.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                    trailing: isSelected
                        ? Icon(Icons.check_circle_rounded, color: c.primary)
                        : null,
                    onTap: () {
                      ref.read(selectedBabyIdProvider.notifier).state = baby.id;
                      Navigator.pop(context);
                    },
                  ),
                );
              }),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}
