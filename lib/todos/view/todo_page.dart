import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/todo_bloc.dart';
import '../bloc/todo_event.dart';
import 'widgets/todo_list.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final _controller = TextEditingController();

  void _addTodo() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      context.read<TodoBloc>().add(TodoAdded(text));
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do (BLoC)'),
        actions: [
          IconButton(
            tooltip: 'ลบงานที่ทำเสร็จแล้ว',
            onPressed: () =>
                context.read<TodoBloc>().add(const TodosClearedCompleted()),
            icon: const Icon(Icons.clear_all),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onSubmitted: (_) => _addTodo(),
                    decoration: const InputDecoration(
                      hintText: 'เพิ่มงานใหม่...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: _addTodo,
                  icon: const Icon(Icons.add),
                  label: const Text('เพิ่ม'),
                ),
              ],
            ),
          ),
          const Expanded(child: TodoList()),
        ],
      ),
    );
  }
}
