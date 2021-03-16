part of 'account_repository.dart';

class FirebaseAccountRepository implements AccountRepository {
  final accountCollection = FirebaseFirestore.instance.collection('account');

  @override
  Future<void> addNewAccount(AccountModel accountModel) {
    return accountCollection.add(accountModel.toEntity().toDocument());
  }

  @override
  Future<void> deleteAccount(AccountModel accountModel) async {
    return accountCollection.doc(accountModel.id).delete();
  }

  @override
  Stream<List<AccountModel>> account() {
    return accountCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => AccountModel.fromEntity(AccountEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  @override
  Future<void> updateAccount(AccountModel accountModel) {
    return accountCollection.doc(accountModel.id).update(accountModel.toEntity().toDocument());
  }
}
