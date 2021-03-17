part of 'spending_repository.dart';

class FirebaseSpendingRepository implements SpendingRepository {
  final spendingCollection = FirebaseFirestore.instance.collection('spending');
  final accountCollection = FirebaseFirestore.instance.collection('account');

  @override
  Future<void> addNewSpending(SpendingModel spendingModel) {
    Map<String, dynamic> data = spendingModel.toEntity().toDocument();
    data['uid'] = AuthenticationDetail.authenticationDetail.uid;
    accountCollection
        .doc(data['accountId'])
        .update({'balance': FieldValue.increment(-data['amount'])});

    return spendingCollection.add(data);
  }

  @override
  Future<void> deleteSpending(SpendingModel spendingModel) async {
    Map<String, dynamic> data = spendingModel.toEntity().toDocument();
    data['uid'] = AuthenticationDetail.authenticationDetail.uid;
    accountCollection.doc(data['accountId']).update({'balance' : FieldValue.increment(data['amount'])});

    return spendingCollection.doc(spendingModel.id).delete();
  }

  @override
  Stream<List<SpendingModel>> spending() {
    return spendingCollection
        .where('uid', isEqualTo: AuthenticationDetail.authenticationDetail.uid)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) =>
              SpendingModel.fromEntity(SpendingEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  @override
  Future<void> updateSpending(SpendingModel spendingModel) {
    return spendingCollection
        .doc(spendingModel.id)
        .update(spendingModel.toEntity().toDocument());
  }
}
