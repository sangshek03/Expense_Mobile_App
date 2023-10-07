import 'package:expense_tracker_app/widgets/chart/chart.dart';
// import 'package:expense_tracker_app/widgets/chart/chart_bar.dart';
import 'package:expense_tracker_app/widgets/expenses_list/expense_list.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker_app/models/expense.dart';
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
    Expense(
        title: 'Buger Party',
        cost: 3420,
        dateTime: DateTime.now(),
        category: Category.food),
    Expense(
        title: 'House Rent',
        cost: 7000,
        dateTime: DateTime.now(),
        category: Category.rent),
    Expense(
        title: 'Given Friend',
        cost: 5030,
        dateTime: DateTime.now(),
        category: Category.miscellaneous),
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
    final width = MediaQuery.of(context).size.width;
    // print('width + $width');

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
        body: width < 500
            ? Column(children: [
                const SizedBox(
                  height: 10,
                ),
                Chart(expenses: list),
                Expanded(child: mainList),
              ])
            : Row(children: [
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Chart(expenses: list),
                ),
                Expanded(child: mainList),
              ]));
  }
}
