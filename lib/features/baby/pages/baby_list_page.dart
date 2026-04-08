import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/app_database.dart';
import '../providers/baby_providers.dart';
import '../widgets/baby_card.dart';
import 'baby_form_page.dart';
import '../../../core/database/database_providers.dart';

class BabyListPage extends ConsumerWidget {
  const BabyListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final babiesAsync = ref.watch(babiesProvider);
    final selectedBabyId = ref.watch(selectedBabyIdProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('宝宝管理'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const BabyFormPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: babiesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Text('加载失败: $error'),
        ),
        data: (babies) {
          if (babies.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.child_care, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    '还没有宝宝信息',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '点击右下角 + 添加宝宝',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: babies.length,
            itemBuilder: (context, index) {
              final baby = babies[index];
              final isSelected = baby.id == selectedBabyId ||
                  (selectedBabyId == null && index == 0);

              return BabyCard(
                baby: baby,
                isSelected: isSelected,
                onTap: () {
                  ref.read(selectedBabyIdProvider.notifier).state = baby.id;
                },
                onEdit: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => BabyFormPage(baby: baby),
                    ),
                  );
                },
                onDelete: () => _confirmDelete(context, ref, baby),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    Baby baby,
  ) async {
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
      final repo = ref.read(babyRepositoryProvider);
      await repo.deleteBaby(baby.id);

      // If the deleted baby was selected, clear the selection
      final currentSelected = ref.read(selectedBabyIdProvider);
      if (currentSelected == baby.id) {
        ref.read(selectedBabyIdProvider.notifier).state = null;
      }
    }
  }
}
