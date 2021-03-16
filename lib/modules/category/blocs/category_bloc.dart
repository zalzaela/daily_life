import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:daily_life/modules/category/models/category_models.dart';
import 'package:daily_life/modules/category/repository/category_repository.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository _categoryRepository;
  StreamSubscription _categorySubscription;

  CategoryBloc({@required CategoryRepository categoryRepository})
      : assert(categoryRepository != null),
        _categoryRepository = categoryRepository,
        super(CategoryLoading());

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    if (event is LoadCategory) {
      yield* _mapLoadCategoryToState();
    } else if (event is AddCategory) {
      yield* _mapAddCategoryToState(event);
    } else if (event is UpdateCategory) {
      yield* _mapUpdateCategoryToState(event);
    } else if (event is DeleteCategory) {
      yield* _mapDeleteCategoryToState(event);
    } else if (event is CategoryUpdated) {
      yield* _mapCategoryUpdateToState(event);
    }
  }

  Stream<CategoryState> _mapLoadCategoryToState() async* {
    _categorySubscription?.cancel();
    _categorySubscription = _categoryRepository.category().listen(
          (category) => add(CategoryUpdated(category)),
        );
  }

  Stream<CategoryState> _mapAddCategoryToState(AddCategory event) async* {
    _categoryRepository.addNewCategory(event.categoryModel);
  }

  Stream<CategoryState> _mapUpdateCategoryToState(UpdateCategory event) async* {
    _categoryRepository.updateCategory(event.categoryModel);
  }

  Stream<CategoryState> _mapDeleteCategoryToState(DeleteCategory event) async* {
    _categoryRepository.deleteCategory(event.categoryModel);
  }

  Stream<CategoryState> _mapCategoryUpdateToState(CategoryUpdated event) async* {
    yield CategoryLoaded(event.categoryModel);
  }

  @override
  Future<void> close() {
    _categorySubscription?.cancel();
    return super.close();
  }
}
