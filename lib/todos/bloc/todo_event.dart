import 'package:equatable/equatable.dart';
import '../models/todo.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();
  @override
  List<Object?> get props => [];
}

class TodoAdded extends TodoEvent {
  final String title;
  const TodoAdded(this.title);
  @override
  List<Object?> get props => [title];
}

class TodoToggled extends TodoEvent {
  final String id;
  const TodoToggled(this.id);
  @override
  List<Object?> get props => [id];
}

class TodoDeleted extends TodoEvent {
  final String id;
  const TodoDeleted(this.id);
  @override
  List<Object?> get props => [id];
}

class TodoEdited extends TodoEvent {
  final String id;
  final String newTitle;
  const TodoEdited(this.id, this.newTitle);
  @override
  List<Object?> get props => [id, newTitle];
}

class TodosClearedCompleted extends TodoEvent {
  const TodosClearedCompleted();
}
