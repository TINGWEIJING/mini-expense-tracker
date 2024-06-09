import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mini_expense_tracker/utils/currency_input_formatter.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _currencyFieldController =
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
        log("controller text: $text");
        _currencyFieldController.value =
            _currencyFieldController.value.copyWith(
          text: text,
          selection:
              TextSelection(baseOffset: text.length, extentOffset: text.length),
          composing: TextRange.empty,
        );
      },
    );
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
            TextFormField(
              controller: _currencyFieldController,
              decoration: const InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(),
              ),
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
