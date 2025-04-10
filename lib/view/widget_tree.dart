import 'package:flutter/material.dart';
import 'package:flutter_sqflite/models/expense.dart';
import 'package:flutter_sqflite/service/database_service.dart';
import 'package:flutter_sqflite/components/create_expense.dart';
import 'package:flutter_sqflite/view/home_page.dart';
import 'package:flutter_sqflite/view/setting_page.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

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
        backgroundColor: Colors.grey[800],
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
      floatingActionButton: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.deepPurpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
        ),
        child: FloatingActionButton(
          shape: const CircleBorder(),
          onPressed: () => addExpense(context),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: const Icon(
            Icons.add_rounded,
            color: Colors.white,
            size: 32,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: GNav(
            backgroundColor: Colors.black,
            tabMargin: const EdgeInsets.symmetric(horizontal: 8),
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            tabShadow: [
              BoxShadow(
                color: myIndex == 0
                    ? Colors.orange.shade100
                    : Colors.blue.shade100,
                blurRadius: 2,
              ),
            ],
            curve: Curves.easeIn, // tab animation curves
            gap: 8,
            textStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color:
                  myIndex == 0 ? Colors.blue.shade600 : Colors.orange.shade600,
            ),

            tabs: [
              GButton(
                icon: Icons.home,
                text: 'Home',
                iconColor: Colors.blue.shade600,
                iconActiveColor: Colors.blue.shade600,
                backgroundColor: Colors.blue.shade100,
              ),
              GButton(
                icon: Icons.settings,
                text: 'Settings',
                iconColor: Colors.orange.shade600,
                iconActiveColor: Colors.orange.shade600,
                backgroundColor: Colors.orange.shade100,
              ),
            ],
            onTabChange: (index) {
              setState(() {
                myIndex = index;
              });
            },
          ),
        ),
      ),
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
