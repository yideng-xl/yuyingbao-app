import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/database_providers.dart';
import '../../../shared/utils/uuid_utils.dart';

/// Currently selected baby ID. Null until first baby is loaded.
final selectedBabyIdProvider = StateProvider<String?>((ref) => null);

/// Stream of all babies, ordered by creation time.
final babiesProvider = StreamProvider<List<Baby>>((ref) {
  return ref.watch(babyRepositoryProvider).watchAllBabies();
});

/// The currently selected baby. Falls back to the first baby if none selected.
/// Returns null when the list is empty.
final selectedBabyProvider = Provider<Baby?>((ref) {
  final selectedId = ref.watch(selectedBabyIdProvider);
  final babiesAsync = ref.watch(babiesProvider);

  return babiesAsync.when(
    data: (babies) {
      if (babies.isEmpty) return null;
      if (selectedId == null) return babies.first;
      return babies.firstWhere(
        (b) => b.id == selectedId,
        orElse: () => babies.first,
      );
    },
    loading: () => null,
    error: (_, __) => null,
  );
});

/// Returns a function that adds a baby and auto-selects it if it's the first.
final addBabyProvider = Provider<
    Future<void> Function({
      required String name,
      required String gender,
      required DateTime birthDate,
      double? birthHeight,
      double? birthWeight,
      String? avatar,
    })>((ref) {
  return ({
    required String name,
    required String gender,
    required DateTime birthDate,
    double? birthHeight,
    double? birthWeight,
    String? avatar,
  }) async {
    final repo = ref.read(babyRepositoryProvider);
    final id = generateId();
    await repo.addBaby(
      id: id,
      name: name,
      gender: gender,
      birthDate: birthDate,
      birthHeight: birthHeight,
      birthWeight: birthWeight,
      avatar: avatar,
    );

    // Auto-select if it's the first baby (no baby currently selected)
    final currentSelected = ref.read(selectedBabyIdProvider);
    if (currentSelected == null) {
      ref.read(selectedBabyIdProvider.notifier).state = id;
    }
  };
});
