import 'package:equatable/equatable.dart';
import '../models/todo.dart';

class TodoState extends Equatable {
  final List<Todo> todos;

  const TodoState({this.todos = const []});

  TodoState copyWith({List<Todo>? todos}) => TodoState(
        todos: todos ?? this.todos,
      );

  Map<String, dynamic> toJson() => {
        'todos': todos.map((t) => t.toJson()).toList(),
      };

  factory TodoState.fromJson(Map<String, dynamic> json) => TodoState(
        todos: (json['todos'] as List<dynamic>)
            .map((e) => Todo.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  @override
  List<Object?> get props => [todos];
}
