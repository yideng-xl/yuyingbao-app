import 'package:flutter/material.dart';
import 'package:yuyingbao/l10n/generated/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/database_providers.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/l10n/l10n_extensions.dart';
import '../../../core/l10n/locale_provider.dart';
import '../../../services/notification_service.dart';
import '../../baby/providers/baby_providers.dart';
import '../../baby/widgets/baby_card.dart';
import '../../baby/pages/baby_form_page.dart';
import '../providers/reminder_providers.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final babiesAsync = ref.watch(babiesProvider);
    final selectedBabyId = ref.watch(selectedBabyIdProvider);
    final currentSkin = ref.watch(appSkinProvider);

    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).navSettings)),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const BabyFormPage()),
        ),
        child: const Icon(Icons.add),
      ),
      body: ListView(
        children: [
          // ─── 皮肤主题 ───
          _SectionHeader(S.of(context).sectionTheme),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: AppSkin.values.map((skin) {
                final c = AppTheme.colorsFor(skin);
                final isSelected = skin == currentSkin;
                return GestureDetector(
                  onTap: () => ref.read(appSkinProvider.notifier).state = skin,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: (MediaQuery.of(context).size.width - 44) / 2,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: c.background,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected ? c.primary : c.border,
                        width: isSelected ? 2.5 : 1.5,
                      ),
                      boxShadow: isSelected
                          ? [BoxShadow(color: c.shadowTint, blurRadius: 12, offset: const Offset(0, 4))]
                          : [],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            // Color dots preview
                            _ColorDot(c.primary),
                            const SizedBox(width: 4),
                            _ColorDot(c.primaryContainer),
                            const SizedBox(width: 4),
                            _ColorDot(c.secondary),
                            const Spacer(),
                            if (isSelected)
                              Icon(Icons.check_circle_rounded, color: c.primary, size: 20),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          skin.l10nLabel(S.of(context)),
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: isSelected ? c.primary : AppTheme.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          skin.l10nDescription(S.of(context)),
                          style: const TextStyle(fontSize: 11, color: AppTheme.textMuted),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 8),
          const Divider(),

          // ─── 宝宝管理 ───
          _SectionHeader(S.of(context).sectionBabyManagement),
          babiesAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text(S.of(context).loadError(e.toString()))),
            data: (babies) {
              if (babies.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(32),
                  child: Center(
                    child: Column(
                      children: [
                        const Icon(Icons.child_care, size: 48, color: Colors.grey),
                        const SizedBox(height: 8),
                        Text(S.of(context).addBabyHint, style: const TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                );
              }
              return Column(
                children: babies.map((baby) {
                  final isSelected = baby.id == selectedBabyId ||
                      (selectedBabyId == null && baby == babies.first);
                  return BabyCard(
                    baby: baby,
                    isSelected: isSelected,
                    onTap: () {
                      ref.read(selectedBabyIdProvider.notifier).state = baby.id;
                    },
                    onEdit: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => BabyFormPage(baby: baby)),
                    ),
                    onDelete: () => _confirmDelete(context, ref, baby),
                  );
                }).toList(),
              );
            },
          ),
          const Divider(),

          // ─── 喂奶提醒 ───
          _SectionHeader(S.of(context).feedingReminder),
          const _FeedingReminderSection(),
          const Divider(),

          // ─── 语言 ───
          _SectionHeader(S.of(context).sectionLanguage),
          const _LanguageSection(),
          const Divider(),

          // ─── 关于 ───
          _SectionHeader(S.of(context).sectionAbout),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: Text(S.of(context).appName),
            subtitle: Text(S.of(context).version('0.6.0')),
          ),
          ListTile(
            leading: const Icon(Icons.code),
            title: Text(S.of(context).openSource),
            subtitle: const Text('github.com/yideng-xl/yuyingbao-app'),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref, Baby baby) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(S.of(context).deleteBaby),
        content: Text(S.of(context).deleteBabyConfirm(baby.name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(S.of(context).cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text(S.of(context).delete),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref.read(babyRepositoryProvider).deleteBaby(baby.id);
      final currentSelected = ref.read(selectedBabyIdProvider);
      if (currentSelected == baby.id) {
        ref.read(selectedBabyIdProvider.notifier).state = null;
      }
    }
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(title, style: Theme.of(context).textTheme.labelLarge?.copyWith(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w700,
      )),
    );
  }
}

