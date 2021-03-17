part of 'account_repository.dart';

class FirebaseAccountRepository implements AccountRepository {
  final accountCollection = FirebaseFirestore.instance.collection('account');

  @override
  Future<void> addNewAccount(AccountModel accountModel) {
    Map<String, dynamic> data = accountModel.toEntity().toDocument();
    data['uid'] = AuthenticationDetail.authenticationDetail.uid;
    return accountCollection.add(accountModel.toEntity().toDocument());
  }

  @override
  Future<void> deleteAccount(AccountModel accountModel) async {
    return accountCollection.doc(accountModel.id).delete();
  }

  @override
  Stream<List<AccountModel>> account() {
    return accountCollection.where('uid', isEqualTo: AuthenticationDetail.authenticationDetail.uid).snapshots().map((snapshot) {
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
