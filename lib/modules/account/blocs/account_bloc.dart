import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:daily_life/modules/account/models/account_models.dart';
import 'package:daily_life/modules/account/repository/account_repository.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountRepository _accountRepository;
  StreamSubscription _accountSubscription;

  AccountBloc({@required AccountRepository accountRepository})
      : assert(accountRepository != null),
        _accountRepository = accountRepository,
        super(AccountLoading());

  @override
  Stream<AccountState> mapEventToState(AccountEvent event) async* {
    if (event is LoadAccount) {
      yield* _mapLoadAccountToState();
    } else if (event is AddAccount) {
      yield* _mapAddAccountToState(event);
    } else if (event is UpdateAccount) {
      yield* _mapUpdateAccountToState(event);
    } else if (event is DeleteAccount) {
      yield* _mapDeleteAccountToState(event);
    } else if (event is AccountUpdated) {
      yield* _mapAccountUpdateToState(event);
    }
  }

  Stream<AccountState> _mapLoadAccountToState() async* {
    _accountSubscription?.cancel();
    _accountSubscription = _accountRepository.account().listen(
          (account) => add(AccountUpdated(account)),
        );
  }

  Stream<AccountState> _mapAddAccountToState(AddAccount event) async* {
    _accountRepository.addNewAccount(event.accountModel);
  }

  Stream<AccountState> _mapUpdateAccountToState(UpdateAccount event) async* {
    _accountRepository.updateAccount(event.accountModel);
  }

  Stream<AccountState> _mapDeleteAccountToState(DeleteAccount event) async* {
    _accountRepository.deleteAccount(event.accountModel);
  }

  Stream<AccountState> _mapAccountUpdateToState(AccountUpdated event) async* {
    yield AccountLoaded(event.accountModel);
  }

  @override
  Future<void> close() {
    _accountSubscription?.cancel();
    return super.close();
  }
}
