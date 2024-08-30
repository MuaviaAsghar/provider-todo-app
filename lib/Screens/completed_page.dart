import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_todo/Screens/home_page.dart';
import 'package:riverpod_todo/Todo_Model/todo_model.dart';

final completedTodosProvider = Provider<List<Todo>>((ref) {
  final todos = ref.watch(todoListProvider);
  return todos.where((todo) => todo.completed).toList();
});

class CompletedPage extends ConsumerWidget {
  const CompletedPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completedTodos = ref.watch(completedTodosProvider);

    return Scaffold(
        body: completedTodos.isNotEmpty
            ? ListView.builder(
                itemCount: completedTodos.length,
                itemBuilder: (context, index) {
                  final todo = completedTodos[index];

                  return ListTile(
                    title: Text(todo.title),
                  );
                })
            : const Center(child: Text("You need to complete some tasks!")));
  }
}
