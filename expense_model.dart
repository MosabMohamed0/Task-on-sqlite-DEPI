class ExpenseModel {
  int? id;
  DateTime date;
  double amount;
  String category;
  String note;

  ExpenseModel({
    this.id,
    required this.date,
    required this.amount,
    required this.category,
    required this.note,
  });

  // Convert to Map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'date': date.toIso8601String(), 
      'amount': amount,
      'category': category,
      'note': note,
    };
  }

  // Create from Map
  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      id: map['id'] as int,
      date: DateTime.parse(map['date'].toString()),
      amount: (map['amount'] as num).toDouble(),
      category: map['category'] as String,
      note: map['note'] as String,
    );
  }
}
