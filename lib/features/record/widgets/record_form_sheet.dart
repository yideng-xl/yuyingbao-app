import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../core/constants/enums.dart';
import '../providers/record_providers.dart';

class RecordFormSheet extends HookConsumerWidget {
  const RecordFormSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedType = useState(RecordType.breastfeeding);
    final selectedTime = useState(DateTime.now());
    final isSaving = useState(false);

    // Breastfeeding
    final bfSide = useState(BreastfeedingSide.left);
    final durationController = useTextEditingController();

    // Bottle / formula / water
    final amountController = useTextEditingController();

    // Solid
    final solidType = useState(SolidType.riceCereal);
    final solidIngredientsController = useTextEditingController();

    // Diaper
    final diaperTexture = useState(DiaperTexture.normal);
    final diaperColor = useState(DiaperColor.yellow);
    final hasUrine = useState(false);

    // Growth
    final heightController = useTextEditingController();
    final weightController = useTextEditingController();

    // Nutrition
    final nutritionController = useTextEditingController();

    // Note
    final noteController = useTextEditingController();

    Future<void> pickTime() async {
      final tod = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedTime.value),
      );
      if (tod != null) {
        final now = selectedTime.value;
        selectedTime.value = DateTime(
          now.year,
          now.month,
          now.day,
          tod.hour,
          tod.minute,
        );
      }
    }

    Future<void> save() async {
      isSaving.value = true;
      try {
        final addRecord = ref.read(addRecordProvider);
        await addRecord(
          type: selectedType.value.name,
          happenedAt: selectedTime.value,
          durationMin: selectedType.value == RecordType.breastfeeding &&
                  durationController.text.isNotEmpty
              ? int.tryParse(durationController.text)
              : null,
          amountMl: (selectedType.value == RecordType.bottle ||
                      selectedType.value == RecordType.formula ||
                      selectedType.value == RecordType.water) &&
                  amountController.text.isNotEmpty
              ? double.tryParse(amountController.text)
              : null,
          breastfeedingSide: selectedType.value == RecordType.breastfeeding
              ? bfSide.value.name
              : null,
          solidType: selectedType.value == RecordType.solid
              ? solidType.value.name
              : null,
          solidIngredients: selectedType.value == RecordType.solid &&
                  solidIngredientsController.text.isNotEmpty
              ? solidIngredientsController.text
              : null,
          diaperTexture: selectedType.value == RecordType.diaper
              ? diaperTexture.value.name
              : null,
          diaperColor: selectedType.value == RecordType.diaper
              ? diaperColor.value.name
              : null,
          hasUrine:
              selectedType.value == RecordType.diaper ? hasUrine.value : null,
          heightCm: selectedType.value == RecordType.growth &&
                  heightController.text.isNotEmpty
              ? double.tryParse(heightController.text)
              : null,
          weightKg: selectedType.value == RecordType.growth &&
                  weightController.text.isNotEmpty
              ? double.tryParse(weightController.text)
              : null,
          nutritionTypes: selectedType.value == RecordType.nutrition &&
                  nutritionController.text.isNotEmpty
              ? nutritionController.text
              : null,
          note: noteController.text.isNotEmpty ? noteController.text : null,
        );
        if (context.mounted) Navigator.of(context).pop();
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('保存失败: $e')),
          );
        }
      } finally {
        isSaving.value = false;
      }
    }

    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Handle
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.outlineVariant,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                child: Row(
                  children: [
                    Text(
                      '添加记录',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              // Scrollable form
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(20),
                  children: [
                    // Record type chips
                    Text(
                      '记录类型',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: RecordType.values.map((type) {
                        return ChoiceChip(
                          label: Text(type.label),
                          selected: selectedType.value == type,
                          onSelected: (selected) {
                            if (selected) selectedType.value = type;
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),

                    // Time picker
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.access_time),
                      title: const Text('时间'),
                      trailing: Text(
                        TimeOfDay.fromDateTime(selectedTime.value)
                            .format(context),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      onTap: pickTime,
                    ),
                    const Divider(),
                    const SizedBox(height: 12),

                    // Dynamic fields
                    _buildTypeFields(
                      context: context,
                      type: selectedType.value,
                      bfSide: bfSide,
                      durationController: durationController,
                      amountController: amountController,
                      solidType: solidType,
                      solidIngredientsController: solidIngredientsController,
                      diaperTexture: diaperTexture,
                      diaperColor: diaperColor,
                      hasUrine: hasUrine,
                      heightController: heightController,
                      weightController: weightController,
                      nutritionController: nutritionController,
                    ),

                    const SizedBox(height: 12),

                    // Note field
                    TextField(
                      controller: noteController,
                      decoration: const InputDecoration(
                        labelText: '备注（可选）',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.notes),
                      ),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 24),

                    // Save button
                    FilledButton(
                      onPressed: isSaving.value ? null : save,
                      child: isSaving.value
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('保存'),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTypeFields({
    required BuildContext context,
    required RecordType type,
    required ValueNotifier<BreastfeedingSide> bfSide,
    required TextEditingController durationController,
    required TextEditingController amountController,
    required ValueNotifier<SolidType> solidType,
    required TextEditingController solidIngredientsController,
    required ValueNotifier<DiaperTexture> diaperTexture,
    required ValueNotifier<DiaperColor> diaperColor,
    required ValueNotifier<bool> hasUrine,
    required TextEditingController heightController,
    required TextEditingController weightController,
    required TextEditingController nutritionController,
  }) {
    switch (type) {
      case RecordType.breastfeeding:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('喂奶侧', style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: BreastfeedingSide.values.map((side) {
                return ChoiceChip(
                  label: Text(side.label),
                  selected: bfSide.value == side,
                  onSelected: (selected) {
                    if (selected) bfSide.value = side;
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: durationController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: '时长（分钟）',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.timer_outlined),
              ),
            ),
            const SizedBox(height: 12),
          ],
        );

      case RecordType.bottle:
      case RecordType.formula:
      case RecordType.water:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: amountController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: '量（ml）',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.local_drink_outlined),
              ),
            ),
            const SizedBox(height: 12),
          ],
        );

      case RecordType.solid:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('辅食类型', style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: SolidType.values.map((st) {
                return ChoiceChip(
                  label: Text(st.label),
                  selected: solidType.value == st,
                  onSelected: (selected) {
                    if (selected) solidType.value = st;
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: solidIngredientsController,
              decoration: const InputDecoration(
                labelText: '食材（可选）',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.list_alt_outlined),
              ),
            ),
            const SizedBox(height: 12),
          ],
        );

      case RecordType.diaper:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('质地', style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: DiaperTexture.values.map((tex) {
                return ChoiceChip(
                  label: Text(tex.label),
                  selected: diaperTexture.value == tex,
                  onSelected: (selected) {
                    if (selected) diaperTexture.value = tex;
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            Text('颜色', style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: DiaperColor.values.map((col) {
                return ChoiceChip(
                  label: Text(col.label),
                  selected: diaperColor.value == col,
                  onSelected: (selected) {
                    if (selected) diaperColor.value = col;
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 12),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('有尿'),
              value: hasUrine.value,
              onChanged: (v) => hasUrine.value = v,
            ),
            const SizedBox(height: 12),
          ],
        );

      case RecordType.growth:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: heightController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: '身高（cm）',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.height),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: weightController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: '体重（kg）',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.monitor_weight_outlined),
              ),
            ),
            const SizedBox(height: 12),
          ],
        );

      case RecordType.nutrition:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nutritionController,
              decoration: const InputDecoration(
                labelText: '营养品类型',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.medication_outlined),
                hintText: '例：维生素D、DHA',
              ),
            ),
            const SizedBox(height: 12),
          ],
        );
    }
  }
}
