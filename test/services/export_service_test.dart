import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:yuyingbao/services/export_service.dart';

void main() {
  group('ExportService', () {
    test('buildExportJson creates valid structure', () {
      final result = ExportService.buildExportJson(
        babies: [{'id': 'b1', 'name': '小明'}],
        records: [{'id': 'r1', 'babyId': 'b1', 'type': 'bottle'}],
        settings: {'feedingInterval': '180'},
      );
      final parsed = json.decode(result);
      expect(parsed['version'], '1.0');
      expect(parsed['exportedAt'], isNotNull);
      expect(parsed['babies'], hasLength(1));
      expect(parsed['records'], hasLength(1));
      expect(parsed['settings']['feedingInterval'], '180');
    });

    test('parseImportJson validates version', () {
      final data = json.encode({
        'version': '1.0',
        'exportedAt': '2026-04-08T12:00:00+08:00',
        'babies': [], 'records': [], 'settings': {},
      });
      final result = ExportService.parseImportJson(data);
      expect(result, isNotNull);
      expect(result!['version'], '1.0');
    });

    test('parseImportJson returns null for invalid version', () {
      final data = json.encode({'version': '99.0'});
      expect(ExportService.parseImportJson(data), isNull);
    });

    test('parseImportJson returns null for invalid JSON', () {
      expect(ExportService.parseImportJson('not json'), isNull);
    });
  });
}
