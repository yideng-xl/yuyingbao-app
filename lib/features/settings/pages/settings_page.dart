import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('设置')),
      body: ListView(
        children: [
          const _SectionHeader('宝宝管理'),
          ListTile(
            leading: const Icon(Icons.child_care),
            title: const Text('宝宝管理'),
            subtitle: const Text('添加、编辑、切换宝宝'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.go('/settings/babies'),
          ),
          const Divider(),
          const _SectionHeader('数据管理'),
          ListTile(
            leading: const Icon(Icons.file_upload),
            title: const Text('导出数据'),
            subtitle: const Text('导出为 JSON 文件'),
            onTap: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('导出功能即将上线')),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.file_download),
            title: const Text('导入数据'),
            subtitle: const Text('从 JSON 文件导入'),
            onTap: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('导入功能即将上线')),
            ),
          ),
          const Divider(),
          const _SectionHeader('关于'),
          const ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('育婴宝'),
            subtitle: Text('版本 1.0.0'),
          ),
          const ListTile(
            leading: Icon(Icons.code),
            title: Text('开源地址'),
            subtitle: Text('github.com/yideng-xl/yuyingbao-app'),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Text(title, style: Theme.of(context).textTheme.labelLarge?.copyWith(
        color: Theme.of(context).colorScheme.primary,
      )),
    );
  }
}
