part of 'category_repository.dart';

class FirebaseCategoryRepository implements CategoryRepository {
  final categoryCollection = FirebaseFirestore.instance.collection('category');

  @override
  Future<void> addNewCategory(CategoryModel categoryModel) {
    return categoryCollection.add(categoryModel.toEntity().toDocument());
  }

  @override
  Future<void> deleteCategory(CategoryModel categoryModel) async {
    return categoryCollection.doc(categoryModel.id).delete();
  }

  @override
  Stream<List<CategoryModel>> category() {
    return categoryCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => CategoryModel.fromEntity(CategoryEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  @override
  Future<void> updateCategory(CategoryModel categoryModel) {
    return categoryCollection.doc(categoryModel.id).update(categoryModel.toEntity().toDocument());
  }
}
