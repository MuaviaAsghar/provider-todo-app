import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

class Todo {
  Todo(
      {required this.id,
      required this.title,
 
      this.completed = false});
  final String id;
  final String title;
  
  final bool completed;
}

class CompletedList extends Notifier<List<Todo>> {
  @override
  List<Todo> build() => [];
  // TODO: implement build
}

class TodoList extends Notifier<List<Todo>> {
  @override
  List<Todo> build() => [];

  void add(String title) {
    state = [
      ...state,
      Todo(
        id: _uuid.v4(),
        title: title,
      
      ),
    ];
  }

  // Updated toggle method
  void toggle(String id) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          Todo(
            id: todo.id,
            title: todo.title,
        
            completed: !todo.completed,
          )
        else
          todo,
    ];
  }

  void edit(
      {required String id, required String title, }) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          Todo(
            id: todo.id,
            title: title,
           
            completed: todo.completed,
          )
        else
          todo,
    ];
  }

  void remove(Todo target) {
    state = state.where((todo) => todo.id != target.id).toList();
  }
}
