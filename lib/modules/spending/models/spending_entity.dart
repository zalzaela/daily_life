part of 'spending_models.dart';

class SpendingEntity extends Equatable {
  final String id;
  final String account;
  final String accountId;
  final int amount;
  final String category;
  final Timestamp date;
  final String note;

  const SpendingEntity(this.id, this.account, this.accountId, this.amount, this.category, this.date,
      this.note);

  Map<String, Object> toJson() {
    return {
      'id': id,
      'account': account,
      'accountId': accountId,
      'amount': amount,
      'category': category,
      'date': date,
      'note': note,
    };
  }

  @override
  List<Object> get props => [id, account, accountId, amount, category, date, note/*, uid*/];

  @override
  String toString() {
    return 'SpendingEntity{id: $id, account: $account, accountId: $accountId, amount: $amount, category: $category, date: $date, note: $note}';
  }

  static SpendingEntity fromJson(Map<String, Object> json) {
    return SpendingEntity(
      json['id'] as String,
      json['account'] as String,
      json['accountId'] as String,
      json['amount'] as int,
      json['category'] as String,
      json['date'] as Timestamp,
      json['note'] as String,
    );
  }

  static SpendingEntity fromSnapshot(DocumentSnapshot snap) {
    return SpendingEntity(
      snap.id,
      snap.data()['account'],
      snap.data()['accountId'],
      snap.data()['amount'],
      snap.data()['category'],
      snap.data()['date'],
      snap.data()['note']
    );
  }

  Map<String, Object> toDocument() {
    return {
      'account': account,
      'accountId': accountId,
      'amount': amount,
      'category': category,
      'date': date,
      'note': note,
    };
  }
}
