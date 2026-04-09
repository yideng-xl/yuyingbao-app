import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/database_providers.dart';
import '../../../core/theme/app_theme.dart';
import '../../baby/providers/baby_providers.dart';
import '../../baby/widgets/baby_card.dart';
import '../../baby/pages/baby_form_page.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final babiesAsync = ref.watch(babiesProvider);
    final selectedBabyId = ref.watch(selectedBabyIdProvider);
    final currentSkin = ref.watch(appSkinProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('设置')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const BabyFormPage()),
        ),
        child: const Icon(Icons.add),
      ),
      body: ListView(
        children: [
          // ─── 皮肤主题 ───
          const _SectionHeader('主题风格'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: AppSkin.values.map((skin) {
                final c = AppTheme.colorsFor(skin);
                final isSelected = skin == currentSkin;
                return GestureDetector(
                  onTap: () => ref.read(appSkinProvider.notifier).state = skin,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: (MediaQuery.of(context).size.width - 44) / 2,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: c.background,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected ? c.primary : c.border,
                        width: isSelected ? 2.5 : 1.5,
                      ),
                      boxShadow: isSelected
                          ? [BoxShadow(color: c.shadowTint, blurRadius: 12, offset: const Offset(0, 4))]
                          : [],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            // Color dots preview
                            _ColorDot(c.primary),
                            const SizedBox(width: 4),
                            _ColorDot(c.primaryContainer),
                            const SizedBox(width: 4),
                            _ColorDot(c.secondary),
                            const Spacer(),
                            if (isSelected)
                              Icon(Icons.check_circle_rounded, color: c.primary, size: 20),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          skin.label,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: isSelected ? c.primary : AppTheme.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          skin.description,
                          style: const TextStyle(fontSize: 11, color: AppTheme.textMuted),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 8),
          const Divider(),

          // ─── 宝宝管理 ───
          const _SectionHeader('宝宝管理'),
          babiesAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('加载失败: $e')),
            data: (babies) {
              if (babies.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.all(32),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(Icons.child_care, size: 48, color: Colors.grey),
                        SizedBox(height: 8),
                        Text('点击右下角 + 添加宝宝', style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                );
              }
              return Column(
                children: babies.map((baby) {
                  final isSelected = baby.id == selectedBabyId ||
                      (selectedBabyId == null && baby == babies.first);
                  return BabyCard(
                    baby: baby,
                    isSelected: isSelected,
                    onTap: () {
                      ref.read(selectedBabyIdProvider.notifier).state = baby.id;
                    },
                    onEdit: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => BabyFormPage(baby: baby)),
                    ),
                    onDelete: () => _confirmDelete(context, ref, baby),
                  );
                }).toList(),
              );
            },
          ),
          const Divider(),

          // ─── 关于 ───
          const _SectionHeader('关于'),
          const ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('育婴宝'),
            subtitle: Text('版本 1.0.0'),
          ),
          const ListTile(
            leading: Icon(Icons.code),
            title: Text('开源地址'),
            subtitle: Text('github.com/yideng-xl/yuyingbao-app'),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref, Baby baby) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('删除宝宝'),
        content: Text('确定要删除「${baby.name}」的所有信息吗？此操作不可恢复。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('删除'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref.read(babyRepositoryProvider).deleteBaby(baby.id);
      final currentSelected = ref.read(selectedBabyIdProvider);
      if (currentSelected == baby.id) {
        ref.read(selectedBabyIdProvider.notifier).state = null;
      }
    }
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(title, style: Theme.of(context).textTheme.labelLarge?.copyWith(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w700,
      )),
    );
  }
}

class _ColorDot extends StatelessWidget {
  final Color color;
  const _ColorDot(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 1.5),
        boxShadow: [
          BoxShadow(color: color.withValues(alpha: 0.3), blurRadius: 4),
        ],
      ),
    );
  }
}
