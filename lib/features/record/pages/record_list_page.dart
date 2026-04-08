import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../core/database/database_providers.dart';
import '../../../shared/utils/date_utils.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../baby/providers/baby_providers.dart';
import '../providers/record_providers.dart';
import '../widgets/record_form_sheet.dart';
import '../widgets/record_tile.dart';

class RecordListPage extends HookConsumerWidget {
  const RecordListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider);
    final recordsAsync = ref.watch(selectedDateRecordsProvider);
    final baby = ref.watch(selectedBabyProvider);

    void goToPrevDay() {
      ref.read(selectedDateProvider.notifier).state =
          selectedDate.subtract(const Duration(days: 1));
    }

    void goToNextDay() {
      final tomorrow = selectedDate.add(const Duration(days: 1));
      if (tomorrow.isBefore(DateTime.now().add(const Duration(days: 1)))) {
        ref.read(selectedDateProvider.notifier).state = tomorrow;
      }
    }

    Future<void> pickDate() async {
      final picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2020),
        lastDate: DateTime.now(),
      );
      if (picked != null) {
        ref.read(selectedDateProvider.notifier).state = picked;
      }
    }

    void openAddForm() {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => const RecordFormSheet(),
      );
    }

    final isToday = formatDate(selectedDate) == formatDate(DateTime.now());
    final dateLabel = formatRelativeDate(selectedDate);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: goToPrevDay,
              tooltip: '前一天',
            ),
            TextButton(
              onPressed: pickDate,
              child: Text(
                dateLabel,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.chevron_right),
              onPressed: isToday ? null : goToNextDay,
              tooltip: '后一天',
            ),
          ],
        ),
        centerTitle: true,
      ),
      floatingActionButton: baby == null
          ? null
          : FloatingActionButton(
              onPressed: openAddForm,
              tooltip: '添加记录',
              child: const Icon(Icons.add),
            ),
      body: baby == null
          ? const EmptyState(
              icon: Icons.child_care,
              message: '请先添加宝宝信息',
            )
          : recordsAsync.when(
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (err, _) => Center(child: Text('加载失败: $err')),
              data: (records) {
                if (records.isEmpty) {
                  return EmptyState(
                    icon: Icons.event_note_outlined,
                    message: '$dateLabel暂无记录',
                    actionLabel: '添加记录',
                    onAction: openAddForm,
                  );
                }
                return ListView.separated(
                  itemCount: records.length,
                  separatorBuilder: (_, __) =>
                      const Divider(height: 1, indent: 72),
                  itemBuilder: (context, index) {
                    final record = records[index];
                    return RecordTile(
                      record: record,
                      onDelete: () {
                        ref
                            .read(recordRepositoryProvider)
                            .deleteRecord(record.id);
                      },
                    );
                  },
                );
              },
            ),
    );
  }
}
