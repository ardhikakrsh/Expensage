import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_sqflite/main.dart';
import 'package:flutter_sqflite/models/expense.dart';
import 'package:flutter_sqflite/service/database_service.dart';

class MyCard extends StatefulWidget {
  final Expense expense;
  final VoidCallback onDelete;
  final VoidCallback onUpdate;

  const MyCard({
    super.key,
    required this.expense,
    required this.onDelete,
    required this.onUpdate,
  });

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  final DatabaseService db = DatabaseService.instance;
  Category selectedCategory = Category.food;
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: const Color.fromARGB(255, 117, 213, 183),
      elevation: 10,
      child: Slidable(
        key: Key(widget.expense.id.toString()),
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            //edit
            SlidableAction(
              onPressed: (context) {
                edit();
              },
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
            ),
            //delete
            SlidableAction(
              onPressed: (context) {
                widget.onDelete();
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: ListTile(
          title: Text(
            widget.expense.title,
            style: const TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            '${widget.expense.category}',
            style: const TextStyle(
              fontSize: 14,
              color: Color.fromARGB(255, 81, 81, 81),
            ),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                formatter.format(widget.expense.date),
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              const SizedBox(height: 5),
              Text(
                widget.expense.formattedAmount,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 255, 17, 0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void edit() {
    final titleController = TextEditingController(text: widget.expense.title);
    final amountController = TextEditingController(
      text: widget.expense.amount.toString(),
    );
    selectedDate = widget.expense.date;
    selectedCategory = widget.expense.category;
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            final dateController = TextEditingController(
              text: formatter.format(selectedDate!),
            );
            return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Edit Expense',
                    style: TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 20),
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
                  TextField(
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Amount',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          readOnly: true,
                          controller: dateController,
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
                              onPressed: () async {
                                final newDate = await showDatePicker(
                                  context: context,
                                  initialDate: selectedDate,
                                  firstDate: DateTime(2020),
                                  lastDate: DateTime.now(),
                                );
                                if (newDate != null) {
                                  setModalState(() {
                                    selectedDate = newDate;
                                    dateController.text =
                                        formatter.format(newDate);
                                  });
                                }
                                setState(() {});
                              },
                              icon: const Icon(Icons.calendar_month),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
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
                          dropdownColor: kDarkColorScheme.surface,
                          isExpanded: true,
                          value: selectedCategory,
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
                            setState(() {
                              selectedCategory = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
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
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                          onPressed: () async {
                            if (titleController.text.isEmpty ||
                                amountController.text.isEmpty ||
                                selectedDate == null) {
                              return;
                            } else {
                              final updated = widget.expense.copyWith(
                                id: widget.expense.id,
                                title: titleController.text,
                                amount: double.parse(amountController.text),
                                date: selectedDate!,
                                category: selectedCategory,
                              );
                              await DatabaseService.instance
                                  .updateExpense(updated);
                              widget.onUpdate();
                              Navigator.pop(context);
                            }
                          },
                          child: const Text(
                            'Update',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
