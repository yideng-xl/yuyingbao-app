import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

/// A line chart showing WHO percentile curves alongside the baby's growth data.
///
/// [whoData] is a list of maps with keys: month, P3, P15, P50, P85, P97.
/// [babyData] is a list of (ageInMonths, value) pairs (weight in kg or height in cm).
/// [yLabel] is the y-axis unit string, e.g. 'kg' or 'cm'.
/// [title] is the card title, e.g. '体重' or '身高'.
class GrowthCurveChart extends StatelessWidget {
  final List<Map<String, dynamic>> whoData;
  final List<(double, double)> babyData;
  final String yLabel;
  final String title;

  const GrowthCurveChart({
    super.key,
    required this.whoData,
    required this.babyData,
    required this.yLabel,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    if (whoData.isEmpty) {
      return const SizedBox(
        height: 260,
        child: Center(child: Text('暂无参考数据')),
      );
    }

    // Build WHO percentile line data
    final p3Spots = _buildSpots('P3');
    final p15Spots = _buildSpots('P15');
    final p50Spots = _buildSpots('P50');
    final p85Spots = _buildSpots('P85');
    final p97Spots = _buildSpots('P97');

    // Baby's actual data spots
    final babySpots =
        babyData.map((d) => FlSpot(d.$1, d.$2)).toList();

    final greyColor =
        Theme.of(context).colorScheme.outline.withValues(alpha: 0.6);
    const greenColor = Color(0xFF4CAF50);
    const babyColor = Color(0xFFFF8A65);

    final dashArray = [4, 4];

    final lineBarsData = [
      // P3 dashed
      LineChartBarData(
        spots: p3Spots,
        color: greyColor,
        barWidth: 1,
        isCurved: true,
        dashArray: dashArray,
        dotData: const FlDotData(show: false),
      ),
      // P15 dashed
      LineChartBarData(
        spots: p15Spots,
        color: greyColor,
        barWidth: 1,
        isCurved: true,
        dashArray: dashArray,
        dotData: const FlDotData(show: false),
      ),
      // P50 solid green
      LineChartBarData(
        spots: p50Spots,
        color: greenColor,
        barWidth: 2,
        isCurved: true,
        dotData: const FlDotData(show: false),
      ),
      // P85 dashed
      LineChartBarData(
        spots: p85Spots,
        color: greyColor,
        barWidth: 1,
        isCurved: true,
        dashArray: dashArray,
        dotData: const FlDotData(show: false),
      ),
      // P97 dashed
      LineChartBarData(
        spots: p97Spots,
        color: greyColor,
        barWidth: 1,
        isCurved: true,
        dashArray: dashArray,
        dotData: const FlDotData(show: false),
      ),
      // Baby data — thick orange
      if (babySpots.isNotEmpty)
        LineChartBarData(
          spots: babySpots,
          color: babyColor,
          barWidth: 3,
          isCurved: true,
          dotData: const FlDotData(show: true),
        ),
    ];

    final allValues = [
      ...whoData.map((d) => (d['P3'] as num).toDouble()),
      ...whoData.map((d) => (d['P97'] as num).toDouble()),
      if (babySpots.isNotEmpty) ...babySpots.map((s) => s.y),
    ];
    final minY = (allValues.reduce((a, b) => a < b ? a : b) - 2.0)
        .clamp(0.0, double.infinity);
    final maxY = allValues.reduce((a, b) => a > b ? a : b) + 2.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 8),
          child: Row(
            children: [
              Text(title,
                  style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(width: 12),
              const _LegendDot(color: Color(0xFF4CAF50), label: 'P50'),
              const SizedBox(width: 8),
              _LegendDot(
                  color: Theme.of(context).colorScheme.outline,
                  label: 'P3/P15/P85/P97'),
              const SizedBox(width: 8),
              const _LegendDot(color: babyColor, label: '宝宝'),
            ],
          ),
        ),
        SizedBox(
          height: 240,
          child: LineChart(
            LineChartData(
              lineBarsData: lineBarsData,
              minY: minY,
              maxY: maxY,
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                getDrawingHorizontalLine: (value) => FlLine(
                  color: Theme.of(context)
                      .colorScheme
                      .outlineVariant
                      .withValues(alpha: 0.4),
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
                    reservedSize: 44,
                    getTitlesWidget: (value, meta) => SideTitleWidget(
                      meta: meta,
                      child: Text(
                        '${value.toStringAsFixed(1)}$yLabel',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 24,
                    interval: 3,
                    getTitlesWidget: (value, meta) => SideTitleWidget(
                      meta: meta,
                      child: Text(
                        '${value.toInt()}m',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                  ),
                ),
              ),
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  getTooltipColor: (_) =>
                      Theme.of(context).colorScheme.inverseSurface,
                  getTooltipItems: (spots) {
                    return spots.map((spot) {
                      return LineTooltipItem(
                        '${spot.x.toStringAsFixed(0)}月: ${spot.y.toStringAsFixed(1)}$yLabel',
                        TextStyle(
                          color: spot.bar.color ?? Colors.white,
                          fontSize: 11,
                        ),
                      );
                    }).toList();
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<FlSpot> _buildSpots(String percentileKey) {
    return whoData
        .where((d) => d[percentileKey] != null)
        .map((d) => FlSpot(
              (d['month'] as num).toDouble(),
              (d[percentileKey] as num).toDouble(),
            ))
        .toList();
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 4,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 4),
        Text(label, style: Theme.of(context).textTheme.labelSmall),
      ],
    );
  }
}
