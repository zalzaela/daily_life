import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_life/modules/account/models/account_models.dart';
import 'package:daily_life/modules/authentication/models/authentication_detail.dart';

part 'firebase_account_repository.dart';

abstract class AccountRepository {
  Future<void> addNewAccount(AccountModel accountModel);

  Future<void> deleteAccount(AccountModel accountModel);

  Stream<List<AccountModel>> account();

  Future<void> updateAccount(AccountModel accountModel);
}
