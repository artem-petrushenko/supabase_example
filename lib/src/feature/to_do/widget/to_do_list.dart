import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_example/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:supabase_example/src/feature/to_do/bloc/fetch_to_do_list/fetch_to_do_list_bloc.dart';

class ToDoList extends StatelessWidget {
  const ToDoList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FetchToDoListBloc(
        toDoRepository: DependenciesScope.of(context).toDoRepository,
      )..add(const FetchToDoListEvent.fetch()),
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () {
            final completer = Completer<void>();
            context.read<FetchToDoListBloc>().add(FetchToDoListEvent.fetch(completer: completer));
            return completer.future;
          },
          child: BlocConsumer<FetchToDoListBloc, FetchToDoListState>(
            listener: (BuildContext context, FetchToDoListState state) {},
            builder: (context, state) {
              return CustomScrollView(
                slivers: <Widget>[
                  const SliverAppBar(
                    title: Text('To Do List'),
                    floating: true,
                    snap: true,
                  ),
                  if (state.isLoading && !state.hasData)
                    const SliverFillRemaining(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  if (state.hasFailure)
                    SliverFillRemaining(
                      child: Center(
                        child: Text(state.message),
                      ),
                    ),
                  if (!state.hasData && !state.isLoading)
                    const SliverFillRemaining(
                      child: Center(
                        child: Text('No To Do'),
                      ),
                    ),
                  if (state.hasData)
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          final toDo = state.toDos[index];
                          return Dismissible(
                            key: Key(toDo.id.toString()),
                            onDismissed: (direction) {
                              context.read<FetchToDoListBloc>().add(FetchToDoListEvent.remove(id: toDo.id));
                            },
                            child: ListTile(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  '/to_do/update',
                                  arguments: toDo,
                                );
                              },
                              leading: Checkbox(
                                value: toDo.status,
                                onChanged: (value) {},
                              ),
                              title: Text(toDo.title),
                              subtitle: toDo.description != null ? Text(toDo.description!) : null,
                            ),
                          );
                        },
                        childCount: state.toDos.length,
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
