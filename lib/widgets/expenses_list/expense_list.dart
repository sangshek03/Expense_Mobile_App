import 'package:expense_tracker_app/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker_app/modules/expense.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList(
      {super.key,
      required this.expensesList,
      required this.onDismissedExpense});

  final List<Expense> expensesList;
  final void Function(Expense expense) onDismissedExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expensesList.length,
      itemBuilder: (ctx, idx) => Dismissible(
          key: ValueKey(expensesList[idx]),
          onDismissed: (direction) {
            onDismissedExpense(expensesList[idx]);
          },
          child: ExpenseItem(expensesList[idx]),),
    );
  }
}
