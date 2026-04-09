import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:yuyingbao/l10n/generated/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../core/constants/enums.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/database_providers.dart';
import '../../../shared/utils/date_utils.dart';
import '../../../shared/utils/uuid_utils.dart';

class BabyFormPage extends HookConsumerWidget {
  final Baby? baby;

  const BabyFormPage({super.key, this.baby});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEdit = baby != null;

    final nameController = useTextEditingController(text: baby?.name ?? '');
    final heightController = useTextEditingController(
      text: baby?.birthHeight?.toString() ?? '',
    );
    final weightController = useTextEditingController(
      text: baby?.birthWeight?.toString() ?? '',
    );

    final genderState = useState<Gender>(
      baby?.gender == 'female' ? Gender.female : Gender.male,
    );
    final birthDateState = useState<DateTime>(
      baby?.birthDate ?? DateTime.now(),
    );

    final formKey = useMemoized(() => GlobalKey<FormState>());
    final isSaving = useState(false);

    Future<void> pickDate() async {
      final picked = await showDatePicker(
        context: context,
        initialDate: birthDateState.value,
        firstDate: DateTime(2000),
        lastDate: DateTime.now(),
      );
      if (picked != null) {
        birthDateState.value = picked;
      }
    }

    Future<void> save() async {
      if (!formKey.currentState!.validate()) return;
      isSaving.value = true;

      try {
        final repo = ref.read(babyRepositoryProvider);
        final name = nameController.text.trim();
        final gender = genderState.value.name; // 'male' or 'female'
        final birthDate = birthDateState.value;
        final heightText = heightController.text.trim();
        final weightText = weightController.text.trim();
        final birthHeight =
            heightText.isNotEmpty ? double.tryParse(heightText) : null;
        final birthWeight =
            weightText.isNotEmpty ? double.tryParse(weightText) : null;

        if (isEdit) {
          await repo.updateBaby(
            id: baby!.id,
            name: name,
            gender: gender,
            birthDate: birthDate,
            birthHeight: birthHeight,
            birthWeight: birthWeight,
          );
        } else {
          await repo.addBaby(
            id: generateId(),
            name: name,
            gender: gender,
            birthDate: birthDate,
            birthHeight: birthHeight,
            birthWeight: birthWeight,
          );
        }

        if (context.mounted) {
          Navigator.of(context).pop();
        }
      } finally {
        isSaving.value = false;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? S.of(context).editBaby : S.of(context).addBaby),
        actions: [
          TextButton(
            onPressed: isSaving.value ? null : save,
            child: isSaving.value
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(S.of(context).save),
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Name field
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: S.of(context).babyName,
                hintText: S.of(context).babyNameHint,
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.person_outline),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return S.of(context).babyNameRequired;
                }
                return null;
              },
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),

            // Gender
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).gender,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const SizedBox(height: 8),
                SegmentedButton<Gender>(
                  segments: [
                    ButtonSegment(
                      value: Gender.male,
                      label: Text(S.of(context).genderBoy),
                      icon: const Icon(Icons.male),
                    ),
                    ButtonSegment(
                      value: Gender.female,
                      label: Text(S.of(context).genderGirl),
                      icon: const Icon(Icons.female),
                    ),
                  ],
                  selected: {genderState.value},
                  onSelectionChanged: (selection) {
                    if (selection.isNotEmpty) {
                      genderState.value = selection.first;
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Birth date
            InkWell(
              onTap: pickDate,
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: S.of(context).birthDate,
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.calendar_today_outlined),
                  suffixIcon: const Icon(Icons.chevron_right),
                ),
                child: Text(formatDate(birthDateState.value)),
              ),
            ),
            const SizedBox(height: 16),

            // Birth height
            TextFormField(
              controller: heightController,
              decoration: InputDecoration(
                labelText: S.of(context).birthHeightLabel,
                hintText: S.of(context).optional,
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.straighten_outlined),
                suffixText: 'cm',
              ),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  if (double.tryParse(value) == null) return S.of(context).invalidNumber;
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Birth weight
            TextFormField(
              controller: weightController,
              decoration: InputDecoration(
                labelText: S.of(context).birthWeightLabel,
                hintText: S.of(context).optional,
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.monitor_weight_outlined),
                suffixText: 'kg',
              ),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  if (double.tryParse(value) == null) return S.of(context).invalidNumber;
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
