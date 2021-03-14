import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_life/modules/spending/models/spending_models.dart';

part 'firebase_spending_repository.dart';

abstract class SpendingRepository {
  Future<void> addNewSpending(SpendingModel spendingModel);

  Future<void> deleteSpending(SpendingModel spendingModel);

  Stream<List<SpendingModel>> spending();

  Future<void> updateSpending(SpendingModel spendingModel);
}
