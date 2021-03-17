import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'spending_entity.dart';

@immutable
class SpendingModel {
  final String id;
  final String account;
  final String accountId;
  final int amount;
  final String category;
  final Timestamp date;
  final String note;

  SpendingModel(
      {String id,
      String account,
      String accountId,
      int amount,
      String category = '',
      Timestamp date,
      String note = '',
      String uid})
      : this.id = id,
        this.account = account ?? '',
        this.accountId = accountId ?? '',
        this.amount = amount ?? 0,
        this.category = category ?? '',
        this.date = date ?? '',
        this.note = note ?? '';

  SpendingModel copyWith({
    String id,
    String account,
    String accountId,
    int amount,
    String category,
    Timestamp date,
    String note,
  }) {
    return SpendingModel(
      id: id ?? this.id,
      account: account ?? this.account,
      accountId: accountId ?? this.accountId,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      date: date ?? this.date,
      note: note ?? this.note,
    );
  }

  @override
  int get hashCode =>
      id.hashCode ^
      account.hashCode ^
      accountId.hashCode ^
      amount.hashCode ^
      category.hashCode ^
      date.hashCode ^
      note.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpendingModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          account == other.account &&
          accountId == other.accountId &&
          amount == other.amount &&
          category == other.category &&
          date == other.date &&
          note == other.note;

  @override
  String toString() {
    return 'SpendingModel{id: $id, account: $account, accountId: $accountId, amount: $amount, category: $category, date: $date, note: $note}';
  }

  SpendingEntity toEntity() {
    return SpendingEntity(id, account, accountId, amount, category, date, note);
  }

  static SpendingModel fromEntity(SpendingEntity entity) {
    return SpendingModel(
      id: entity.id,
      account: entity.account,
      accountId: entity.accountId,
      amount: entity.amount,
      category: entity.category,
      date: entity.date,
      note: entity.note,
    );
  }
}
