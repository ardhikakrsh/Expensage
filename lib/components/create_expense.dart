import 'package:expensage/main.dart';
import 'package:flutter/material.dart';
import 'package:expensage/models/expense.dart';
import 'package:expensage/service/database_service.dart';

class CreateExpense extends StatefulWidget {
  final VoidCallback onExpenseAdded;

  const CreateExpense({
    super.key,
    required this.onExpenseAdded,
  });

  @override
  State<CreateExpense> createState() => _CreateExpenseState();
}

class _CreateExpenseState extends State<CreateExpense> {
  final DatabaseService db = DatabaseService.instance;
  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  Category selectedCategory = Category.food;
  DateTime? selectedDate;

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    selectedDate = null;
    selectedCategory = Category.food;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Add Expense',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            // Title TextField
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Amount TextField
            TextField(
              controller: amountController,
              decoration: InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                // Date Picker wrapped with InputDecoration
                Expanded(
                  child: TextFormField(
                    readOnly: true,
                    controller: TextEditingController(
                      text: selectedDate == null
                          ? 'No date chosen'
                          : formatter.format(selectedDate!),
                    ),
                    decoration: InputDecoration(
                      labelText: 'Select Date',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      suffixIcon: IconButton(
                        onPressed: datePicker,
                        icon: const Icon(Icons.calendar_month),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Category Dropdown
                Expanded(
                  child: DropdownButtonFormField<Category>(
                    decoration: InputDecoration(
                      labelText: 'Category',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                    ),
                    isExpanded: true,
                    value: selectedCategory,
                    dropdownColor: kDarkColorScheme.surface,
                    icon: const Icon(Icons.arrow_drop_down),
                    items: Category.values.map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(
                          category.name.toUpperCase(),
                          style: const TextStyle(fontSize: 16),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() {
                        selectedCategory = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                // Cancel Button
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // Add Button
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      if (titleController.text.isEmpty ||
                          amountController.text.isEmpty ||
                          selectedDate == null) {
                        Navigator.pop(context);
                      } else {
                        final newExpense = Expense(
                          title: titleController.text,
                          amount: double.parse(amountController.text),
                          date: selectedDate!,
                          category: selectedCategory,
                        );

                        await db.createExpense(newExpense);
                        widget.onExpenseAdded();

                        titleController.clear();
                        amountController.clear();
                        selectedDate = null;
                        selectedCategory = Category.food;
                        Navigator.pop(context);
                      }
                    },
                    child: const Text(
                      'Add',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void datePicker() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    setState(() {
      selectedDate = pickedDate;
    });
  }
}
