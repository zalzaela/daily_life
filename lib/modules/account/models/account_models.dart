import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'account_entity.dart';

@immutable
class AccountModel {
  final String id;
  final String name;
  final int balance;
  final String type;

  AccountModel(
      {String id,
      String name,
      int balance,
      String type = ''})
      : this.id = id,
        this.name = name ?? '',
        this.balance = balance ?? 0,
        this.type = type ?? '';

  AccountModel copyWith({
    String id,
    String name,
    int balance,
    String type
  }) {
    return AccountModel(
      id: id ?? this.id,
      name: name ?? this.name,
      balance: balance ?? this.balance,
      type: type ?? this.type,
    );
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      balance.hashCode ^
      type.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          balance == other.balance &&
          type == other.type;

  @override
  String toString() {
    return 'AccountModel{id: $id, name: $name, balance: $balance, type: $type}';
  }

  AccountEntity toEntity() {
    return AccountEntity(id, name, balance, type);
  }

  static AccountModel fromEntity(AccountEntity entity) {
    return AccountModel(
      id: entity.id,
      name: entity.name,
      balance: entity.balance,
      type: entity.type,
    );
  }
}
