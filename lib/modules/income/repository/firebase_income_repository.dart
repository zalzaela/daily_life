part of 'income_repository.dart';

class FirebaseIncomeRepository implements IncomeRepository {
  final incomeCollection = FirebaseFirestore.instance.collection('income');
  final accountCollection = FirebaseFirestore.instance.collection('account');

  @override
  Future<void> addNewIncome(IncomeModel incomeModel) {
    Map<String, dynamic> data = incomeModel.toEntity().toDocument();
    data['uid'] = AuthenticationDetail.authenticationDetail.uid;
    accountCollection.doc(data['accountId']).update({'balance' : FieldValue.increment(data['amount'])});

    return incomeCollection.add(data);
  }

  @override
  Future<void> deleteIncome(IncomeModel incomeModel) async {
    Map<String, dynamic> data = incomeModel.toEntity().toDocument();
    data['uid'] = AuthenticationDetail.authenticationDetail.uid;
    accountCollection.doc(data['accountId']).update({'balance' : FieldValue.increment(-data['amount'])});

    return incomeCollection.doc(incomeModel.id).delete();
  }

  @override
  Stream<List<IncomeModel>> income() {
    return incomeCollection.where('uid', isEqualTo: AuthenticationDetail.authenticationDetail.uid).snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => IncomeModel.fromEntity(IncomeEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  @override
  Future<void> updateIncome(IncomeModel incomeModel) {
    return incomeCollection.doc(incomeModel.id).update(incomeModel.toEntity().toDocument());
  }
}
