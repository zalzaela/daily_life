import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_life/modules/income/models/income_models.dart';

part 'firebase_income_repository.dart';

abstract class IncomeRepository {
  Future<void> addNewIncome(IncomeModel incomeModel);

  Future<void> deleteIncome(IncomeModel incomeModel);

  Stream<List<IncomeModel>> income();

  Future<void> updateIncome(IncomeModel incomeModel);
}
