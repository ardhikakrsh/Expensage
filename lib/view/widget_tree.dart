import 'package:flutter/material.dart';
import 'package:expensage/components/my_floating_button.dart';
import 'package:expensage/components/my_navbar.dart';
import 'package:expensage/models/expense.dart';
import 'package:expensage/service/database_service.dart';
import 'package:expensage/components/create_expense.dart';
import 'package:expensage/view/home_page.dart';
import 'package:expensage/view/setting_page.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  final DatabaseService db = DatabaseService.instance;
  int myIndex = 0;
  List<Expense?> expenses = [];

  @override
  void initState() {
    super.initState();
    loadExpenses();
  }

  void loadExpenses() async {
    expenses = await db.readAllExpenses();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomePage(expenses: expenses, onRefresh: loadExpenses),
      const SettingPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Expense Tracker',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () async {
              await db.clearAllExpenses().then((_) {
                setState(() {
                  loadExpenses();
                });
              });
            },
          ),
        ],
      ),
      drawer: const Drawer(),
      body: screens[myIndex],
      floatingActionButton: MyFloatingButton(
        onPressed: () => addExpense(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const MyNavbar(),
    );
  }

  void addExpense(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return CreateExpense(onExpenseAdded: loadExpenses);
      },
    );
  }
}
