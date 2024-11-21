import 'package:flutter/material.dart';
import 'package:supabase_example/src/core/utils/extensions/context_extension.dart';
import 'package:supabase_example/src/feature/to_do/bloc/fetch_to_do_check_list/fetch_to_do_check_list_bloc.dart';
import 'package:supabase_example/src/feature/to_do/bloc/fetch_to_do_list/fetch_to_do_list_bloc.dart';
import 'package:supabase_example/src/feature/to_do/data/entity/to_do_entity.dart';

abstract interface class ToDoScopeController {
  void updateToDos(ToDoEntity toDoEntity);
}

class ToDoScope extends StatelessWidget implements ToDoScopeController {
  /// Create a [ToDoScope]
  const ToDoScope({
    super.key,
    required this.child,
    required this.toDoCheckListBloc,
    required this.toDoListBloc,
  });

  /// The child widget
  final Widget child;

  final FetchToDoCheckListBloc toDoCheckListBloc;
  final FetchToDoListBloc toDoListBloc;

  static ToDoScopeController of(
    BuildContext context, {
    bool listen = true,
  }) =>
      context.inhOf<_InheritedToDoScope>(listen: listen).controller;

  @override
  Widget build(BuildContext context) => _InheritedToDoScope(
        controller: this,
        child: child,
      );

  @override
  void updateToDos(ToDoEntity toDoEntity) {
    toDoListBloc.add(FetchToDoListEvent.update(toDoEntity: toDoEntity));
    toDoCheckListBloc.add(FetchToDoCheckListEvent.update(toDoEntity: toDoEntity));
  }
}

class _InheritedToDoScope extends InheritedWidget {
  const _InheritedToDoScope({
    required this.controller,
    required super.child,
  });

  final ToDoScopeController controller;

  @override
  bool updateShouldNotify(_InheritedToDoScope oldWidget) => false;
}
