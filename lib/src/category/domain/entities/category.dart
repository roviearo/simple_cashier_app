import 'package:const_date_time/const_date_time.dart';
import 'package:equatable/equatable.dart';

class Category extends Equatable {
  const Category({
    required this.id,
    required this.name,
    required this.createdAt,
    this.updatedAt,
    required this.isSynced,
  });

  const Category.empty()
      : this(
          id: 0,
          name: '',
          createdAt: const ConstDateTime(2024),
          updatedAt: const ConstDateTime(2024),
          isSynced: false,
        );

  final int id;
  final String name;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool isSynced;

  @override
  List<Object?> get props => [id, name, createdAt, updatedAt, isSynced];
}
