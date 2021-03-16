part of 'category_models.dart';

class CategoryEntity extends Equatable {
  final String id;
  final String name;
  final String type;

  const CategoryEntity(this.id, this.name, this.type);

  Map<String, Object> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
    };
  }

  @override
  List<Object> get props => [id, name, type];

  @override
  String toString() {
    return 'CategoryEntity{id: $id, name: $name, type: $type}';
  }

  static CategoryEntity fromJson(Map<String, Object> json) {
    return CategoryEntity(
      json['id'] as String,
      json['name'] as String,
      json['type'] as String,
    );
  }

  static CategoryEntity fromSnapshot(DocumentSnapshot snap) {
    return CategoryEntity(
      snap.id,
      snap.data()['name'],
      snap.data()['type'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      'name': name,
      'type': type,
    };
  }
}
