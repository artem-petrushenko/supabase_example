import 'package:supabase_example/src/feature/to_do/data/entity/to_do_entity.dart';

class ToDoDto extends ToDoEntity {
  const ToDoDto({
    required super.id,
    required super.title,
    required super.description,
    required super.status,
    required super.createdAt,
  });

  factory ToDoDto.fromMap(Map<String, dynamic> json) {
    return ToDoDto(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String?,
      status: json['status'] as bool,
      createdAt: DateTime.parse(
        json['created_at'] as String,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
