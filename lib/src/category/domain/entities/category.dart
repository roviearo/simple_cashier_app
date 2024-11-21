import 'package:const_date_time/const_date_time.dart';
import 'package:equatable/equatable.dart';

class Category extends Equatable {
  const Category({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.isSynced,
  });

  const Category.empty()
      : this(
          id: 0,
          name: '',
          createdAt: const ConstDateTime(2024),
          updatedAt: const ConstDateTime(2024),
          isSynced: 0,
        );

  final int id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int isSynced;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'updated_at': updatedAt.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'is_synced': isSynced,
    };
  }

  @override
  List<Object?> get props => [id, name, createdAt, updatedAt, isSynced];
}
