import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_example/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:supabase_example/src/feature/to_do/bloc/update_to_do/update_to_do_bloc.dart';
import 'package:supabase_example/src/feature/to_do/data/entity/to_do_entity.dart';
import 'package:supabase_example/src/feature/to_do/widget/to_do_scope.dart';

class UpdateToDo extends StatefulWidget {
  const UpdateToDo({
    super.key,
    required this.toDoEntity,
  });

  final ToDoEntity toDoEntity;

  @override
  State<UpdateToDo> createState() => _UpdateToDoState();
}

class _UpdateToDoState extends State<UpdateToDo> {
  late final ValueNotifier _isCompleted;
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _isCompleted = ValueNotifier(widget.toDoEntity.status);
    _titleController = TextEditingController(text: widget.toDoEntity.title);
    _descriptionController = TextEditingController(text: widget.toDoEntity.description);
  }

  @override
  void dispose() {
    _isCompleted.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update To Do'),
      ),
      body: BlocProvider(
        create: (context) => UpdateToDoBloc(
          widget.toDoEntity,
          toDoRepository: DependenciesScope.of(context).toDoRepository,
        ),
        child: BlocConsumer<UpdateToDoBloc, UpdateToDoState>(
          listener: (BuildContext context, UpdateToDoState state) {
            if (state.isSuccess) {
              ToDoScope.of(context).updateToDos(state.toDoEntity!);
              Navigator.of(context).pop();
            }
          },
          builder: (context, state) {
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                  ),
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: _isCompleted,
                  builder: (context, value, child) {
                    return CheckboxListTile(
                      title: const Text('Completed'),
                      value: value,
                      onChanged: (value) {
                        _isCompleted.value = value!;
                      },
                    );
                  },
                ),
                ElevatedButton(
                  onPressed: !state.isLoading
                      ? () {
                          context.read<UpdateToDoBloc>().add(
                                UpdateToDoEvent.update(
                                  status: _isCompleted.value,
                                  title: _titleController.text,
                                  description: _descriptionController.text,
                                ),
                              );
                        }
                      : null,
                  child: const Text('Update'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
