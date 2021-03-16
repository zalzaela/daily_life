part of 'account_bloc.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object> get props => [];
}

class LoadAccount extends AccountEvent {}

class AddAccount extends AccountEvent {
  final AccountModel accountModel;

  const AddAccount(this.accountModel);

  @override
  List<Object> get props => [accountModel];

  @override
  String toString() => 'AddAccount { accountModel: $accountModel }';
}

class UpdateAccount extends AccountEvent {
  final AccountModel accountModel;

  const UpdateAccount(this.accountModel);

  @override
  List<Object> get props => [accountModel];

  @override
  String toString() => 'UpdateAccount { accountModel: $accountModel }';
}

class DeleteAccount extends AccountEvent {
  final AccountModel accountModel;

  const DeleteAccount(this.accountModel);

  @override
  List<Object> get props => [accountModel];

  @override
  String toString() => 'DeleteAccount { accountModel: $accountModel }';
}

class AccountUpdated extends AccountEvent {
  final List<AccountModel> accountModel;

  const AccountUpdated(this.accountModel);

  @override
  List<Object> get props => [accountModel];
}
