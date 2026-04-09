import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yuyingbao/l10n/generated/app_localizations.dart';
import '../../baby/providers/baby_providers.dart';
import '../../record/widgets/record_form_sheet.dart';
import '../../../core/constants/enums.dart';
import '../../../shared/widgets/baby_switcher.dart';
import '../../../shared/widgets/empty_state.dart';
import '../widgets/daily_summary_card.dart';
import '../widgets/quick_record_buttons.dart';
import '../widgets/recent_records_list.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  void _openRecordForm(BuildContext context, {RecordType? initialType}) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const RecordFormSheet()),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final baby = ref.watch(selectedBabyProvider);

    return Scaffold(
      appBar: AppBar(
        title: baby != null
            ? const BabySwitcher()
            : Text(S.of(context).appTitle),
        actions: [
          if (baby != null)
            IconButton(
              icon: const Icon(Icons.add),
              tooltip: S.of(context).addRecord,
              onPressed: () => _openRecordForm(context),
            ),
        ],
      ),
      body: baby == null
          ? EmptyState(
              icon: Icons.child_care,
              message: S.of(context).noBabyYet,
            )
          : CustomScrollView(
              slivers: [
                // Daily summary card
                const SliverToBoxAdapter(child: DailySummaryCard()),

                // Quick record buttons
                SliverToBoxAdapter(
                  child: QuickRecordButtons(
                    onTap: (type) => _openRecordForm(context, initialType: type),
                  ),
                ),

                // Section header
                SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Text(
                      S.of(context).recentRecords,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),

                // Recent records list
                const RecentRecordsList(),

                // Bottom padding
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
              ],
            ),
    );
  }
}
