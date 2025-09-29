import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/todo_bloc.dart';
import '../../bloc/todo_event.dart';
import '../../bloc/todo_state.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        if (state.todos.isEmpty) {
          return const Center(child: Text('ยังไม่มีงาน ทำรายการใหม่ได้ด้านล่าง'));
        }
        return ListView.separated(
          itemCount: state.todos.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final todo = state.todos[index];
            return Dismissible(
              key: ValueKey(todo.id),
              background: Container(color: Colors.red),
              onDismissed: (_) =>
                  context.read<TodoBloc>().add(TodoDeleted(todo.id)),
              child: ListTile(
                leading: Checkbox(
                  value: todo.completed,
                  onChanged: (_) =>
                      context.read<TodoBloc>().add(TodoToggled(todo.id)),
                ),
                title: Text(
                  todo.title,
                  style: TextStyle(
                    decoration:
                        todo.completed ? TextDecoration.lineThrough : null,
                  ),
                ),
                onTap: () async {
                  final textController = TextEditingController(text: todo.title);
                  final newTitle = await showDialog<String>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('แก้ไขงาน'),
                      content: TextField(
                        controller: textController,
                        autofocus: true,
                        decoration: const InputDecoration(
                          hintText: 'ชื่องาน',
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(ctx),
                          child: const Text('ยกเลิก'),
                        ),
                        ElevatedButton(
                          onPressed: () =>
                              Navigator.pop(ctx, textController.text.trim()),
                          child: const Text('บันทึก'),
                        ),
                      ],
                    ),
                  );
                  if (newTitle != null && newTitle.isNotEmpty) {
                    context.read<TodoBloc>().add(TodoEdited(todo.id, newTitle));
                  }
                },
              ),
            );
          },
        );
      },
    );
  }
}
