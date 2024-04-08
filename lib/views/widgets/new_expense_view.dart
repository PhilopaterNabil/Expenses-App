import 'dart:io';

import 'package:expenses/models/expense_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewExpenseView extends StatefulWidget {
  const NewExpenseView({super.key, required this.onAddExpense});

  final void Function(ExpenseModel expense) onAddExpense;

  @override
  State<NewExpenseView> createState() => _NewExpenseViewState();
}

class _NewExpenseViewState extends State<NewExpenseView> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final formatter = DateFormat.yMd();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.food;

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _amountController.dispose();
  }

  void _showDialog() {
    Platform.isIOS
        ? showCupertinoDialog(
            context: context,
            builder: (context) => CupertinoAlertDialog(
              title: const Text('Invalid Input'),
              content: const Text(
                  'Please make sure a valid title, amount, date and category was entered.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Okay'),
                ),
              ],
            ),
          )
        : showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Invalid Input'),
              content: const Text(
                  'Please make sure a valid title, amount, date and category was entered.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Okay'),
                ),
              ],
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                maxLength: 50,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _amountController,
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Amount',
                        prefixText: '\$',
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          _selectedDate == null
                              ? 'No Date Selected'
                              : formatter.format(_selectedDate!),
                        ),
                        IconButton(
                          onPressed: () async {
                            final now = DateTime.now();
                            final firstDate =
                                DateTime(now.year - 1, now.month, now.day);
                            final DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: now,
                              firstDate: firstDate,
                              lastDate: now,
                            );
                            setState(() {
                              _selectedDate = pickedDate;
                            });
                          },
                          icon: const Icon(Icons.calendar_month),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  DropdownButton(
                    value: _selectedCategory,
                    items: Category.values
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e.name.toUpperCase()),
                            ))
                        .toList(),
                    onChanged: (newCat) {
                      if (newCat == null) return;
                      setState(
                        () {
                          _selectedCategory = newCat;
                        },
                      );
                    },
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final enteredTitle = _titleController.text;
                      final enteredAmount =
                          double.tryParse(_amountController.text);
                      final bool amountIsInvalid =
                          enteredAmount == null || enteredAmount <= 0;

                      if (enteredTitle.trim().isEmpty ||
                          amountIsInvalid ||
                          _selectedDate == null) {
                        _showDialog();
                      } else {
                        final newExpense = ExpenseModel(
                          title: enteredTitle,
                          amount: enteredAmount,
                          date: _selectedDate!,
                          category: _selectedCategory,
                        );
                        widget.onAddExpense(newExpense);
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Save Expense'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
