import 'package:flutter/material.dart';
import 'package:mini_expense_tracker/utils/currency_input_formatter.dart';
import 'package:mini_expense_tracker/utils/util.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _currencyFieldController =
      TextEditingController();
  final TextEditingController _dateFieldController = TextEditingController();
  final TextEditingController _timeFieldController = TextEditingController();

  final SizedBox gapBetweenField = SizedBox.fromSize(
    size: const Size.fromHeight(16),
  );

  @override
  void initState() {
    super.initState();
    _currencyFieldController.text = "0.00";
    _currencyFieldController.addListener(
      /**
       * Set cursor to the end and disable selection
       */
      () {
        final String text = _currencyFieldController.text;
        _currencyFieldController.value =
            _currencyFieldController.value.copyWith(
          text: text,
          selection:
              TextSelection(baseOffset: text.length, extentOffset: text.length),
          composing: TextRange.empty,
        );
      },
    );
    _dateFieldController.text = Util.formatDate(DateTime.now());
    _timeFieldController.text = Util.formatTime(TimeOfDay.now());
  }

  void _onDateFieldTap({required BuildContext context}) {
    showDatePicker(
            context: context,
            firstDate: DateTime(2000),
            lastDate: DateTime(DateTime.now().year + 1))
        .then((selectedDate) {
      if (selectedDate == null) {
        return;
      }
      _dateFieldController.text = Util.formatDate(selectedDate);
    });
  }

  void _onTimeFieldTap({required BuildContext context}) {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.inputOnly,
    ).then((selectedTime) {
      if (selectedTime == null) {
        return;
      }
      _timeFieldController.text = Util.formatTime(selectedTime);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO (WJ): add close keyboard view auto when change focus
    return SingleChildScrollView(
      // Clamping will auto scroll to make text field visible,
      // its parent NeverScrollable will not allow the user to scroll.
      physics:
          const ClampingScrollPhysics(parent: NeverScrollableScrollPhysics()),
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 48, 8, 8),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: DropdownMenu(
                      // TODO (WJ): wrap with form validation
                      dropdownMenuEntries: ["A", "B"].map((value) {
                        return DropdownMenuEntry(value: value, label: value);
                      }).toList(),
                      hintText: "From",
                      expandedInsets: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                    ),
                  ),
                  Expanded(
                    child: DropdownMenu(
                      // TODO (WJ): wrap with form validation
                      dropdownMenuEntries: ["A", "B"].map((value) {
                        return DropdownMenuEntry(value: value, label: value);
                      }).toList(),
                      hintText: "To",
                      expandedInsets: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                    ),
                  ),
                ],
              ),
              gapBetweenField,
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              gapBetweenField,
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Notes',
                  border: OutlineInputBorder(),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                minLines: 4,
                maxLines: 4,
              ),
              gapBetweenField,
              TextFormField(
                controller: _currencyFieldController,
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  border: OutlineInputBorder(),
                ),
                textAlign: TextAlign.right,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                inputFormatters: [
                  CurrencyInputFormatter(),
                ],
                keyboardType: TextInputType.number,
              ),
              gapBetweenField,
              TextFormField(
                controller: _dateFieldController,
                decoration: const InputDecoration(
                  labelText: 'Transaction Date',
                  border: OutlineInputBorder(),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                readOnly: true,
                onTap: () => _onDateFieldTap(context: context),
              ),
              gapBetweenField,
              TextFormField(
                controller: _timeFieldController,
                decoration: const InputDecoration(
                  labelText: 'Transaction Time',
                  border: OutlineInputBorder(),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                readOnly: true,
                onTap: () => _onTimeFieldTap(context: context),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Validate will return true if the form is valid, or false if
                    // the form is invalid.
                    if (_formKey.currentState!.validate()) {
                      // Process data.
                    }
                  },
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
