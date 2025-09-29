import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

class Todo extends Equatable {
  final String id;
  final String title;
  final bool completed;
  final DateTime createdAt;

  const Todo({
    required this.id,
    required this.title,
    this.completed = false,
    required this.createdAt,
  });

  factory Todo.create(String title) => Todo(
        id: _uuid.v4(),
        title: title.trim(),
        completed: false,
        createdAt: DateTime.now(),
      );

  Todo copyWith({String? title, bool? completed}) => Todo(
        id: id,
        title: title ?? this.title,
        completed: completed ?? this.completed,
        createdAt: createdAt,
      );

  // สำหรับ HydratedBloc
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'completed': completed,
        'createdAt': createdAt.toIso8601String(),
      };

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        id: json['id'] as String,
        title: json['title'] as String,
        completed: json['completed'] as bool,
        createdAt: DateTime.parse(json['createdAt'] as String),
      );

  @override
  List<Object?> get props => [id, title, completed, createdAt];
}
