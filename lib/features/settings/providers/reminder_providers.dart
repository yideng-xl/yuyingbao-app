import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Whether the feeding reminder is enabled.
final feedingReminderEnabledProvider = StateProvider<bool>((ref) => false);

/// Feeding reminder interval in hours (default 2).
final feedingIntervalHoursProvider = StateProvider<double>((ref) => 2.0);
