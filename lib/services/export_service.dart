import 'dart:convert';

class ExportService {
  static String buildExportJson({
    required List<Map<String, dynamic>> babies,
    required List<Map<String, dynamic>> records,
    required Map<String, String> settings,
  }) {
    final data = {
      'version': '1.0',
      'exportedAt': DateTime.now().toIso8601String(),
      'babies': babies,
      'records': records,
      'settings': settings,
    };
    return const JsonEncoder.withIndent('  ').convert(data);
  }

  static Map<String, dynamic>? parseImportJson(String jsonStr) {
    try {
      final data = json.decode(jsonStr) as Map<String, dynamic>;
      final version = data['version'] as String?;
      if (version != '1.0') return null;
      return data;
    } catch (_) {
      return null;
    }
  }
}
