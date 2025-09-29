import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'todo_event.dart';
import 'todo_state.dart';
import '../models/todo.dart';

class TodoBloc extends HydratedBloc<TodoEvent, TodoState> {
  TodoBloc() : super(const TodoState()) {
    on<TodoAdded>((event, emit) {
      if (event.title.trim().isEmpty) return;
      final todo = Todo.create(event.title);
      final updated = List<Todo>.from(state.todos)..insert(0, todo);
      emit(state.copyWith(todos: updated));
    });

    on<TodoToggled>((event, emit) {
      final updated = state.todos
          .map((t) => t.id == event.id ? t.copyWith(completed: !t.completed) : t)
          .toList();
      emit(state.copyWith(todos: updated));
    });

    on<TodoDeleted>((event, emit) {
      final updated = state.todos.where((t) => t.id != event.id).toList();
      emit(state.copyWith(todos: updated));
    });

    on<TodoEdited>((event, emit) {
      final updated = state.todos
          .map((t) => t.id == event.id ? t.copyWith(title: event.newTitle) : t)
          .toList();
      emit(state.copyWith(todos: updated));
    });

    on<TodosClearedCompleted>((event, emit) {
      final updated = state.todos.where((t) => !t.completed).toList();
      emit(state.copyWith(todos: updated));
    });
  }

  // Hydrated
  @override
  TodoState? fromJson(Map<String, dynamic> json) {
    try {
      return TodoState.fromJson(json);
    } catch (_) {
      return const TodoState();
    }
  }

  @override
  Map<String, dynamic>? toJson(TodoState state) => state.toJson();
}
