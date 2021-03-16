part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class LoadCategory extends CategoryEvent {}

class AddCategory extends CategoryEvent {
  final CategoryModel categoryModel;

  const AddCategory(this.categoryModel);

  @override
  List<Object> get props => [categoryModel];

  @override
  String toString() => 'AddCategory { categoryModel: $categoryModel }';
}

class UpdateCategory extends CategoryEvent {
  final CategoryModel categoryModel;

  const UpdateCategory(this.categoryModel);

  @override
  List<Object> get props => [categoryModel];

  @override
  String toString() => 'UpdateCategory { categoryModel: $categoryModel }';
}

class DeleteCategory extends CategoryEvent {
  final CategoryModel categoryModel;

  const DeleteCategory(this.categoryModel);

  @override
  List<Object> get props => [categoryModel];

  @override
  String toString() => 'DeleteCategory { categoryModel: $categoryModel }';
}

class CategoryUpdated extends CategoryEvent {
  final List<CategoryModel> categoryModel;

  const CategoryUpdated(this.categoryModel);

  @override
  List<Object> get props => [categoryModel];
}
