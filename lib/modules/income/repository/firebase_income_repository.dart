part of 'income_repository.dart';

class FirebaseIncomeRepository implements IncomeRepository {
  final incomeCollection = FirebaseFirestore.instance.collection('income');

  @override
  Future<void> addNewIncome(IncomeModel incomeModel) {
    return incomeCollection.add(incomeModel.toEntity().toDocument());
  }

  @override
  Future<void> deleteIncome(IncomeModel incomeModel) async {
    return incomeCollection.doc(incomeModel.id).delete();
  }

  @override
  Stream<List<IncomeModel>> income() {
    return incomeCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => IncomeModel.fromEntity(IncomeEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  @override
  Future<void> updateIncome(IncomeModel update) {
    return incomeCollection.doc(update.id).update(update.toEntity().toDocument());
  }
}
