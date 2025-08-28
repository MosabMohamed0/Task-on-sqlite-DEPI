import 'package:depi/sessions_tasks/expence_tracker/add_edit_screen.dart';
import 'package:depi/sessions_tasks/expence_tracker/expense_model.dart';
import 'package:depi/sessions_tasks/expence_tracker/sqlflite.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ExpenseModel> expenses = [];
  void initState() {
    super.initState();
    _loadExpenses();
  }

  Future<void> _loadExpenses() async {
    final data = await SqliteDatabase.getAllExpense();
    setState(() {
      expenses = data;
    });
  }

  void _addOrEditExpense({ExpenseModel? expense, int? index}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AddEditScreen(expense: expense)),
    );

    if (result != null) {
      setState(() {
        if (index == null) {
          SqliteDatabase.insertNewExpense(result);
        } else {
          SqliteDatabase.updateExpense(result);
        }
        _loadExpenses();
      });
    }
  }

  void _deleteExpense(int id) {
    setState(() {
      SqliteDatabase.deleteExpense(id);
      _loadExpenses();
    });
  }

  void _clearAll() {
    setState(() {
      SqliteDatabase.clear();
      _loadExpenses();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense Tracker"),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: _clearAll,
            tooltip: "Clear All",
          ),
        ],
      ),
      body: expenses.isEmpty
          ? Center(child: Text("No expenses yet."))
          : ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                final expense = expenses[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Text("\$${expense.amount.toStringAsFixed(1)}"),
                    ),
                    title: Text(expense.category),
                    subtitle: Text(
                      "${expense.note} - ${expense.date.toString().split(' ')[0]}",
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () =>
                              _addOrEditExpense(expense: expense, index: index),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteExpense(expense.id!),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _addOrEditExpense(),
      ),
    );
  }
}
