import 'package:flutter/material.dart';
import 'package:yuyingbao/l10n/generated/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'core/l10n/locale_provider.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';

class YuyingbaoApp extends ConsumerWidget {
  const YuyingbaoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final skin = ref.watch(appSkinProvider);
    final locale = ref.watch(localeProvider);

    return MaterialApp.router(
      title: 'YuyingBao',
      theme: AppTheme.themeFor(skin),
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: S.localizationsDelegates,
      supportedLocales: supportedLocales,
      locale: locale,
    );
  }
}
