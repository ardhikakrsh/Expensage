import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_sqflite/models/expense.dart';

class MyCard extends StatefulWidget {
  final Expense expense;
  final VoidCallback onDelete;

  const MyCard({
    super.key,
    required this.expense,
    required this.onDelete,
  });

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: const Color.fromARGB(255, 150, 217, 6),
      elevation: 10,
      child: Slidable(
        key: Key(widget.expense.id.toString()),
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            //edit
            SlidableAction(
              onPressed: (context) {},
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
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
