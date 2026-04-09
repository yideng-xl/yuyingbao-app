import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:yuyingbao/l10n/generated/app_localizations.dart';
import 'package:intl/intl.dart';
import '../../../repositories/record_repository.dart';

/// Line chart showing daily diaper record counts.
class DiaperChart extends StatelessWidget {
  final List<BabyRecord> records;

  const DiaperChart({super.key, required this.records});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final dailyCounts = _buildDailyCounts();

    if (dailyCounts.isEmpty) {
      return SizedBox(
        height: 200,
        child: Center(child: Text(s.noDiaperData)),
      );
    }

    final sortedDates = dailyCounts.keys.toList()..sort();
    final maxY = (dailyCounts.values
                .reduce((a, b) => a > b ? a : b)
                .toDouble() +
            1)
        .ceilToDouble();

    final spots = sortedDates.asMap().entries.map((entry) {
      return FlSpot(
        entry.key.toDouble(),
        dailyCounts[entry.value]!.toDouble(),
      );
    }).toList();

    final dateFormat = DateFormat('MM/dd');

    return SizedBox(
      height: 220,
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              color: Theme.of(context).colorScheme.tertiary,
              barWidth: 2,
              isCurved: true,
              dotData: const FlDotData(show: true),
              belowBarData: BarAreaData(
                show: true,
                color: Theme.of(context)
                    .colorScheme
                    .tertiary
                    .withValues(alpha: 0.15),
              ),
            ),
          ],
          minY: 0,
          maxY: maxY,
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
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
                reservedSize: 32,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  if (value != value.roundToDouble()) {
                    return const SizedBox.shrink();
                  }
                  return SideTitleWidget(
                    meta: meta,
                    child: Text(
                      '${value.toInt()}${s.diaperCountUnit}',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  );
                },
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
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (_) =>
                  Theme.of(context).colorScheme.inverseSurface,
              getTooltipItems: (touchedSpots) {
                return touchedSpots.map((spot) {
                  final idx = spot.x.toInt();
                  final date = sortedDates[idx];
                  return LineTooltipItem(
                    '${dateFormat.format(date)}\n${s.diaperChangesCount(spot.y.toInt())}',
                    TextStyle(
                      color: Theme.of(context).colorScheme.onInverseSurface,
                      fontSize: 12,
                    ),
                  );
                }).toList();
              },
            ),
          ),
        ),
      ),
    );
  }

  Map<DateTime, int> _buildDailyCounts() {
    final result = <DateTime, int>{};
    for (final record in records) {
      if (record.type != 'diaper') continue;
      final day = DateTime(
        record.happenedAt.year,
        record.happenedAt.month,
        record.happenedAt.day,
      );
      result[day] = (result[day] ?? 0) + 1;
    }
    return result;
  }
}
