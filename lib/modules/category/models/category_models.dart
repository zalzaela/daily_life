import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'category_entity.dart';

@immutable
class CategoryModel {
  final String id;
  final String name;
  final String type;

  CategoryModel(
      {String id,
      String name,
      int balance,
      String type = ''})
      : this.id = id,
        this.name = name ?? '',
        this.type = type ?? '';

  CategoryModel copyWith({
    String id,
    String name,
    String type
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
    );
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      type.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          type == other.type;

  @override
  String toString() {
    return 'CategoryModel{id: $id, name: $name, type: $type}';
  }

  CategoryEntity toEntity() {
    return CategoryEntity(id, name, type);
  }

  static CategoryModel fromEntity(CategoryEntity entity) {
    return CategoryModel(
      id: entity.id,
      name: entity.name,
      type: entity.type,
    );
  }
}
