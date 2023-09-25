import 'package:expense_tracker_app/modules/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      // color: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 16),
        child: Column(children: [
          Text(expense.title),
          const SizedBox(
            height: 4,
          ),
          Row(
            children: [
              Text('Rs. ${expense.cost.toStringAsFixed(2)}'),
              const Spacer(), // to place space between two widgets
              Row(
                children: [
                  Icon(categoryIcons[expense.category]),
                  // const SizedBox(width: 4),
                  Text(expense.fomattedDate.toString()),
                ],
              ),
            ],
          )
        ]),
      ),
    );
  }
}