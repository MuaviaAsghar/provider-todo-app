import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_todo/Screens/home_page.dart';
import 'package:riverpod_todo/Todo_Model/todo_model.dart';

final activeTodosProvider = Provider<List<Todo>>((ref) {
  final todos = ref.watch(todoListProvider);
  return todos.where((todo) => !todo.completed).toList();
});

class ActivePage extends ConsumerWidget {
  const ActivePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeTodos = ref.watch(activeTodosProvider);

    return Scaffold(
        body: activeTodos.isNotEmpty
            ? ListView.builder(
                itemCount: activeTodos.length,
                itemBuilder: (context, index) {
                  final todo = activeTodos[index];

                  return ListTile(
                    title: Text(todo.title),
                  );
                })
            : const Center(
                child: Text(
                    "whoo-hoo! you have completed all the task you can now chill."),
              ));
  }
}
