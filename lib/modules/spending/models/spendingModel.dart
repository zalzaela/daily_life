class SpendingModel {
  final String id;
  final String account;
  final int amount;
  final String category;
  final String date;
  final String note;
  final String uid;

  SpendingModel(this.id, this.account, this.amount, this.category, this.date,
      this.note, this.uid);

  SpendingModel.fromMap(Map snapshot, String id)
      : id = id ?? '',
        account = snapshot['account'] ?? '',
        amount = snapshot['amount'] ?? '',
        category = snapshot['category'] ?? '',
        date = snapshot['date'] ?? '',
        note = snapshot['note'] ?? '',
        uid = snapshot['uid'] ?? '';

  toJson() {
    return {
      "account": account,
      "amount": amount,
      "category": category,
      "date": date,
      "note": note,
      "uid": uid,
    };
  }
}
