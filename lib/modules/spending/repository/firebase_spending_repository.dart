part of 'spending_repository.dart';

class FirebaseSpendingRepository implements SpendingRepository {
  final spendingCollection = FirebaseFirestore.instance.collection('spending');

  @override
  Future<void> addNewSpending(SpendingModel spendingModel) {
    return spendingCollection.add(spendingModel.toEntity().toDocument());
  }

  @override
  Future<void> deleteSpending(SpendingModel spendingModel) async {
    return spendingCollection.doc(spendingModel.id).delete();
  }

  @override
  Stream<List<SpendingModel>> spending() {
    return spendingCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => SpendingModel.fromEntity(SpendingEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  @override
  Future<void> updateSpending(SpendingModel update) {
    return spendingCollection.doc(update.id).update(update.toEntity().toDocument());
  }
}