class _ColorDot extends StatelessWidget {
  final Color color;
  const _ColorDot(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 1.5),
        boxShadow: [
          BoxShadow(color: color.withValues(alpha: 0.3), blurRadius: 4),
        ],
      ),
    );
  }
}

class _FeedingReminderSection extends ConsumerWidget {
  const _FeedingReminderSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S.of(context);
    final enabled = ref.watch(feedingReminderEnabledProvider);
    final intervalHours = ref.watch(feedingIntervalHoursProvider);

    return Column(
      children: [
        SwitchListTile(
          secondary: const Icon(Icons.notifications_active_outlined),
          title: Text(s.feedingReminderEnabled),
          subtitle: Text(s.feedingReminderDesc),
          value: enabled,
          onChanged: (value) async {
            ref.read(feedingReminderEnabledProvider.notifier).state = value;
            if (value) {
              final granted = await NotificationService().requestPermission();
              if (granted) {
                await NotificationService().scheduleFeedingReminder(
                  intervalMinutes: (intervalHours * 60).round(),
                  title: s.feedingReminderTitle,
                  body: s.feedingReminderNotification,
                );
              } else {
                ref.read(feedingReminderEnabledProvider.notifier).state = false;
              }
            } else {
              await NotificationService().cancelFeedingReminder();
            }
          },
        ),
        if (enabled)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Icon(Icons.timer_outlined, size: 20),
                const SizedBox(width: 12),
                Text(s.feedingIntervalHours),
                const Spacer(),
                DropdownButton<double>(
                  value: intervalHours,
                  items: [1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0]
                      .map((h) => DropdownMenuItem(
                            value: h,
                            child: Text('$h h'),
                          ))
                      .toList(),
                  onChanged: (value) async {
                    if (value == null) return;
                    ref.read(feedingIntervalHoursProvider.notifier).state =
                        value;
                    await NotificationService().scheduleFeedingReminder(
                      intervalMinutes: (value * 60).round(),
                      title: s.feedingReminderTitle,
                      body: s.feedingReminderNotification,
                    );
                  },
                ),
              ],
            ),
          ),
        const SizedBox(height: 8),
      ],
    );
  }
}

class _LanguageSection extends ConsumerWidget {
  const _LanguageSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(localeProvider);
    final s = S.of(context);

    final languages = [
      ('zh', s.languageZh, s.languageZh),
      ('en', s.languageEn, s.languageEn),
      ('ja', s.languageJa, s.languageJa),
      ('ko', s.languageKo, s.languageKo),
    ];

    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.language),
          title: Text(s.sectionLanguage),
          subtitle: Text(
            currentLocale == null
                ? s.languageFollowSystem
                : languages
                    .where((l) => l.$1 == currentLocale.languageCode)
                    .firstOrNull?.$3 ??
                s.languageFollowSystem,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(s.languageFollowSystem),
                trailing: currentLocale == null
                    ? const Icon(Icons.check_circle, color: Colors.green)
                    : null,
                onTap: () {
                  ref.read(localeProvider.notifier).state = null;
                },
              ),
              ...languages.map((lang) {
                final isSelected =
                    currentLocale?.languageCode == lang.$1;
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(lang.$3),
                  trailing: isSelected
                      ? const Icon(Icons.check_circle, color: Colors.green)
                      : null,
                  onTap: () {
                    ref.read(localeProvider.notifier).state =
                        Locale(lang.$1);
                  },
                );
              }).toList(),
            ],
          ),
        ),
      ],
    );
  }
}
