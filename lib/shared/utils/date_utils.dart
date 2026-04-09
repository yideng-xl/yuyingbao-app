import 'package:intl/intl.dart';
import 'package:yuyingbao/l10n/generated/app_localizations.dart';

final _dateFormat = DateFormat('yyyy-MM-dd');
final _timeFormat = DateFormat('HH:mm');
final _dateTimeFormat = DateFormat('yyyy-MM-dd HH:mm');

String formatDate(DateTime date) => _dateFormat.format(date);
String formatTime(DateTime date) => _timeFormat.format(date);
String formatDateTime(DateTime date) => _dateTimeFormat.format(date);

/// Returns localized "today", "yesterday", or formatted date
/// Requires [s] parameter for i18n strings (today, yesterday, dayBeforeYesterday)
String formatRelativeDate(DateTime date, S s) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final target = DateTime(date.year, date.month, date.day);
  final diff = today.difference(target).inDays;

  if (diff == 0) return s.today;
  if (diff == 1) return s.yesterday;
  if (diff == 2) return s.dayBeforeYesterday;
  return _dateFormat.format(date);
}

/// Start of today (00:00:00)
DateTime startOfDay(DateTime date) => DateTime(date.year, date.month, date.day);

/// End of today (23:59:59.999)
DateTime endOfDay(DateTime date) =>
    DateTime(date.year, date.month, date.day, 23, 59, 59, 999);

/// Calculate baby age in months from birthDate
int ageInMonths(DateTime birthDate) {
  final now = DateTime.now();
  return (now.year - birthDate.year) * 12 + now.month - birthDate.month;
}
