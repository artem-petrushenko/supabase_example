import 'package:supabase_example/src/feature/to_do/data/dto/to_do_dto.dart';
import 'package:supabase_example/src/feature/to_do/data/entity/to_do_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class ToDoProvider {
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

final class ToDoProviderRemoteDataNetwork implements ToDoProvider {
  const ToDoProviderRemoteDataNetwork({
    required SupabaseQueryBuilder client,
  }) : _client = client;

  final SupabaseQueryBuilder _client;

  @override
  Future<ToDoEntity> create({
    required String title,
    String? description,
  }) async {
    final response = await _client.insert({
      'title': '1',
      'description': '1',
      'status': false,
    });
    return ToDoDto.fromMap(response);
  }

  @override
  Future<Iterable<ToDoEntity>> readAll({
    bool? status,
  }) async {
    PostgrestFilterBuilder<List<Map<String, dynamic>>> query = _client.select();
    if (status != null) {
      query = query.eq('status', status);
    }
    final response = await query.select();

    return response.map((e) => ToDoDto.fromMap(e));
  }

  @override
  Future<ToDoEntity> readById(int id) async {
    final response = await _client
        .select()
        .eq('id', id)
        .single();

    return ToDoDto.fromMap(response);
  }

  @override
  Future<ToDoEntity> update({
    required int id,
    String? title,
    String? description,
    bool? status,
  }) async {
    final response = await _client
        .update({
          if (title != null) 'title': title,
          if (description != null) 'description': description,
          if (status != null) 'status': status,
        })
        .eq('id', id)
        .select('*')
        .single();

    return ToDoDto.fromMap(response);
  }

  @override
  Future<void> delete(int id) async {
    await _client.delete().eq('id', id);
  }
}
