import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:yuyingbao/l10n/generated/app_localizations.dart';
import 'package:intl/intl.dart';

/// Bar chart showing daily feeding totals (ml) over a date range.
class FeedingChart extends StatelessWidget {
  /// Map from date (time zeroed) to total ml for that day.
  final Map<DateTime, double> dailyTotals;

  const FeedingChart({super.key, required this.dailyTotals});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    if (dailyTotals.isEmpty) {
      return SizedBox(
        height: 200,
        child: Center(child: Text(s.noFeedingData)),
      );
    }

    final sortedDates = dailyTotals.keys.toList()..sort();
    final maxY = (dailyTotals.values.reduce((a, b) => a > b ? a : b) * 1.2)
        .ceilToDouble();

    final barGroups = sortedDates.asMap().entries.map((entry) {
      final idx = entry.key;
      final date = entry.value;
      final total = dailyTotals[date] ?? 0.0;
      return BarChartGroupData(
        x: idx,
        barRods: [
          BarChartRodData(
            toY: total,
            color: Theme.of(context).colorScheme.primary,
            width: 16,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
          ),
        ],
      );
    }).toList();

    final dateFormat = DateFormat('MM/dd');

    return SizedBox(
      height: 220,
      child: BarChart(
        BarChartData(
          maxY: maxY,
          barGroups: barGroups,
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: maxY / 4,
            getDrawingHorizontalLine: (value) => FlLine(
              color: Theme.of(context)
                  .colorScheme
                  .outlineVariant
                  .withValues(alpha: 0.5),
              strokeWidth: 1,
            ),
          ),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(),
            rightTitles: const AxisTitles(),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 48,
                interval: maxY / 4,
                getTitlesWidget: (value, meta) => SideTitleWidget(
                  meta: meta,
                  child: Text(
                    '${value.toInt()}${s.amountMlUnit}',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 24,
                getTitlesWidget: (value, meta) {
                  final idx = value.toInt();
                  if (idx < 0 || idx >= sortedDates.length) {
                    return const SizedBox.shrink();
                  }
                  return SideTitleWidget(
                    meta: meta,
                    child: Text(
                      dateFormat.format(sortedDates[idx]),
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  );
                },
              ),
            ),
          ),
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (_) =>
                  Theme.of(context).colorScheme.inverseSurface,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                final date = sortedDates[group.x];
                return BarTooltipItem(
                  '${dateFormat.format(date)}\n${rod.toY.toStringAsFixed(0)}${s.amountMlUnit}',
                  TextStyle(
                    color: Theme.of(context).colorScheme.onInverseSurface,
                    fontSize: 12,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
