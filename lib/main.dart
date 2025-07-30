import 'package:flutter/material.dart';
import 'package:todo_ic/model/todo.dart';

void main() => runApp(const TodoApp());

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: TodoPage());
  }
}

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final List<Todo> todos = [];
  final TextEditingController controller = TextEditingController();

  void addTodo(String title) {
    setState(() {
      todos.add(Todo(title: title));
      controller.clear();
    });
  }

  void toggleTodo(int index) {
    setState(() {
      todos[index].isDone = !todos[index].isDone;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo App')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    key: const Key('todoField'),
                    controller: controller,
                    decoration: const InputDecoration(labelText: 'New todo'),
                  ),
                ),
                IconButton(
                  key: const Key('addButton'),
                  icon: const Icon(Icons.add),
                  onPressed: () => addTodo(controller.text),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return ListTile(
                  key: Key('todo_$index'),
                  title: Text(
                    todo.title,
                    style: TextStyle(
                      decoration:
                          todo.isDone ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  onTap: () => toggleTodo(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
