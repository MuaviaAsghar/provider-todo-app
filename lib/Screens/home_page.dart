import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Import your Todo model
import '../Todo_Model/todo_model.dart';

// TodoList provider to manage the list of Todos
final todoListProvider = NotifierProvider<TodoList, List<Todo>>(TodoList.new);

/// Main app widget
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the current list of todos from the provider
    final todos = ref.watch(todoListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("RiverPod Todo App"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];

                return Dismissible(
                  key: Key(todo.id),
                  direction: DismissDirection.horizontal,
                  onDismissed: (DismissDirection direction) {
                    ref.read(todoListProvider.notifier).remove(todo);
                  },
                  child: ListTile(
                    leading: Checkbox(
                      value: todo.completed,
                      onChanged: (value) =>
                          ref.read(todoListProvider.notifier).toggle(todo.id),
                    ),
                    title: Text(todo.title),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => _editTodoDialog(context, ref, todo),
                    ),
                    onLongPress: () => _editTodoDialog(context, ref, todo),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => _openAlertDialog(context, ref)),
    );
  }

  // Method to open a dialog for adding a new Todo
  void _openAlertDialog(BuildContext context, WidgetRef ref) {
    final TextEditingController titleController = TextEditingController();

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add Todo Item"),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Task'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a task ';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Submit'),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  // Add the new Todo to the list
                  ref.read(todoListProvider.notifier).add(
                        titleController.text,
                      );
                  // Close the dialog
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  // Method to open a dialog for editing an existing Todo
  void _editTodoDialog(BuildContext context, WidgetRef ref, Todo todo) {
    final TextEditingController titleController =
        TextEditingController(text: todo.title);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Edit Todo Item"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a task ';
                  }
                  return null;
                },
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Update'),
              onPressed: () {
                // Update the existing Todo with new data
                ref.read(todoListProvider.notifier).edit(
                      id: todo.id,
                      title: titleController.text,
                    );

                // Close the dialog
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
