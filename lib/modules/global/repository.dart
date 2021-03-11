import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_life/modules/spending/models/spendingModel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Repository {
  final FirebaseFirestore _firebaseFirestore;
  Repository(this._firebaseFirestore) : assert(_firebaseFirestore != null);
  var user = FirebaseAuth.instance.currentUser;

  Stream<List<SpendingModel>> getSpending() {
    print(user.uid);
    return _firebaseFirestore
        .collection('spending')
        .where('uid', isEqualTo: user.uid)
        .orderBy('date', descending: true)
        .limit(20)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((e) => SpendingModel(
              e.id,
              e.data()['account'],
              e.data()['amount'],
              e.data()['category'],
              e.data()['date'],
              e.data()['note'],
              e.data()['uid']))
          .toList();
    });
  }

  Future<DocumentSnapshot> getById(String id) {
    return _firebaseFirestore.collection('spending').doc(id).get();
  }

  Future<SpendingModel> getSpendingById(String id) async {
    var doc = await this.getById(id);
    return  SpendingModel.fromMap(doc.data(), doc.id);
  }

  Future<void> updateSpending(String id, SpendingModel spendingModel) {
    return _firebaseFirestore.collection('spending').doc(id).update({
      'account': spendingModel.account,
      'amount': spendingModel.amount,
      'category': spendingModel.category,
      'date': spendingModel.date,
      'note': spendingModel.note,
      'uid': spendingModel.uid
    });
  }

  Future<DocumentReference> addSpending(SpendingModel spendingModel) {
    return _firebaseFirestore.collection('spending').add({
      'account': spendingModel.account,
      'amount': spendingModel.amount,
      'category': spendingModel.category,
      'date': spendingModel.date,
      'note': spendingModel.note,
      'uid': spendingModel.uid
    });
  }
}
