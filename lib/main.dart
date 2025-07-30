import 'package:flutter/material.dart';
import 'package:todo_ic/model/todo.dart';

void main() => runApp(const TodoApp());

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        useMaterial3: true,
      ),
      home: const TodoPage(),
    );
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
    if (title.trim().isEmpty) return;

    setState(() {
      todos.add(Todo(title: title.trim()));
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
      appBar: AppBar(
        title: const Text('My Todos'),
        centerTitle: true,
        backgroundColor: Colors.indigo.shade600,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    key: const Key('todoField'),
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: 'Enter new todo...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  key: const Key('addButton'),
                  onPressed: () => addTodo(controller.text),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),
          Expanded(
            child:
                todos.isEmpty
                    ? const Center(
                      child: Text(
                        'No todos yet 🎉',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                    : ListView.separated(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      itemCount: todos.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final todo = todos[index];
                        return GestureDetector(
                          key: Key('todo_$index'),
                          onTap: () => toggleTodo(index),
                          child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              leading: Icon(
                                todo.isDone
                                    ? Icons.check_circle
                                    : Icons.radio_button_unchecked,
                                color:
                                    todo.isDone
                                        ? Colors.green
                                        : Colors.grey.shade500,
                              ),
                              title: Text(
                                todo.title,
                                style: TextStyle(
                                  fontSize: 16,
                                  decoration:
                                      todo.isDone
                                          ? TextDecoration.lineThrough
                                          : null,
                                  color:
                                      todo.isDone
                                          ? Colors.grey.shade600
                                          : Colors.black87,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
