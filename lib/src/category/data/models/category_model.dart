import 'package:simple_cashier_app/core/utils/typedef.dart';
import 'package:simple_cashier_app/src/category/domain/entities/category.dart';

class CategoryModel extends Category {
  const CategoryModel({
    required super.id,
    required super.name,
    required super.createdAt,
    super.updatedAt,
    required super.isSynced,
  });

  CategoryModel.fromMap(DataMap data)
      : this(
            id: data['id'],
            name: data['name'],
            createdAt: DateTime.parse(data['created_at']),
            isSynced: data['is_synced']);

  CategoryModel copyWith({
    int? id,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isSynced,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isSynced: isSynced ?? this.isSynced,
    );
  }
}
