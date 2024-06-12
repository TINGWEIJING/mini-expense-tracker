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
  final TextEditingController _dateTimeFieldController =
      TextEditingController();

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
    _dateTimeFieldController.text = Util.formatDateTime(DateTime.now());
  }

  void _onTap({required BuildContext context}) {
    showDatePicker(
            context: context,
            firstDate: DateTime(2000),
            lastDate: DateTime(DateTime.now().year + 1))
        .then((selectedDate) {
      if (selectedDate == null) {
        return;
      }
      _dateTimeFieldController.text = Util.formatDateTime(selectedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 48, 8, 8),
        child: Column(
          children: [
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
            SizedBox.fromSize(
              size: const Size.fromHeight(16),
            ),
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
            SizedBox.fromSize(
              size: const Size.fromHeight(16),
            ),
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
            SizedBox.fromSize(
              size: const Size.fromHeight(16),
            ),
            TextFormField(
              controller: _dateTimeFieldController,
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
              onTap: () => _onTap(context: context),
            ), // TODO: add transaction time
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
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
    );
  }
}
