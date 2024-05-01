class TransactionModel {
  String? title, category, date, time, amount;
  int? status;

  TransactionModel(
      {this.title,
      this.category,
      this.date,
      this.time,
      this.amount,
      this.status});
}
