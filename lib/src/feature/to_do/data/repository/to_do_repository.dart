import 'package:supabase_example/src/feature/to_do/data/entity/to_do_entity.dart';
import 'package:supabase_example/src/feature/to_do/data/provider/to_do_provider.dart';

abstract interface class ToDoRepository {
  Future<ToDoEntity> create({
    required String title,
    String? description,
  });

  Future<Iterable<ToDoEntity>> readAll({
    bool? status,
  });

  Future<ToDoEntity> readById(int id);

  Future<ToDoEntity> update({
    required int id,
    String? title,
    String? description,
    bool? status,
  });

  Future<void> delete(int id);
}

final class ToDoRepositoryImpl implements ToDoRepository {
  const ToDoRepositoryImpl({
    required ToDoProvider toDoProvider,
  }) : _toDoProvider = toDoProvider;

  final ToDoProvider _toDoProvider;

  @override
  Future<ToDoEntity> create({
    required String title,
    String? description,
  }) async {
    return _toDoProvider.create(
      title: title,
      description: description,
    );
  }

  @override
  Future<Iterable<ToDoEntity>> readAll({
    bool? status,
  }) async {
    return _toDoProvider.readAll(
      status: status,
    );
  }

  @override
  Future<ToDoEntity> readById(int id) async {
    return _toDoProvider.readById(id);
  }

  @override
  Future<void> delete(int id) {
    return _toDoProvider.delete(id);
  }

  @override
  Future<ToDoEntity> update({
    required int id,
    String? title,
    String? description,
    bool? status,
  }) async {
    return _toDoProvider.update(
      id: id,
      title: title,
      description: description,
      status: status,
    );
  }
}
