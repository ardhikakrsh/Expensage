import 'package:flutter/material.dart';
import 'package:expensage/components/my_card.dart';
import 'package:expensage/models/expense.dart';
import 'package:expensage/service/database_service.dart';

class HomePage extends StatefulWidget {
  final List<Expense?> expenses;
  final VoidCallback onRefresh;

  const HomePage({
    super.key,
    required this.expenses,
    required this.onRefresh,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseService db = DatabaseService.instance;

  Future<void> deleteById(int id) async {
    await db.deleteExpense(id).then((_) {
      setState(() {
        widget.onRefresh();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.expenses.isEmpty
          ? const Center(
              child: Text(
                'No expenses found',
                style: TextStyle(color: Colors.white),
              ),
            )
          : ListView.builder(
              itemCount: widget.expenses.length,
              itemBuilder: (context, index) {
                final expense = widget.expenses[index]!;
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4.0,
                    horizontal: 14.0,
                  ),
                  child: MyCard(
                    expense: expense,
                    onDelete: () {
                      deleteById(expense.id!);
                    },
                    onUpdate: widget.onRefresh,
                  ),
                );
              },
            ),
    );
  }
}
