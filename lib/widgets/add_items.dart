import 'package:expense_tracker_app/models/expense.dart';
import 'package:flutter/material.dart';
// import 'package:expense_tracker_app/widgets/expense_app.dart';

class AddItems extends StatefulWidget {
  const AddItems({required this.onAddExpense, super.key});

  final void Function(Expense expense) onAddExpense;

  @override
  State<AddItems> createState() {
    return _AddItemsState();
  }
}

// ............................
class _AddItemsState extends State<AddItems> {
  final _textController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  // One way to storing text:
  // var _enteredText = '';

  // void _savebutton(String inputValue) {
  //   _enteredText = inputValue;
  // }
  DateTime? _selectedDate;

  void _datePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final lastDate = now;

    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: lastDate);
    // after await

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  Category _selectedCategory = Category.food;

  void _onSaveButton() {
    final ammountEntered = double.tryParse(_amountController
        .text); // trypass(hello) => null and if trypass(1.12)=> 1.12

    if (_textController.text.trim().isEmpty ||
        _selectedDate == null ||
        ammountEntered == null ||
        ammountEntered <= 0) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text(
              'You have to enter valid text, valid amount,and valid date'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Okay')),
          ],
        ),
      );
      return;
    }

    widget.onAddExpense(Expense(
        cost: ammountEntered,
        dateTime: _selectedDate!,
        title: _textController.text.toString(),
        category: _selectedCategory));

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 50, 16, 10),
      child: Column(
        children: [
          TextField(
            controller: _textController,
            // onChanged: _savebutton,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      prefixText: 'Rs. ', label: Text('Amount')),
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(_selectedDate == null
                      ? 'No Date Selected'
                      : dateFormatter.format(_selectedDate!)),
                  IconButton(
                      onPressed: _datePicker,
                      icon: const Icon(Icons.date_range)),
                ],
              )),
            ],
          ),
          // buttons row
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              DropdownButton(
                  value: _selectedCategory,
                  items: Category.values
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(category.name.toUpperCase()),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) return;

                    setState(() {
                      _selectedCategory = value;
                    });
                  }),
              const Spacer(),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')), // cancel button
              ElevatedButton(
                  onPressed: () {
                    _onSaveButton();
                    print('hello');
                  },
                  child: const Text('Save Expense')),
            ],
          ),
        ],
      ),
    );
  }
}
