import 'package:flutter/material.dart';
import 'package:yuyingbao/l10n/generated/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/l10n/l10n_extensions.dart';
import '../../../features/baby/providers/baby_providers.dart';
import '../../../services/statistics_service.dart';
import '../../../shared/widgets/baby_switcher.dart';
import '../../../shared/widgets/empty_state.dart';
import '../providers/statistics_providers.dart';
import '../widgets/diaper_chart.dart';
import '../widgets/feeding_chart.dart';
import '../widgets/growth_curve_chart.dart';

class StatisticsPage extends ConsumerWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final baby = ref.watch(selectedBabyProvider);
    final s = S.of(context);

    if (baby == null) {
      return Scaffold(
        body: EmptyState(
          icon: Icons.bar_chart_outlined,
          message: s.addBabyFirst,
        ),
      );
    }

    final timeRange = ref.watch(timeRangeProvider);
    final recordsAsync = ref.watch(statsRecordsProvider);
    final gender = baby.gender;

    final whoWeightAsync = ref.watch(whoWeightDataProvider(gender));
    final whoHeightAsync = ref.watch(whoHeightDataProvider(gender));
    final allRecordsAsync = ref.watch(allGrowthRecordsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const BabySwitcher(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Time range selector
            Center(
              child: SegmentedButton<StatsTimeRange>(
                segments: StatsTimeRange.values
                    .map((r) => ButtonSegment(value: r, label: Text(r.l10n(s))))
                    .toList(),
                selected: {timeRange},
                onSelectionChanged: (selected) {
                  ref.read(timeRangeProvider.notifier).state = selected.first;
                },
              ),
            ),
            const SizedBox(height: 24),

            // Feeding chart
            _SectionCard(
              title: s.feedingVolumeTitle,
              child: recordsAsync.when(
                data: (records) {
                  final totals =
                      StatisticsService.dailyFeedingTotals(records);
                  return FeedingChart(dailyTotals: totals);
                },
                loading: () =>
                    const SizedBox(height: 200, child: _LoadingIndicator()),
                error: (e, _) => _ErrorText(e),
              ),
            ),
            const SizedBox(height: 16),

            // Growth curve – weight
            _SectionCard(
              title: s.whoWeightTitle,
              child: whoWeightAsync.when(
                data: (whoData) {
                  final allRecords =
                      allRecordsAsync.valueOrNull ?? <dynamic>[];
                  final weightPoints = _buildGrowthPoints(
                    records: allRecords.cast(),
                    type: 'growth',
                    valueExtractor: (r) => r.weightKg,
                    birthDate: baby.birthDate,
                  );
                  return GrowthCurveChart(
                    whoData: whoData,
                    babyData: weightPoints,
                    yLabel: 'kg',
                    title: s.weight,
                  );
                },
                loading: () =>
                    const SizedBox(height: 260, child: _LoadingIndicator()),
                error: (e, _) => _ErrorText(e),
              ),
            ),
            const SizedBox(height: 16),

            // Growth curve – height
            _SectionCard(
              title: s.whoHeightTitle,
              child: whoHeightAsync.when(
                data: (whoData) {
                  final allRecords =
                      allRecordsAsync.valueOrNull ?? <dynamic>[];
                  final heightPoints = _buildGrowthPoints(
                    records: allRecords.cast(),
                    type: 'growth',
                    valueExtractor: (r) => r.heightCm,
                    birthDate: baby.birthDate,
                  );
                  return GrowthCurveChart(
                    whoData: whoData,
                    babyData: heightPoints,
                    yLabel: 'cm',
                    title: s.height,
                  );
                },
                loading: () =>
                    const SizedBox(height: 260, child: _LoadingIndicator()),
                error: (e, _) => _ErrorText(e),
              ),
            ),
            const SizedBox(height: 16),

            // Diaper chart
            _SectionCard(
              title: s.diaperCountTitle,
              child: recordsAsync.when(
                data: (records) => DiaperChart(records: records),
                loading: () =>
                    const SizedBox(height: 200, child: _LoadingIndicator()),
                error: (e, _) => _ErrorText(e),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  /// Builds (ageInMonths, value) pairs from growth records.
  List<(double, double)> _buildGrowthPoints({
    required List<dynamic> records,
    required String type,
    required double? Function(dynamic r) valueExtractor,
    required DateTime birthDate,
  }) {
    final points = <(double, double)>[];
    for (final record in records) {
      if (record.type != type) continue;
      final value = valueExtractor(record);
      if (value == null) continue;
      final happenedAt = record.happenedAt as DateTime;
      final ageMonths = (happenedAt.year - birthDate.year) * 12.0 +
          (happenedAt.month - birthDate.month) +
          (happenedAt.day - birthDate.day) / 30.0;
      if (ageMonths >= 0) {
        points.add((ageMonths, value));
      }
    }
    points.sort((a, b) => a.$1.compareTo(b.$1));
    return points;
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _SectionCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class _ErrorText extends StatelessWidget {
  final Object error;

  const _ErrorText(this.error);

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        s.loadError(error.toString()),
        style: TextStyle(color: Theme.of(context).colorScheme.error),
      ),
    );
  }
}
