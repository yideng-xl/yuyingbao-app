import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../record/providers/record_providers.dart';
import '../../record/widgets/record_tile.dart';
import '../../../core/database/database_providers.dart';
import '../../../shared/widgets/empty_state.dart';

class RecentRecordsList extends ConsumerWidget {
  const RecentRecordsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recordsAsync = ref.watch(recentRecordsProvider);

    return recordsAsync.when(
      data: (records) {
        if (records.isEmpty) {
          return const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 48),
              child: EmptyState(
                icon: Icons.note_alt_outlined,
                message: '还没有记录，快去添加吧',
              ),
            ),
          );
        }

        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final record = records[index];
              return RecordTile(
                record: record,
                onDelete: () {
                  ref.read(recordRepositoryProvider).deleteRecord(record.id);
                  ref.invalidate(recentRecordsProvider);
                },
              );
            },
            childCount: records.length,
          ),
        );
      },
      loading: () => const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 48),
          child: Center(child: CircularProgressIndicator()),
        ),
      ),
      error: (error, _) => SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 48),
          child: EmptyState(
            icon: Icons.error_outline,
            message: '加载失败: $error',
          ),
        ),
      ),
    );
  }
}
