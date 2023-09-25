import 'package:expense_tracker_app/widgets/expenses_list/expense_list.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker_app/modules/expense.dart';
import 'package:expense_tracker_app/widgets/add_items.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpenseState();
  }
}

//..............State..Class........................
class _ExpenseState extends State<Expenses> {
  final List<Expense> list = [
    Expense(
        title: 'Drawing Board',
        cost: 1000,
        dateTime: DateTime.now(),
        category: Category.goods),
    Expense(
        title: 'Hyderabad',
        cost: 6700,
        dateTime: DateTime.now(),
        category: Category.travel),
  ];

  void onAdditem() {
    showModalBottomSheet(
        isScrollControlled: true,
        // shape: const StadiumBorder(side: BorderSide.none),
        // backgroundColor: Color.fromARGB(233, 24, 66, 131),
        context: context,
        builder: (ctx) => AddItems(onAddExpense: upDateList));
  }

  void upDateList(newExpense) {
    setState(() {
      list.add(newExpense);
    });
  }

  void onRemoveExpense(Expense expense) {
    final indexOfExpense = list.indexOf(expense);
    setState(() {
      list.remove(expense);

      ScaffoldMessenger.of(context)
          .clearSnackBars(); // for clearing all snackbars
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(seconds: 3),
          content: const Text('Deleted Expense'),
          action: SnackBarAction(
            label: 'UNDO',
            onPressed: () => setState(() {
              list.insert(indexOfExpense, expense);
            }),
          )));
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget mainList = const Center(
      child: Text('No Expense are here, Add your expenses.'),
    );

    if (list.isNotEmpty) {
      mainList = ExpenseList(
        expensesList: list,
        onDismissedExpense: onRemoveExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker App'),
        actions: [
          IconButton(onPressed: onAdditem, icon: const Icon(Icons.add)),
        ],
      ),
      body: Column(children: [
        Expanded(child: mainList),
      ]),
    );
  }
}