part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<CategoryModel> categoryModel;

  const CategoryLoaded([this.categoryModel = const []]);

  @override
  List<Object> get props => [categoryModel];

  @override
  String toString() => 'CategoryLoaded { category: $categoryModel }';
}

class CategoryNotLoaded extends CategoryState {}
