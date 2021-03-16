part of 'account_models.dart';

class AccountEntity extends Equatable {
  final String id;
  final String name;
  final int balance;
  final String type;

  const AccountEntity(this.id, this.name, this.balance, this.type);

  Map<String, Object> toJson() {
    return {
      'id': id,
      'name': name,
      'balance': balance,
      'type': type,
    };
  }

  @override
  List<Object> get props => [id, name, balance, type];

  @override
  String toString() {
    return 'AccountEntity{id: $id, name: $name, balance: $balance, type: $type}';
  }

  static AccountEntity fromJson(Map<String, Object> json) {
    return AccountEntity(
      json['id'] as String,
      json['name'] as String,
      json['balance'] as int,
      json['type'] as String,
    );
  }

  static AccountEntity fromSnapshot(DocumentSnapshot snap) {
    return AccountEntity(
      snap.id,
      snap.data()['name'],
      snap.data()['balance'],
      snap.data()['type'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      'name': name,
      'balance': balance,
      'type': type,
    };
  }
}
