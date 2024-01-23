import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ecoviary/data/models/coops_model.dart';
import 'package:ecoviary/data/providers/form_providers.dart';
import 'package:ecoviary/ui/components/forms/add_button.dart';
import 'package:ecoviary/ui/components/forms/days_dropdown.dart';
import 'package:ecoviary/utils/utils.dart';

class CoopForm extends ConsumerStatefulWidget {
  final Coops? coop;

  const CoopForm({
    super.key,
    this.coop,
  });

  @override
  ConsumerState<CoopForm> createState() => _CoopFormState();
}

class _CoopFormState extends ConsumerState<CoopForm> {
  Coops? _coop;
  late GlobalKey<FormState> _formKey;

  DaysEnum _daysEnum = DaysEnum.days;

  void _handleDaysEnum(DaysEnum? value) {
    if (value == null) return;
    var ageController = ref.read(coopFormProvider).ageController;
    setState(() {
      ageController.text =
          chickenAgeToDays(int.parse(ageController.text), _daysEnum, value)
              .toString();
      _daysEnum = value;
    });
  }

  void _handleAddRemove(TextEditingController controller, bool isAdd) {
    if (controller.text.isEmpty) controller.text = '0';

    int value = int.parse(controller.text);

    if (value == 0 && !isAdd) return;

    setState(() {
      if (isAdd) {
        controller.text = (value + 1).toString();
      } else {
        controller.text = (value - 1).toString();
      }
    });
  }

  void _setDefaultValue() {
    ref.read(coopFormProvider).ageController.text = '0';
    ref.read(coopFormProvider).henController.text = '0';
    ref.read(coopFormProvider).roosterController.text = '0';
    ref.read(coopFormProvider).totalController.text = '0';
  }

  void _fillFields() {
    if (_coop == null) return;

    ref.read(coopFormProvider).ageController.text = _coop!.age.toString();
    ref.read(coopFormProvider).henController.text = _coop!.totalHen.toString();
    ref.read(coopFormProvider).roosterController.text =
        _coop!.totalRooster.toString();
    ref.read(coopFormProvider).totalController.text =
        _coop!.totalChicken.toString();
  }

  @override
  void initState() {
    super.initState();

    _formKey = ref.read(coopFormProvider).formKey;

    var henController = ref.read(coopFormProvider).henController;
    var roosterController = ref.read(coopFormProvider).roosterController;
    var totalController = ref.read(coopFormProvider).totalController;

    henController.addListener(() {
      totalController.text =
          (int.parse(henController.text) + int.parse(roosterController.text))
              .toString();
    });
    roosterController.addListener(() {
      totalController.text =
          (int.parse(henController.text) + int.parse(roosterController.text))
              .toString();
    });

    _coop = widget.coop ?? ref.read(coopFormProvider).coop;
    _fillFields();

    if (_coop == null) {
      _setDefaultValue();
    }
  }

  @override
  Widget build(BuildContext context) {
    var ageController = ref.read(coopFormProvider).ageController;
    var henController = ref.read(coopFormProvider).henController;
    var roosterController = ref.read(coopFormProvider).roosterController;
    var totalController = ref.read(coopFormProvider).totalController;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Pendataan',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Form(
            key: _formKey,
            child: Wrap(
              runSpacing: 8,
              children: [
                const Text(
                  'Umur',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 9,
                      child: TextFormField(
                        controller: ageController,
                        validator: emptyValidator,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^[1-9][0-9]*')),
                        ],
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      flex: 3,
                      child: DaysDropdown(
                        value: _daysEnum,
                        onChange: _handleDaysEnum,
                      ),
                    )
                  ],
                ),
                const Text(
                  'Data Betina',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 9,
                      child: TextFormField(
                        controller: henController,
                        validator: emptyValidator,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^[0-9][0-9]*')),
                        ],
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 3,
                      child: Row(
                        children: [
                          AddButton(
                            onPressed: () =>
                                _handleAddRemove(henController, false),
                            icon: const Icon(Icons.remove),
                          ),
                          const SizedBox(width: 8),
                          AddButton(
                            onPressed: () =>
                                _handleAddRemove(henController, true),
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const Text(
                  'Data Jantan',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Flexible(
                      flex: 9,
                      child: TextFormField(
                        controller: roosterController,
                        validator: emptyValidator,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^[1-9][0-9]*')),
                        ],
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      flex: 3,
                      child: Row(
                        children: [
                          AddButton(
                            onPressed: () =>
                                _handleAddRemove(roosterController, false),
                            icon: const Icon(Icons.remove),
                          ),
                          const SizedBox(width: 8),
                          AddButton(
                            onPressed: () =>
                                _handleAddRemove(roosterController, true),
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Flexible(
                flex: 8,
                child: Row(children: [
                  Text('Jumlah Data Terhitung'),
                ]),
              ),
              Flexible(
                flex: 4,
                child: TextFormField(
                  controller: totalController,
                  readOnly: true,
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => {},
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.surfaceTint,
                ),
                child: const Text('Lihat data sebelumnya'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
