import 'package:equatable/equatable.dart';

class ToDoEntity extends Equatable {
  const ToDoEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.createdAt,
  });

  final int id;
  final String title;
  final String? description;
  final bool status;
  final DateTime createdAt;

  @override
  List<Object?> get props => [id, title, description, status, createdAt];
}
