import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

// buat nama tabel
const String tableName = 'expenses';

const String idField = 'id';
const String titleField = 'title';
const String amountField = 'amount';
const String dateField = 'date';
const String categoryField = 'category';

// buat nama kolom tabel
const List<String> expensesColumns = [
  idField,
  titleField,
  amountField,
  dateField,
  categoryField,
];

// buat tipe data kolom tabel
const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
const String titleType = 'TEXT NOT NULL';
const String amountType = 'REAL NOT NULL';
const String dateType = 'TEXT NOT NULL';
const String categoryType = 'TEXT NOT NULL';

enum Category {
  food,
  travel,
  education,
  personal,
  other,
}

// model untuk expense
class Expense {
  final int? id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  Expense({
    this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  });

  // format date
  String get formattedDate {
    return formatter.format(date);
  }

  // format amount
  String get formattedAmount {
    return NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp',
      decimalDigits: 0,
    ).format(amount);
  }

  // konversi dari json ke object
  static Expense fromJson(Map<String, dynamic> json) => Expense(
        id: json[idField] as int,
        title: json[titleField] as String,
        amount: json[amountField] as double,
        date: DateTime.parse(json[dateField] as String),
        category: Category.values.firstWhere(
          (e) => e.name == json[categoryField] as String,
          orElse: () => Category.other,
        ),
      );

  // konversi dari object ke json
  Map<String, dynamic> toJson() => {
        idField: id,
        titleField: title,
        amountField: amount,
        dateField: date.toIso8601String(),
        categoryField: category.name,
      };

  //copy object
  Expense copyWith({
    int? id,
    String? title,
    double? amount,
    DateTime? date,
    Category? category,
  }) =>
      Expense(
        id: id ?? this.id,
        title: title ?? this.title,
        amount: amount ?? this.amount,
        date: date ?? this.date,
        category: category ?? this.category,
      );
}
