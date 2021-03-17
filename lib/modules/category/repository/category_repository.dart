import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_life/modules/auth/models/authentication_detail.dart';
import 'package:daily_life/modules/category/models/category_models.dart';

part 'firebase_category_repository.dart';

abstract class CategoryRepository {
  Future<void> addNewCategory(CategoryModel categoryModel);

  Future<void> deleteCategory(CategoryModel categoryModel);

  Stream<List<CategoryModel>> category();

  Future<void> updateCategory(CategoryModel categoryModel);
}
