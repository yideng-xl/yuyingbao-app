import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Supported locales for the app.
const supportedLocales = [
  Locale('zh'),
  Locale('en'),
  Locale('ja'),
  Locale('ko'),
];

/// Current locale state.  `null` means follow system locale.
final localeProvider = StateProvider<Locale?>((ref) => null);
