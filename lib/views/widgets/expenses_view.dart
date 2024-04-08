import 'package:expenses/models/expense_model.dart';
import 'package:expenses/views/widgets/chart/chart_view.dart';
import 'package:expenses/views/widgets/expanses_list/expanses_view_list.dart';
import 'package:expenses/views/widgets/new_expense_view.dart';
import 'package:flutter/material.dart';

class ExpansesView extends StatefulWidget {
  const ExpansesView({super.key});

  @override
  State<ExpansesView> createState() => _ExpansesViewState();
}

class _ExpansesViewState extends State<ExpansesView> {
  final List<ExpenseModel> _registeredExpenses = [
    ExpenseModel(
      title: 'Flutter Coures',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    ExpenseModel(
      title: 'Cinema',
      amount: 9.71,
      date: DateTime.now(),
      category: Category.leisure,
    ),
    ExpenseModel(
      title: 'Breakfast',
      amount: 31.3,
      date: DateTime.now(),
      category: Category.food,
    ),
  ];

  void _addExpense(ExpenseModel expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(ExpenseModel expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    Widget mainContent = const Center(
      child: Text(
        'No expenses found. Start adding some!',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        onRemoveExpense: _removeExpense,
        expenses: _registeredExpenses,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter ExpenseTracker'),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                useSafeArea: true,
                isScrollControlled: true,
                context: context,
                builder: (context) => NewExpenseView(onAddExpense: _addExpense),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
        centerTitle: true,
      ),
      body: Center(
        child: width < 600
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: ChartView(expenses: _registeredExpenses)),
                  Expanded(
                    child: mainContent,
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: ChartView(expenses: _registeredExpenses)),
                  Expanded(
                    child: mainContent,
                  ),
                ],
              ),
      ),
    );
  }
}
