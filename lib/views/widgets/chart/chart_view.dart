import 'package:expenses/models/expense_model.dart';
import 'package:expenses/views/widgets/chart/chart_view_bar.dart';
import 'package:flutter/material.dart';

class ChartView extends StatelessWidget {
  const ChartView({super.key, required this.expenses});

  final List<ExpenseModel> expenses;

  List<ExpenseBucket> get buckets {
    return [
      ExpenseBucket.fromCategory(expenses, Category.food),
      ExpenseBucket.fromCategory(expenses, Category.leisure),
      ExpenseBucket.fromCategory(expenses, Category.travel),
      ExpenseBucket.fromCategory(expenses, Category.work),
    ];
  }

  double get maxTotalExpenses {
    double maxTotalExpenses = 0;

    for (var bucket in buckets) {
      if (bucket.totalExpenses > maxTotalExpenses) {
        maxTotalExpenses = bucket.totalExpenses;
      }
    }
    return maxTotalExpenses;
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          width: double.infinity,
          height: constraints.maxHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary.withOpacity(0.3),
                Theme.of(context).colorScheme.primary.withOpacity(0.0),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    for (final ele in buckets)
                      ChartViewBar(
                        fill: ele.totalExpenses == 0
                            ? 0
                            : ele.totalExpenses / maxTotalExpenses,
                      ),
                  ],
                ),
              ),
              constraints.minHeight < 160
                  ? Container()
                  : SizedBox(height: constraints.minHeight * 0.05),
              Row(
                children: buckets
                    .map(
                      (e) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Icon(
                            categoryIcons[e.category],
                            color: isDarkMode
                                ? Theme.of(context).colorScheme.onPrimary
                                : Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withOpacity(0.75),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
