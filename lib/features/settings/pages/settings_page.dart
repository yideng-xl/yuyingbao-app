import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/database_providers.dart';
import '../../baby/providers/baby_providers.dart';
import '../../baby/widgets/baby_card.dart';
import '../../baby/pages/baby_form_page.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final babiesAsync = ref.watch(babiesProvider);
    final selectedBabyId = ref.watch(selectedBabyIdProvider);

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
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Text(title, style: Theme.of(context).textTheme.labelLarge?.copyWith(
        color: Theme.of(context).colorScheme.primary,
      )),
    );
  }
}
