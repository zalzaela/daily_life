part of 'account_bloc.dart';

abstract class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object> get props => [];
}

class AccountLoading extends AccountState {}

class AccountLoaded extends AccountState {
  final List<AccountModel> accountModel;

  const AccountLoaded([this.accountModel = const []]);

  @override
  List<Object> get props => [accountModel];

  @override
  String toString() => 'AccountLoaded { account: $accountModel }';
}

class AccountNotLoaded extends AccountState {}
