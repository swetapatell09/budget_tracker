class TransactionModel {
  String? title, category, date, time, amount;
  int? status, id;

  TransactionModel(
      {this.title,
      this.category,
      this.date,
      this.time,
      this.amount,
      this.id,
      this.status});

  factory TransactionModel.mapToModel(Map m1) {
    return TransactionModel(
        status: m1['status'],
        time: m1['time'],
        date: m1['date'],
        amount: m1['amount'],
        title: m1['title'],
        id: m1['id'],
        category: m1['category']);
  }
}
